import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/page_router.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/core/util/app_theme.dart';
import 'package:las_customer/data/repository/authentication_repository.dart';
import 'package:las_customer/data/repository/user.dart';
import 'package:las_customer/presentation/bloc/web_socket/web_socket_bloc.dart';
import 'package:las_customer/presentation/bloc/login/login_bloc.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          BlocProvider(create: (context) => WebSocketBloc()),
        ],
        child: MaterialApp(
          title: 'LAS Customer Application',
          theme: appTheme(),
          initialRoute: RoutePaths.askLoginOrRegister,
          onGenerateRoute: PageRouter.generateRoute,
          navigatorObservers: [routeObserver],
        ),
      ),
    );
  }
}
