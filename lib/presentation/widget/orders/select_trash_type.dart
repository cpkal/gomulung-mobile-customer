import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectTrashType extends StatefulWidget {
  const SelectTrashType({Key? key}) : super(key: key);

  @override
  _SelectTrashTypeState createState() => _SelectTrashTypeState();
}

class _SelectTrashTypeState extends State<SelectTrashType> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<OrderBloc>().add(OrderFetchTrashTypes());
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<OrderBloc>().state is TrashTypesLoading) {
      return OrderCard(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (context.read<OrderBloc>().state is TrashTypesLoaded) {
      return _buildTrashType();
    }

    return OrderCard(
      child: Center(
        child: Text('Gagal memuat jenis sampah'),
      ),
    );
  }

  Widget _buildTrashType() {
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
                  selected:
                      context.read<OrderBloc>().state.trash_type?['Rumahan'] ??
                          false),
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
                  selected:
                      context.read<OrderBloc>().state.trash_type?['Komersil'] ??
                          false),
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
                  selected: context
                          .read<OrderBloc>()
                          .state
                          .trash_type?['Pertanian'] ??
                      false),
            ],
          )
        ],
      ),
    );
  }
}
