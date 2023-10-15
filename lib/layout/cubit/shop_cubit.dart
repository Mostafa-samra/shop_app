import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/catogeros/catogeress_screen.dart';
import 'package:shop_app/modules/favorates/favorates_screen.dart';
import 'package:shop_app/modules/prodactes/prodactes_screen.dart';
import 'package:shop_app/modules/settinges/settinges_screen.dart';
import 'package:shop_app/sheard/network/endpoint.dart';
import 'package:shop_app/sheard/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductesScreen(),
    const CategoryScreen(),
    const FavoretsScreen(),
    const SettingScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getDate(
      url: home,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccesHomeDataState());
    }).catchError((onError) {
      emit(ShopErrorHomeDataState(error: onError));
    });
  }
}
