class InstrumentModel {
  final String ticker;
  final String name;
  final String exchange;
  final String currency;
  final double lastTradedPrice;

  InstrumentModel({
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.lastTradedPrice,
  });

  factory InstrumentModel.fromJson(Map<String, dynamic> json) {
    return InstrumentModel(
      ticker: json['ticker'] ?? '',
      name: json['name'] ?? '',
      exchange: json['exchange'] ?? '',
      currency: json['currency'] ?? '',
      lastTradedPrice: (json['lastTradedPrice'] ?? 0).toDouble(),
    );
  }
}
