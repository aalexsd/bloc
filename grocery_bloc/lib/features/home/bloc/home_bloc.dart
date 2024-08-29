import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teste_bloc/data/cart_items.dart';
import 'package:teste_bloc/data/grocery_data.dart';
import 'package:teste_bloc/data/wishlist_items.dart';
import 'package:teste_bloc/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on this event, pass some state
    on<HomeInitalEvent>(homeInitalEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
      HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    if (wishlistitems.contains(event.clickedProduct)) {
      wishlistitems.remove(event.clickedProduct);
    } else {
      wishlistitems.add(event.clickedProduct);
    }
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('cart Product Clicked');
    if (cartItems.contains(event.clickedProduct)) {
      cartItems.remove(event.clickedProduct);
    } else {
      cartItems.add(event.clickedProduct);
    }

    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('WishList Navigate Clicked');
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate Clicked');
    emit(HomeNavigateToCartPageActionState());
  }

// We add this initial event in the initstate, then it will build the screen.
  FutureOr<void> homeInitalEvent(
      HomeInitalEvent event, Emitter<HomeState> emit) async {
// This states they will be called when the screen is building.
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                image: e['image'],
                price: e['price']))
            .toList()));
  }
}
