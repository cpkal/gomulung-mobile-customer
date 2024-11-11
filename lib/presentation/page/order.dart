import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        context.read<OrderBloc>().add(OrderImagePathChanged(_image!.path));
      } else {
        print('No image selected.');
      }
    });
  }

  void _handleSubmit(BuildContext context, OrderState state) {
    print(state.address);
    print(state.position);
    print(state.weight_type);
    print(state.trash_type);
    if (state.address == null ||
        state.position == null ||
        state.weight_type == null ||
        state.trash_type == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Isi form yang dibutuhkan'),
        ),
      );
      return;
    }

    context.read<OrderBloc>().add(OrderSubmitted());
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

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BlocProvider.value(
                        value: context.read<WebsocketBloc>(),
                        child: FindDriverPage(
                          order: state.order,
                        ),
                      ),
                      withNavBar: false,
                    );
                  } else if (state is OrderFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Order Failed'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
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
                                SelectTrashType(),
                                SizedBox(height: 20),
                                SelectPaymentMethod(onTap: () {}),
                                SizedBox(
                                  height: 20,
                                ),
                                ShowRingkasanAngkutan(),
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
              Positioned(
                bottom: 10,
                //center
                left: 20,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        _handleSubmit(context, context.read<OrderBloc>().state),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Rp. 8.000'),
                            Text('|'),
                            Text('Pesan')
                          ],
                        )),
                  ),
                ),
              ),

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
