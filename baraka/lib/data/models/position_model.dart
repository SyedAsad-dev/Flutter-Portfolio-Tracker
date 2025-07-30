import 'instrument_model.dart';

class PositionModel {
  final InstrumentModel instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double pnl;
  final double pnlPercentage;

  PositionModel({
    required this.instrument,
    required this.quantity,
    required this.averagePrice,
    required this.cost,
    required this.marketValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      instrument: InstrumentModel.fromJson(json['instrument']),
      quantity: (json['quantity'] ?? 0).toDouble(),
      averagePrice: (json['averagePrice'] ?? 0).toDouble(),
      cost: (json['cost'] ?? 0).toDouble(),
      marketValue: (json['marketValue'] ?? 0).toDouble(),
      pnl: (json['pnl'] ?? 0).toDouble(),
      pnlPercentage: (json['pnlPercentage'] ?? 0).toDouble(),
    );
  }
}
