import 'package:baraka/domain/entities/portfolio_entity.dart';

extension InstrumentCopy on InstrumentEntity {
  InstrumentEntity copyWith({
    double? lastTradedPrice,
  }) {
    return InstrumentEntity(
      ticker: ticker,
      name: name,
      exchange: exchange,
      currency: currency,
      lastTradedPrice: lastTradedPrice ?? this.lastTradedPrice,
    );
  }
}
