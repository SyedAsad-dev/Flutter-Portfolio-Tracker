import 'position_model.dart';

class BalanceModel {
  final double netValue;
  final double pnl;
  final double pnlPercentage;

  BalanceModel({
    required this.netValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      netValue: (json['netValue'] ?? 0).toDouble(),
      pnl: (json['pnl'] ?? 0).toDouble(),
      pnlPercentage: (json['pnlPercentage'] ?? 0).toDouble(),
    );
  }
}

class PortfolioModel {
  final BalanceModel balance;
  final List<PositionModel> positions;

  PortfolioModel({
    required this.balance,
    required this.positions,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      balance: BalanceModel.fromJson(json['balance']),
      positions: (json['positions'] as List)
          .map((e) => PositionModel.fromJson(e))
          .toList(),
    );
  }
}
