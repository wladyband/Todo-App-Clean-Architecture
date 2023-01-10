import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/injection.config.dart';

final sl = GetIt.I; // sl == service locator

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> init() async {
  $initGetIt(sl);
}
