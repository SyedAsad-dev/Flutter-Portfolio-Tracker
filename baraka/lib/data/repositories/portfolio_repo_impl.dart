import 'package:baraka/data/datasources/portfolio_remote_ds.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/portfolio_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';

import '../models/portfolio_model.dart';

@LazySingleton(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl(this.remoteDataSource);

  @override
  Future<PortfolioEntity> getPortfolio() async {
    final PortfolioModel model = await remoteDataSource.fetchPortfolio();

    return PortfolioEntity(
      balance: BalanceEntity(
        netValue: model.balance.netValue,
        pnl: model.balance.pnl,
        pnlPercentage: model.balance.pnlPercentage,
      ),
      positions: model.positions
          .map((p) => PositionEntity(
                instrument: InstrumentEntity(
                  ticker: p.instrument.ticker,
                  name: p.instrument.name,
                  exchange: p.instrument.exchange,
                  currency: p.instrument.currency,
                  lastTradedPrice: p.instrument.lastTradedPrice,
                ),
                quantity: p.quantity,
                averagePrice: p.averagePrice,
                cost: p.cost,
                marketValue: p.marketValue,
                pnl: p.pnl,
                pnlPercentage: p.pnlPercentage,
              ))
          .toList(),
    );
  }
}
