import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observe.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/thems.dart';


import 'layouts/shop_app/cubit/cubit.dart';
import 'layouts/shop_app/shop_layout.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'modules/shop_app/on_boarding_screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;


  bool? isDark=CacheHelper.getData(key: 'isDark');
  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
   token=CacheHelper.getData(key: 'token');



  if (onBoarding !=null){
    if(token !=null){
      widget =ShopLayout();
    }else{
      widget=ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }


  //
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
          isDark: isDark,
            startWidget: widget,));

        },


    blocObserver: MyBlocObserver(),
  );



}


class MyApp extends StatelessWidget{

  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..changeAppMode(fromShared:isDark),),
        BlocProvider(create: (context)=>ShopCubit()..getHomeDate()..getCategories()..getFavorites()..getUserData(),),


      ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.light:ThemeMode.dark,
              home:startWidget,
            );
          },
        ),
      );
  }

}
