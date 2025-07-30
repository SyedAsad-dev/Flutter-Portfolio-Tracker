import 'package:injectable/injectable.dart';

import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

@injectable
class GetPortfolioUseCase {
  final PortfolioRepository repository;

  GetPortfolioUseCase(this.repository);

  Future<PortfolioEntity> call() async {
    return await repository.getPortfolio();
  }
}
