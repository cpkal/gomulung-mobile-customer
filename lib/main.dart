import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/page_router.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/core/util/app_theme.dart';
import 'package:las_customer/core/util/secure_storage.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/datasource/remote/web_socket_service.dart';
import 'package:las_customer/data/repository/authentication_repository.dart';
import 'package:las_customer/data/repository/user.dart';
import 'package:las_customer/presentation/bloc/crew/crew_bloc.dart';
import 'package:las_customer/presentation/bloc/login/login_bloc.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/register/register_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/ask_login_register.dart';
import 'package:las_customer/presentation/page/sub_root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _secureStorage = SecureStorage();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool isAuthenticated = false;
  bool isTokenReaded = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    String? value = await _secureStorage.readSecureData(key: 'token');

    if (value != null) {
      final response =
          await ApiService.postData('/auth/verify-token-expiration', {
        'token': value,
      });

      if (response.statusCode == 200) {
        setState(() {
          isAuthenticated = true;
        });
      } else if (response.statusCode == 400) {
        await _secureStorage.deleteSecureData(key: 'token');
      }
    }

    setState(() {
      isTokenReaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isTokenReaded) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider<CustomerRepository>(
          create: (context) => CustomerRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(create: (context) => MapBloc()),
          BlocProvider(create: (context) => OrderBloc()),
          BlocProvider(create: (context) => CrewBloc())
        ],
        child: MaterialApp(
          title: 'LAS Customer Application',
          theme: appTheme(),
          initialRoute: isAuthenticated
              ? RoutePaths.subRoot
              : RoutePaths.askLoginOrRegister,
          onGenerateRoute: PageRouter.generateRoute,
          navigatorObservers: [routeObserver],
        ),
      ),
    );
  }
}
