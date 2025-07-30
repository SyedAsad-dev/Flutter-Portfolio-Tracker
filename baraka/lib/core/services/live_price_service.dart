import 'dart:async';
import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:baraka/domain/entities/portfolio_entity.dart';
import 'package:baraka/data/models/instrument_extension.dart';

@lazySingleton
class LivePriceService {
  final _random = Random();
  final _controller = StreamController<PortfolioEntity>.broadcast();
  late List<PositionEntity> _originalPositions;

  // Track previous position-level pnlPercentage
  final Map<String, double> _previousPnLPercentages = {};

  // Track previous balance pnlPercentage
  double _previousBalancePnLPercentage = 0;

  void start(List<PositionEntity> initialPositions) {
    _originalPositions = initialPositions;

    for (var pos in _originalPositions) {
      _previousPnLPercentages[pos.instrument.ticker] = pos.pnlPercentage;
    }

    _previousBalancePnLPercentage =
        _calculateBalancePnlPercentage(_originalPositions);

    Timer.periodic(Duration(seconds: 1), (_) {
      final updatedPositions = _originalPositions.map((pos) {
        final ticker = pos.instrument.ticker;
        final previous = _previousPnLPercentages[ticker] ?? pos.pnlPercentage;

        final changePercent = (_random.nextDouble() * 0.2) - 0.1; // ±10%
        final newPrice = pos.instrument.lastTradedPrice * (1 + changePercent);

        final marketValue = pos.quantity * newPrice;
        final pnl = marketValue - pos.cost;
        final pnlPercentage = (pnl * 100) / pos.cost;

        final isIncreased = pnlPercentage > previous;
        _previousPnLPercentages[ticker] = pnlPercentage;

        return PositionEntity(
          instrument: pos.instrument.copyWith(lastTradedPrice: newPrice),
          quantity: pos.quantity,
          averagePrice: pos.averagePrice,
          cost: pos.cost,
          marketValue: marketValue,
          pnl: pnl,
          pnlPercentage: pnlPercentage,
          isPnlIncreased: isIncreased,
        );
      }).toList();

      final newBalance = _calculateBalance(updatedPositions);

      final isBalanceIncreased =
          newBalance.pnlPercentage > _previousBalancePnLPercentage;

      // Update after comparison
      _previousBalancePnLPercentage = newBalance.pnlPercentage;

      final updatedBalance = BalanceEntity(
        netValue: newBalance.netValue,
        pnl: newBalance.pnl,
        pnlPercentage: newBalance.pnlPercentage,
        isPnlIncreased: isBalanceIncreased,
      );

      _controller.add(PortfolioEntity(
        balance: updatedBalance,
        positions: updatedPositions,
      ));
    });
  }

  Stream<PortfolioEntity> get portfolioStream => _controller.stream;

  double getPreviousPnLPercentage(String ticker) =>
      _previousPnLPercentages[ticker] ?? 0;

  double getPreviousBalancePnLPercentage() => _previousBalancePnLPercentage;

  BalanceEntity _calculateBalance(List<PositionEntity> positions) {
    double totalCost = 0;
    double totalMarketValue = 0;
    double totalPnL = 0;

    for (var pos in positions) {
      totalCost += pos.cost;
      totalMarketValue += pos.marketValue;
      totalPnL += pos.pnl;
    }

    final pnlPercentage = totalCost == 0 ? 0 : (totalPnL * 100) / totalCost;

    return BalanceEntity(
      netValue: totalMarketValue,
      pnl: totalPnL,
      pnlPercentage: pnlPercentage.toDouble(),
      isPnlIncreased: false, // Placeholder, actual value set in start()
    );
  }

  double _calculateBalancePnlPercentage(List<PositionEntity> positions) {
    double totalCost = 0;
    double totalPnL = 0;

    for (var pos in positions) {
      totalCost += pos.cost;
      totalPnL += pos.pnl;
    }

    return totalCost == 0 ? 0 : (totalPnL * 100) / totalCost;
  }
}
