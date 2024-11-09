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
                // alignment: WrapAlignment.,
                // crossAxisAlignment: WrapCrossAlignment.,
                children: [
                  ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide(color: Colors.grey),
                      label: Text('Rumahan'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Rumahan': val}));
                      },
                      selected: state.trash_type?['Rumahan'] ?? false),
                  ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide(color: Colors.grey),
                      label: Text('Komersil'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Komersil': val}));
                      },
                      selected: state.trash_type?['Komersil'] ?? false),
                  ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide(color: Colors.grey),
                      label: Text('Pertanian'),
                      onSelected: (val) {
                        context
                            .read<OrderBloc>()
                            .add(OrderTrashTypeChanged({'Pertanian': val}));
                      },
                      selected: state.trash_type?['Pertanian'] ?? false),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
