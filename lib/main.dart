// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboring/onborging_screen.dart';
import 'package:shop_app/sheard/components/constants.dart';
import 'package:shop_app/sheard/cubit/app_cubit.dart';
import 'package:shop_app/sheard/network/local/cache_helper.dart';
import 'package:shop_app/sheard/styles/themes/dark_themes.dart';
import 'package:shop_app/sheard/styles/themes/light_themes.dart';

void main() async {
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LogInScreen();
    }
  } else {
    widget = const OnBordingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    onBoarding: onBoarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool onBoarding;
  final Widget? startWidget;
  const MyApp(
      {super.key,
      required this.onBoarding,
      this.startWidget,
      required this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: lightThemes,
            darkTheme: darkThemes,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: onBoarding ? const LogInScreen() : const OnBordingScreen(),
          );
        },
      ),
    );
  }
}
