import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectTrashType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return OrderCard(
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
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Rumahan': val}));
                      },
                      selected: state.trash_type?['Rumahan'] ?? false),
                  ChoiceChip(
                      label: Text('Logam'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Logam': val}));
                      },
                      selected: state.trash_type?['Logam'] ?? false),
                  ChoiceChip(
                      label: Text('Kertas'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Kertas': val}));
                      },
                      selected: state.trash_type?['Kertas'] ?? false),
                  ChoiceChip(
                      label: Text('Pakaian'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Pakaian': val}));
                      },
                      selected: state.trash_type?['Pakaian'] ?? false),
                  ChoiceChip(
                      label: Text('Kardus'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Kardus': val}));
                      },
                      selected: state.trash_type?['Kardus'] ?? false),
                  ChoiceChip(
                      label: Text('Lainnya'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Lainnya': val}));
                      },
                      selected: state.trash_type?['Lainnya'] ?? false),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
