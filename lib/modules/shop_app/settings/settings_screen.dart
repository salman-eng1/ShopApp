
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
class SettingsScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit,ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var model;
        if(ShopCubit.get(context).userModel != null)
         model=ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null ,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                if (state is ShopLoadingUpdateUserDataState)
                LinearProgressIndicator(),
                SizedBox(height: 20.0,),
                defaultFormField(
                  validator: (String? value)
                  {
                    if(value!.isEmpty){
                      return 'name must not be empty';
                    }
                    return null;
                  } ,
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  prefix: Icons.person,
                  isPassword: false,
                ),

                SizedBox(height: 20.0,),



                defaultFormField(
                  validator: (String? value)
                  {
                    if(value!.isEmpty){
                      return 'email must not be empty';
                    }
                    return null;
                  } ,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  prefix: Icons.email_outlined,
                  isPassword: false,
                ),

                SizedBox(height: 20.0,),


                defaultFormField(
                  validator: (String? value)
                  {
                    if(value!.isEmpty){
                      return 'phone must not be empty';
                    }
                    return null;
                  } ,
                  controller: phoneController,
                  type: TextInputType.number,
                  label: 'Phone',
                  prefix: Icons.password_outlined,
                  isPassword: false,


                ),
                SizedBox(height: 20.0,),


                defaultButton(function: ()

                {
                  if(formkey.currentState!.validate()){
                    ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
                  }

                },
                    text: 'update'
                ),
                SizedBox(height: 20.0,),


                defaultButton(function: ()
                {signOut(context);},
                    text: 'logout'
                ),
              ],
            ),
          ),
        ),
        fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),
      );},

    );
  }
}
