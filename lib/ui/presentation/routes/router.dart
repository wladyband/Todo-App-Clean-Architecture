import 'package:auto_route/annotations.dart';
import 'package:todo/ui/presentation/home/home_page.dart';
import 'package:todo/ui/presentation/signup/signup_page.dart';


@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SignUpPage, initial: true),
    AutoRoute(page: HomePage, initial: false),
  ],
)
class $AppRouter {}