
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopSearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController =TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context, state) {  },
        builder:(BuildContext context, state) {
          return Scaffold(
          appBar: AppBar(
              title:Text('Search'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  isPassword: false,
                    validator: (value){
                      if (value!.isEmpty){
                        return 'enter text to search';
                      }
                      return null;
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                  onSubmit: (String text){
                      SearchCubit.get(context).search(text);
                  },
                ),
                SizedBox(height: 10.0,),
                if (state is SearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10.0,),
                 if(state is SearchSuccessState)
                 Expanded(
                   child: ListView.separated(
                    itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data[index],context,isOldPrice:false),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: SearchCubit.get(context).model!.data!.data.length,
                ),
                 ),

              ],
            ),
          )
        );
        },
      ),
    );
  }
}
