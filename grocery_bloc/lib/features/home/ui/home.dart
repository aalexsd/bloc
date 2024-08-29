import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc/features/home/ui/product_tile_widget.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(HomeInitalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.pushNamed(context, '/cart').then((_) {
            setState(() {});
          });
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.pushNamed(context, '/wishlist').then((value) {
            setState(() {});
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              title: const Text("Página Inicial"),
              actions: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        // Passo o evento, um action bloc, para ir até os
                        _homeBloc.add(HomeWishListButtonNavigateEvent());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        _homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(HomeState state) {
    if (state is HomeLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is HomeLoadedSuccessState) {
      final successState = state;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.7,
        ),
        itemCount: successState.products.length,
        itemBuilder: (context, index) {
          return ProductTileWidget(
            homeBloc: _homeBloc,
            productDataModel: successState.products[index],
          );
        },
      );
    } else if (state is HomeErrorState) {
      return Center(
        child: Text('Erro ao carregar os produtos'),
      );
    }

    return Container();
  }
}
