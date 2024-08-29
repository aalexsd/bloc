// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:teste_bloc/data/cart_items.dart';

import 'package:teste_bloc/features/cart/bloc/cart_bloc.dart';

import '../../home/models/home_product_data_model.dart';

class CartTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartbloc;
  const CartTileWidget({
    Key? key,
    required this.productDataModel,
    required this.cartbloc,
  }) : super(key: key);

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.productDataModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.productDataModel.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$' + widget.productDataModel.price.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      setState(() {});
                      widget.cartbloc.add(CartRemoveFromCartEvent(
                          clickedProduct: widget.productDataModel));
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}