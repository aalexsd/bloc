import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:teste_bloc/features/home/ui/home.dart';
import 'package:teste_bloc/features/home/ui/product_tile_widget.dart';

import 'cart_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              cartBloc.add(CartNavigateToHomeEvent());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Meu Carrinho'),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartNavigatoToHomeState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) {
                  return CartTileWidget(
                    cartbloc: cartBloc,
                    productDataModel: successState.cartItems[index],
                  );
                },
              );
            case CartRemovedProductState:
              final successState = state as CartRemovedProductState;
              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) {
                  return CartTileWidget(
                    cartbloc: cartBloc,
                    productDataModel: successState.cartItems[index],
                  );
                },
              );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
