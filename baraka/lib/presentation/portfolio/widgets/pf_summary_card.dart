import 'package:baraka/domain/entities/portfolio_entity.dart';
import 'package:flutter/material.dart';

class PortfolioSummary extends StatelessWidget {
  final BalanceEntity balance;

  const PortfolioSummary({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffe2fdfe)),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.red),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text("John Doe",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    balance.netValue.toStringAsFixed(2),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        balance.pnl.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${balance.isPnlIncreased! ? "+" : "-"}${balance.pnlPercentage.toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: balance.isPnlIncreased!
                                ? Colors.green
                                : Colors.red),
                      ),
                      Text(
                        ")",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Net Value",
                    style: TextStyle(fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    "PnL (PnL%)",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
