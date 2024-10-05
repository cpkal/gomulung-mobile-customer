import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/widget/orders/panel/order_panel.dart';

class SelectWeightTypePanel extends StatelessWidget {
  final Function() onTap;

  const SelectWeightTypePanel({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return OrderPanel(
          child: Column(
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
                    onPressed: onTap,
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //select payment method
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
