import 'package:baraka/core/services/live_price_service.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:baraka/domain/entities/portfolio_entity.dart';
import 'package:baraka/domain/usecases/get_portfolio_usecase.dart';
import 'package:injectable/injectable.dart';

part 'portfolio_state.dart';

@injectable
class PortfolioCubit extends Cubit<PortfolioState> {
  final GetPortfolioUseCase getPortfolioUseCase;
  final LivePriceService livePriceService;

  PortfolioCubit(this.getPortfolioUseCase, this.livePriceService)
      : super(PortfolioInitial());

  Future<void> fetchPortfolio() async {
    emit(PortfolioLoading());
    try {
      final portfolio = await getPortfolioUseCase();

      // Start the live price updates
      livePriceService.start(portfolio.positions);

      // Listen for live updates
      livePriceService.portfolioStream.listen((updatedPortfolio) {
        emit(PortfolioLoaded(updatedPortfolio));
      });
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio'));
    }
  }
}
