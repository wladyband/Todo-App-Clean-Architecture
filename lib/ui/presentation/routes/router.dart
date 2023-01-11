import 'package:auto_route/annotations.dart';
import 'package:todo/ui/presentation/home/home_page.dart';
import 'package:todo/ui/presentation/signup/signup_page.dart';
import 'package:todo/ui/presentation/splash/splash_page.dart';


@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: HomePage, initial: false),
  ],
)
class $AppRouter {}