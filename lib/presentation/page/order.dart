import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/data/model/order.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/find_driver.dart';
import 'package:las_customer/presentation/widget/orders/panel/select_payment_method_panel.dart';
import 'package:las_customer/presentation/widget/orders/panel/select_weight_type.dart';
import 'package:las_customer/presentation/widget/orders/pick_location.dart';
import 'package:las_customer/presentation/widget/orders/select_payment_method.dart';
import 'package:las_customer/presentation/widget/orders/select_total_weight.dart';
import 'package:las_customer/presentation/widget/orders/select_trash_type.dart';
import 'package:las_customer/presentation/widget/orders/show_ringkasan_angkutan.dart';
import 'package:las_customer/presentation/widget/orders/take_picture_trash.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:image_picker/image_picker.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late bool _showPaymentMethodPanel = false;
  late bool _showSelectedWeightTypePanel = false;

  bool isLocationSelected = false;
  bool isWeightSelected = false;
  bool isTrashTypeSelected = false;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        context.read<OrderBloc>().add(TakeOrderPhoto(_image!.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void didUpdateWidget(covariant OrderPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buang Sampah'),
      ),
      body: BlocBuilder<WebsocketBloc, WebsocketState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderSuccess) {
                    String jsonString = _encodeRequestOrderMessage(state);

                    context
                        .read<WebsocketBloc>()
                        .add(WebsocketSend(jsonString));

                    if (!ModalRoute.of(context)!.isCurrent) {
                      return; // Prevent further navigation
                    }

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BlocProvider.value(
                        value: context.read<WebsocketBloc>(),
                        child: BlocProvider.value(
                          value: context.read<OrderBloc>(),
                          child: FindDriverPage(
                            order: state.order,
                          ),
                        ),
                      ),
                      withNavBar: false,
                    ).then((_) {
                      //re fetch options
                      context.read<OrderBloc>().add(OrderFetchTrashTypes());
                    });
                  } else if (state is OrderFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Order Failed'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  // print(state.is_button_enabled);
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PickLocation(),
                                SizedBox(
                                  height: 20,
                                ),
                                TakePictureTrash(
                                    image: _image, onTap: _getImageFromCamera),
                                SizedBox(
                                  height: 20,
                                ),
                                SelectTotalWeight(
                                  onTap: () {
                                    setState(() {
                                      _showSelectedWeightTypePanel =
                                          !_showSelectedWeightTypePanel;
                                    });
                                  },
                                  state: state,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SelectTrashTypeScreen(),
                                // SizedBox(height: 20),
                                // SelectPaymentMethod(onTap: () {}),
                                SizedBox(
                                  height: 20,
                                ),
                                // ShowRingkasanAngkutan(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              //orderbloc builder
              BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                print('xdding');
                print(state.is_button_enabled);
                return Positioned(
                  bottom: 10,
                  //center
                  left: 20,
                  right: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: state.is_button_enabled
                          ? () {
                              context.read<OrderBloc>().add(SubmitOrder());
                            }
                          : null,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //if location selected, weight selected, and trash type selected show price
                              if (state.is_button_enabled)
                                Text('Rp. ${state.price_total}'),

                              Text('|'),
                              Text('Pesan')
                            ],
                          )),
                    ),
                  ),
                );
              }),

              //panel to select payment method
              if (_showPaymentMethodPanel) _buildPaymentMethodPanel(),
              if (_showSelectedWeightTypePanel) _buildSelectWeightPanel(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaymentMethodPanel() {
    return SelectPaymentMethodPanel(onPressed: () {
      setState(() {
        _showPaymentMethodPanel = false;
      });
    });
  }

  Widget _buildSelectWeightPanel() {
    return SelectWeightTypePanel(onTap: () {
      setState(() {
        _showSelectedWeightTypePanel = false;
      });
    });
  }

  String _encodeRequestOrderMessage(OrderSuccess state) {
    return jsonEncode({
      "event": "request_order",
      "data": {
        "user_id": state.order.userId,
        "pickup_location": {
          "lat": state.order.pickupLocation!.coordinates?[1],
          "long": state.order.pickupLocation!.coordinates?[0]
        },
        "order_id": state.order.id,
      }
    });
  }
}
