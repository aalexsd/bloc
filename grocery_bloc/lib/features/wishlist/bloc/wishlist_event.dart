part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveFromWishlistEvent extends WishlistEvent {
  final ProductDataModel clickedProduct;
  WishlistRemoveFromWishlistEvent({
    required this.clickedProduct,
  });
}

class WishlistNavigateToHomeEvent extends WishlistEvent {}
