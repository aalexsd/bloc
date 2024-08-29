import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc/data/cart_items.dart';
import 'package:teste_bloc/data/wishlist_items.dart';
import 'package:teste_bloc/features/home/bloc/home_bloc.dart';
import 'package:teste_bloc/features/home/models/home_product_data_model.dart';
import 'package:teste_bloc/features/home/ui/product_tile_widget.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({
    Key? key,
    required this.productDataModel,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
                'R\$${widget.productDataModel.price.toString()}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: (wishlistitems.contains(widget.productDataModel))
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {});
                      widget.homeBloc.add(
                        HomeProductWishListButtonClickedEvent(
                          clickedProduct: widget.productDataModel,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: (cartItems.contains(widget.productDataModel))
                        ? Icon(Icons.shopping_cart, color: Colors.black)
                        : Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      setState(() {});
                      widget.homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: widget.productDataModel,
                        ),
                      );
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
