

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

//MaterialButton
Widget defaultButton({
  double width = double.infinity,
  Color background=Colors.blue,
  bool isUpperCase= true,
  required final Function() function,
  required String text,

})=> Container(
  height: 50.0,
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase?text.toUpperCase() : text,
      style: TextStyle(
      color: Colors.white,
    ),
    ),
  ),
);

Widget defaultTextButton({
  required String text,
  required Function() onPressed,
})=>TextButton(
  onPressed: onPressed,
  child: Text(text.toUpperCase()),);

//suffix icon button
Widget suffixIconBtn ({
  IconData? suffix,
})=>IconButton(
onPressed: () {},
icon: Icon(suffix),

    );



//TextFormField
Widget defaultFormField({
  Function(String value)? onSubmit,
  Function(String value)? onChanged,
  Function()? onTap,
  Function()? suffixPressed,
  required FormFieldValidator<String>? validator,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  bool isClickable=true,
  bool isPassword=true,
   IconData? suffix,


})=> TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
  enabled: isClickable,
  decoration: InputDecoration(
    //or hintText(Second Style)
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix !=null ?
    IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix,)
    ) :null,
    // suffixIcon:
    // IconButton(
    //   onPressed: (){},
    //   icon: Icon(suffix),
    //   focusColor: Colors.red,
    // ),
    //suffixIcon: suffix !=null ? Icon(suffix,) :null,
    border: OutlineInputBorder(),
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);



void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateAndFinish(context,Widget)=> Navigator.pushAndRemoveUntil
  (
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
    (route){
    return false;
    },
);

void showToast({
  required String message,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor (ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS: color= Colors.green;
    break;
    case ToastStates.ERROR: color= Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;
  }
  return color;
}

Widget buildListProduct( model,context,{bool isOldPrice=true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                      '${model!.image}'
                  ),
                  width: 120,
                  height: 120.0,
                ),
                if(model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        '${model!.discount}',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ]),
        ),
        SizedBox(width:20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model!.price}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model!.oldPrice.toString()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        height: 1.3,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model!.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        (ShopCubit.get(context).favorites[model!.id])! ? defaultColor :Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18.0,

                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
