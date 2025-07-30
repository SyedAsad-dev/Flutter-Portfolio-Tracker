// lib/injection.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart'; // ✅ you now have this

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // 👈 MUST match the generated name
  preferRelativeImports: true,
)
Future<void> configureDependencies() async => getIt.$initGetIt();
