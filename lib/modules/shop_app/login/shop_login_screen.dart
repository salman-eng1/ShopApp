import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state){
            if (state is ShopLoginSuccessState){
              if(state.loginModel.status==true){
                print(state.loginModel.data!.token);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token);
                navigateTo(context, ShopLayout());
                showToast(message: "${state.loginModel.message}", state: ToastStates.SUCCESS);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token)!.then((value){
                  navigateAndFinish(context, ShopLayout());
                });
              }else{
                print(state.loginModel.message);
                showToast(message:"${state.loginModel.message}", state: ToastStates.WARNING);
              }
            }
          },
        builder:(context,state){
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOGIN',
                            style: Theme.of(context).textTheme.headline3!.copyWith(color: defaultColor),
                          ),
                          Text('for more offers ..login now',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 40.0,),
                          defaultFormField(
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'please enter email';
                              }
                            },
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            isPassword: false,
                          ),

                          SizedBox(height: 15.0,),

                          defaultFormField(
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                            },
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            isPassword:ShopLoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                          ),
                          SizedBox(height: 30.0),
                          ConditionalBuilder(
                            builder: (BuildContext context)  =>
                           defaultButton(
                                function: (){
                                  if(formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }},
                                text: 'login',
                                background: defaultColor,
                            ),
                            condition: state is! ShopLoginLoadingState,
                            fallback: (context) => Center(child: CircularProgressIndicator()) ,

                           ),
                          SizedBox(height: 15.0,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have account?"),
                              defaultTextButton(text: 'signup', onPressed: (){
                                navigateTo(context, ShopRegisterScreen());
                              })
                            ]
                            ,)


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
