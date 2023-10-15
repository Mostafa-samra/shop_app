part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopChangeBottomNavState extends ShopState {}

final class ShopLoadingHomeDataState extends ShopState {}

final class ShopSuccesHomeDataState extends ShopState {}

final class ShopErrorHomeDataState extends ShopState {
  final String error;

  ShopErrorHomeDataState({required this.error});
}
