import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectTrashTypeScreen extends StatefulWidget {
  const SelectTrashTypeScreen({Key? key}) : super(key: key);

  @override
  _SelectTrashTypeState createState() => _SelectTrashTypeState();
}

class _SelectTrashTypeState extends State<SelectTrashTypeScreen> {
  bool _isTrashTypeLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchTrashTypes();
  }

  void _fetchTrashTypes() async {
    context.read<OrderBloc>().add(OrderFetchTrashTypes());
    setState(() {
      _isTrashTypeLoaded = true;
    });
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

    if (_isTrashTypeLoaded) {
      return _buildTrashType();
    } else {
      return OrderCard(
        child: Column(
          children: [
            Text('Tidak dapat mengambil jenis sampah'),
            ElevatedButton(
              onPressed: _fetchTrashTypes,
              child: Text('Coba lagi'),
            )
          ],
        ),
      );
    }
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
              //convert map to list
              for (var trashType in context
                  .read<OrderBloc>()
                  .state
                  .trash_type
                  ?.keys
                  .toList() as List<String>)
                ChoiceChip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: BorderSide(color: Colors.grey),
                  label: Text(trashType),
                  onSelected: (val) {
                    Map<String, bool> newMap = {
                      ...context.read<OrderBloc>().state.trash_type!,
                    };

                    //set other chips to false
                    for (var key in newMap.keys) {
                      if (key != trashType) {
                        newMap[key] = false;
                      }
                    }

                    newMap[trashType] = val;

                    print('heiya');
                    print(newMap);

                    context.read<OrderBloc>().add(SelectTrashType(newMap));
                  },
                  selected:
                      context.read<OrderBloc>().state.trash_type?[trashType] ??
                          false,
                ),
            ],
          )
        ],
      ),
    );
  }
}
