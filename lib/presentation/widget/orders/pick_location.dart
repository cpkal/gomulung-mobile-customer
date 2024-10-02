import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PickLocation extends StatelessWidget {
  const PickLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderCard(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MapPage(),
          withNavBar: false,
        );
      },
      child: Row(
        children: [
          //container circle dot
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          BlocConsumer<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapPositionPicked) {
                context.read<MapBloc>().add(GetAddressFromPosition(
                    LatLng(state.position.latitude, state.position.longitude)));
              }

              if (state is AddressFromPosition) {
                context
                    .read<OrderBloc>()
                    .add(OrderAddressChanged(state.address));
              }
            },
            builder: (context, state) {
              if (state is AddressFromPosition) {
                return Flexible(
                  child: Text(
                    state.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else {
                return Text(
                  'Lokasi Anda',
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),

          //grid 5 items
        ],
      ),
    );
  }
}
