import '../entities/portfolio_entity.dart';

abstract class PortfolioRepository {
  Future<PortfolioEntity> getPortfolio();
}
