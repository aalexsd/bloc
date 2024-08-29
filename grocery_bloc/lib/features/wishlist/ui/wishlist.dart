import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:teste_bloc/features/home/ui/home.dart';
import 'package:teste_bloc/features/home/ui/product_tile_widget.dart';
import 'package:teste_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:teste_bloc/features/wishlist/ui/wishlist_tile_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              wishlistBloc.add(WishlistNavigateToHomeEvent());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Favoritos'),
        ),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistNavigatoToHomeState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successState.wishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                    wishlistBloc: wishlistBloc,
                    productDataModel: successState.wishlistItems[index],
                  );
                },
              );
            case WishlistRemovedProductState:
              final successState = state as WishlistRemovedProductState;
              return ListView.builder(
                itemCount: successState.wishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                    wishlistBloc: wishlistBloc,
                    productDataModel: successState.wishlistItems[index],
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
