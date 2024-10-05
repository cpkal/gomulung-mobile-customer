import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/myaccount.dart';
import 'package:las_customer/presentation/page/order.dart';
import 'package:las_customer/presentation/page/orderProcess.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class SubRootPage extends StatefulWidget {
  @override
  _SubRootPageState createState() => _SubRootPageState();
}

class _SubRootPageState extends State<SubRootPage> {
  _SubRootPageState();

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    context.read<WebsocketBloc>().add(WebsocketConnect());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      onItemSelected: (value) {
        if (value == 1) {
          context.read<OrderBloc>().add(FetchOrders());
        }
      },
      screens: _buildScreens(),
      items: _navBarsItems(context),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: _navBarStyle,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    OrderPage(),
    OrderProcessPage(),
    MyAccountPage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.pin_drop),
      inactiveIcon: Icon(Icons.pin_drop_outlined),
      title: ("Pesan"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.onSurface,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.map),
      inactiveIcon: Icon(Icons.map_outlined),
      title: ("Proses"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.onSurface,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.person),
      inactiveIcon: Icon(Icons.person_outline),
      title: ("Akun"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.onSurface,
    ),
  ];
}

NavBarStyle _navBarStyle =
    NavBarStyle.style3; // Choose the nav bar style with this property
