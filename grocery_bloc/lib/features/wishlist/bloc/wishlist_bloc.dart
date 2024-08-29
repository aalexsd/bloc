import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teste_bloc/data/wishlist_items.dart';
import '../../home/models/home_product_data_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
    on<WishlistNavigateToHomeEvent>(wishlistNavigateToHomeEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(WishlistSuccessState(wishlistItems: wishlistitems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    print('Removing from cart: ${event.clickedProduct.name}');

    wishlistitems.removeWhere((item) => item.id == event.clickedProduct.id);

    print('Cart items after removal: $wishlistitems');
    emit(WishlistRemovedProductState(wishlistItems: wishlistitems));
  }

  FutureOr<void> wishlistNavigateToHomeEvent(
      WishlistNavigateToHomeEvent event, Emitter<WishlistState> emit) {
    emit(WishlistNavigatoToHomeState());
  }
}
