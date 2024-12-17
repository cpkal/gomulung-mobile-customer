import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/point/point_bloc.dart';
import 'package:las_customer/presentation/page/sellTrash.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/show_ringkasan_angkutan.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ExchangePointPage extends StatelessWidget {
  TextEditingController pointController = TextEditingController();
  String bank = '';
  TextEditingController atasNamaController = TextEditingController();
  TextEditingController noRekController = TextEditingController();

  // formkey
  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<PointBloc>().add(
            ConvertPoint(int.parse(pointController.text), bank,
                atasNamaController.text, noRekController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Tukar Poin'),
        ),
        body: BlocListener<PointBloc, PointState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error!),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Berhasil tukar poin'),
              ));

              // wait two seconds and then pop context
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            }
          },
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tukar Poin',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: pointController,
                        decoration: InputDecoration(
                          labelText: 'Jumlah Poin',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Jumlah poin tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      // bank tujuan
                      SizedBox(
                        height: 20,
                      ),
                      // dropdown buttons for bank options
                      DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(10),
                        validator: (value) {
                          if (value == null) {
                            return 'Bank tujuan tidak boleh kosong';
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Bank BCA'),
                            value: 'bca',
                          ),
                          DropdownMenuItem(
                            child: Text('Bank Mandiri'),
                            value: 'mandiri',
                          ),
                          DropdownMenuItem(
                            child: Text('Bank BNI'),
                            value: 'bni',
                          ),
                          DropdownMenuItem(
                            child: Text('Bank BRI'),
                            value: 'bri',
                          ),
                          DropdownMenuItem(
                            child: Text('OVO'),
                            value: 'ovo',
                          ),
                          DropdownMenuItem(
                            child: Text('DANA'),
                            value: 'dana',
                          ),
                          DropdownMenuItem(
                            child: Text('GoPay'),
                            value: 'gopay',
                          ),
                        ],
                        onChanged: (value) {
                          bank = value.toString();
                        },
                        decoration: InputDecoration(
                          labelText: 'Bank Tujuan',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: atasNamaController,
                        decoration: InputDecoration(
                          labelText: 'Atas Nama',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Atas nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: noRekController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Rekening / Nomor Handphone',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nomor rekening tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                //center
                left: 20,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm(context);
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text('Tukar Poin')],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
