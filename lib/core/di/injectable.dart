import 'package:get_it/get_it.dart';
import 'package:github/core/di/injectable.config.dart';
import 'package:injectable/injectable.dart';

final GetIt sl = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => sl.init();
