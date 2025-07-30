// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'application/portfolio/cubit/portfolio_cubit.dart' as _i86;
import 'core/di/app_module.dart' as _i808;
import 'core/services/live_price_service.dart' as _i582;
import 'data/datasources/portfolio_remote_ds.dart' as _i431;
import 'data/repositories/portfolio_repo_impl.dart' as _i389;
import 'domain/repositories/portfolio_repository.dart' as _i73;
import 'domain/usecases/get_portfolio_usecase.dart' as _i569;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i582.LivePriceService>(() => _i582.LivePriceService());
    gh.lazySingleton<_i431.PortfolioRemoteDataSource>(
        () => _i431.PortfolioRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i86.PortfolioCubit>(() => _i86.PortfolioCubit(
          gh<_i569.GetPortfolioUseCase>(),
          gh<_i582.LivePriceService>(),
        ));
    gh.lazySingleton<_i73.PortfolioRepository>(() =>
        _i389.PortfolioRepositoryImpl(gh<_i431.PortfolioRemoteDataSource>()));
    gh.factory<_i569.GetPortfolioUseCase>(
        () => _i569.GetPortfolioUseCase(gh<_i73.PortfolioRepository>()));
    return this;
  }
}

class _$AppModule extends _i808.AppModule {}
