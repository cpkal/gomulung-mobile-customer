import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:las_customer/presentation/widget/orders/panel/select_payment_method_panel.dart';
import 'package:las_customer/presentation/widget/orders/panel/select_total_weight_panel.dart';
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
  late bool _showPaymentMethod = false;
  late bool _showTotalWeight = false;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _handleSubmit(BuildContext context) {
    // context.read<OrderBloc>().add(
    //       OrderSubmitted(),
    //     );
    context.read<WebsocketBloc>().add(WebsocketConnect());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigator.pushNamed(context, RoutePaths.myAccount);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) => {
              if (state is OrderSuccess)
                {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MapPage(toDo: 'ORDER'),
                    withNavBar: false,
                  )
                }
              else if (state is OrderFailed)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order Failed'),
                    ),
                  ),
                }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    // height: 130,
                    child: Padding(
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
                                _showTotalWeight = !_showTotalWeight;
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
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 10,
            //center
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () => _handleSubmit(context),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Rp. 8.000'), Text('|'), Text('Pesan')],
                    )),
              ),
            ),
          ),

          //panel to select payment method
          if (_showPaymentMethod) _buildPaymentMethodPanel(),
          if (_showTotalWeight) _buildTotalWeightPanel(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodPanel() {
    return SelectPaymentMethodPanel(onPressed: () {
      setState(() {
        _showPaymentMethod = false;
      });
    });
  }

  Widget _buildTotalWeightPanel() {
    return SelectTotalWeightPanel(onTap: () {
      setState(() {
        _showTotalWeight = false;
      });
    });
  }
}
