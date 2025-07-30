class BalanceEntity {
  final double netValue;
  final double pnl;
  final double pnlPercentage;
  final bool? isPnlIncreased;

  BalanceEntity({
    required this.netValue,
    required this.pnl,
    required this.pnlPercentage,
    this.isPnlIncreased,
  });
}

class InstrumentEntity {
  final String ticker;
  final String name;
  final String exchange;
  final String currency;
  final double lastTradedPrice;

  InstrumentEntity({
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.lastTradedPrice,
  });
}

class PositionEntity {
  final InstrumentEntity instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double pnl;
  final double pnlPercentage;
  final bool? isPnlIncreased;

  PositionEntity(
      {required this.instrument,
      required this.quantity,
      required this.averagePrice,
      required this.cost,
      required this.marketValue,
      required this.pnl,
      required this.pnlPercentage,
      this.isPnlIncreased});
}

class PortfolioEntity {
  final BalanceEntity balance;
  final List<PositionEntity> positions;

  PortfolioEntity({
    required this.balance,
    required this.positions,
  });
}
