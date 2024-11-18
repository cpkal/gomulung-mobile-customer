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
                  child: Column(children: [
                    for (var weightType in state.weight_types_list!)
                      GestureDetector(
                        onTap: () {
                          context
                              .read<OrderBloc>()
                              .add(SelectWeightType(weightType.name!));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.weight_type == weightType.name
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weightType.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                weightType.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
