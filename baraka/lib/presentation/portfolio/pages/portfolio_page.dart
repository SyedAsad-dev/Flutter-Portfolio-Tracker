import 'package:baraka/presentation/portfolio/widgets/pf_summary_card.dart';
import 'package:baraka/presentation/portfolio/widgets/position_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baraka/application/portfolio/cubit/portfolio_cubit.dart';
import 'package:baraka/injection.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PortfolioCubit>()..fetchPortfolio(),
      child: Scaffold(
        body: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            if (state is PortfolioLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PortfolioLoaded) {
              final portfolio = state.portfolio;
              return Column(
                children: [
                  // Balance Summary
                  PortfolioSummary(balance: portfolio.balance),
                  // Positions List
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemCount: portfolio.positions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final position = portfolio.positions[index];
                        return PositionCard(position: position);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is PortfolioError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
