import 'package:flutter/material.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/page/ask_login_register.dart';
import 'package:las_customer/presentation/page/chat.dart';
import 'package:las_customer/presentation/page/forgot_password.dart';
import 'package:las_customer/presentation/page/login.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:las_customer/presentation/page/order.dart';
import 'package:las_customer/presentation/page/register_input_account.dart';
import 'package:las_customer/presentation/page/register_verify_email.dart';
import 'package:las_customer/presentation/page/sub_root.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OrderPage());
      case RoutePaths.askLoginOrRegister:
        return MaterialPageRoute(builder: (_) => AskLoginRegisterPage());
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutePaths.registerInputAccount:
        return MaterialPageRoute(builder: (_) => RegisterInputAccountPage());
      case RoutePaths.registerVerifyEmail:
        return MaterialPageRoute(builder: (_) => RegisterVerifyEmailPage());
      case RoutePaths.subRoot:
        return MaterialPageRoute(builder: (_) => SubRootPage());
      case RoutePaths.map:
        return MaterialPageRoute(builder: (_) => MapPage());
      case RoutePaths.chat:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case RoutePaths.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
