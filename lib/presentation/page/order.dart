import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/model/repository/authentication_repository.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/page/map.dart';
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
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MapPage(toDo: 'PICK_LOCATION'),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                          BlocBuilder<MapBloc, MapState>(
                            builder: (context, state) {
                              if (state is MapPositionUpdate) {
                                return Flexible(
                                  child: Text(
                                    state.position.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                    ),
                  ),
                  Expanded(
                    // height: 130,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   _showTotalWeight = !_showTotalWeight;
                              // });
                              _getImageFromCamera();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Foto sampahmu (opsional)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _image != null
                                          ? Text("Diambil")
                                          : Text(''),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showTotalWeight = !_showTotalWeight;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.browse_gallery_rounded,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Berat total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          state.weight_type == 'Kecil'
                                              ? 'Kecil 5kg'
                                              : state.weight_type == 'Sedang'
                                                  ? 'Sedang 10kg'
                                                  : 'Besar 20kg',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      //icon arrow next
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 12,
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jenis sampahmu apa?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 5.0,
                                  alignment: WrapAlignment.spaceAround,
                                  // crossAxisAlignment: WrapCrossAlignment.,
                                  children: [
                                    ChoiceChip(
                                        label: Text('Rumahan'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Rumahan': val}));
                                        },
                                        selected:
                                            state.trash_type?['Rumahan'] ??
                                                false),
                                    ChoiceChip(
                                        label: Text('Logam'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Logam': val}));
                                        },
                                        selected: state.trash_type?['Logam'] ??
                                            false),
                                    ChoiceChip(
                                        label: Text('Kertas'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Kertas': val}));
                                        },
                                        selected: state.trash_type?['Kertas'] ??
                                            false),
                                    ChoiceChip(
                                        label: Text('Pakaian'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Pakaian': val}));
                                        },
                                        selected:
                                            state.trash_type?['Pakaian'] ??
                                                false),
                                    ChoiceChip(
                                        label: Text('Kardus'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Kardus': val}));
                                        },
                                        selected: state.trash_type?['Kardus'] ??
                                            false),
                                    ChoiceChip(
                                        label: Text('Lainnya'),
                                        onSelected: (val) {
                                          context.read<OrderBloc>().add(
                                              OrderTrashTypeChanged(
                                                  {'Lainnya': val}));
                                        },
                                        selected:
                                            state.trash_type?['Lainnya'] ??
                                                false),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   _showPaymentMethod = !_showPaymentMethod;
                              // });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.attach_money),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Metode pembayaran',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('TUNAI',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _buildRingkasanAngkutan(),
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
                onPressed: () {
                  //push and remove all prev routes
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MapPage(toDo: 'ORDER'),
                    withNavBar: false,
                  );
                },
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
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          //border radius top right and left top
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          //border grey
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Mau bayar pake apa nih?',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Pilih metode pembayaran yang paling mudah buat kamu',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade400))
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showPaymentMethod = false;
                      });
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //select payment method
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.attach_money_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Tunai',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
                        width: 75)
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //simpan
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showPaymentMethod = false;
                    });
                  },
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalWeightPanel() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              //border radius top right and left top
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              //border grey
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Sampahmu seberapa banyak nih?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'Ini akan membantu kru kami untuk menyesuaikan angkutan',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey.shade400))
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _showTotalWeight = false;
                              });
                            },
                            icon: Icon(Icons.close),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //select payment method
                      GestureDetector(
                        onTap: () {
                          context
                              .read<OrderBloc>()
                              .add(OrderWeightTypeChanged('Kecil'));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.weight_type == 'Kecil'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kecil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text('maks 5kg.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<OrderBloc>()
                              .add(OrderWeightTypeChanged('Sedang'));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.weight_type == 'Sedang'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sedang',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text('maks 10kg.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<OrderBloc>()
                              .add(OrderWeightTypeChanged('Besar'));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.weight_type == 'Besar'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Besar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text('maks 20kg.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRingkasanAngkutan() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Angkutan',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),

          //organic trash 2kg price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Berat sampah Kecil (maks 5kg)'),
              Text('Rp. 2.000'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Biaya angkut'),
              Text('Rp. 6.000'),
            ],
          ),
          //line separator dot
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Total Bayar'),
              Text('Rp. 8.000'),
            ],
          ),
        ],
      ),
    );
  }
}
