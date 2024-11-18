import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectTotalWeight extends StatefulWidget {
  final Function() onTap;
  final state;

  const SelectTotalWeight({required this.onTap, required this.state});

  @override
  _SelectTotalWeightState createState() => _SelectTotalWeightState();
}

class _SelectTotalWeightState extends State<SelectTotalWeight> {
  _SelectTotalWeightState();

  bool _isWeightTypeLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeightTypes();
  }

  void _fetchWeightTypes() async {
    context.read<OrderBloc>().add(OrderFetchWeightTypes());
    setState(() {
      _isWeightTypeLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.state.weight_type.keys.first);
    return OrderCard(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.browse_gallery_rounded,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Berat total',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                  widget.state.weight_type == 'Kecil'
                      ? 'Kecil 5kg'
                      : widget.state.weight_type == 'Sedang'
                          ? 'Sedang 10kg'
                          : 'Besar 20kg',
                  style: Theme.of(context).textTheme.bodyLarge),
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
    );
  }
}
