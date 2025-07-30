import 'package:baraka/domain/entities/portfolio_entity.dart';
import 'package:flutter/material.dart';

class PositionCard extends StatelessWidget {
  final PositionEntity position;

  const PositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final instrument = position.instrument;
    final pos = position.quantity * position.averagePrice;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    instrument.ticker,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        position.pnl.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${position.isPnlIncreased! ? "+" : "-"}${position.pnlPercentage.toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: position.isPnlIncreased!
                                ? Colors.green
                                : Colors.red),
                      ),
                      Text(
                        ")",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${instrument.currency} ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    instrument.lastTradedPrice.toStringAsFixed(2),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "${position.quantity.toStringAsFixed(2)} X ${position.averagePrice.toStringAsFixed(2)} = ${pos.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              Text(instrument.name, style: const TextStyle(color: Colors.grey)),
              Row(
                children: [
                  Text(instrument.exchange,
                      style: const TextStyle(color: Colors.grey)),
                  Spacer(),
                  Text(
                    position.marketValue.toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 4, decoration: BoxDecoration(color: Colors.grey))
      ],
    );
  }
}
