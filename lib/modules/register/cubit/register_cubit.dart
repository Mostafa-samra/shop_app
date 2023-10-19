import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/sheard/network/endpoint.dart';
import 'package:shop_app/sheard/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel: registerModel));
    }).catchError((onError) {
      emit(
        RegisterErrorState(error: onError.toString()),
      );
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;
  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }
}
