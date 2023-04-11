import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/search_cubit/search_cubit.dart';
import 'package:shop_app/view_model/search_cubit/search_states.dart';

import '../../widgets/component/components.dart';
import '../../widgets/styles/colors/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SearchCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      textFormField(
                        controller: searchcontroller,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Write What You Want!!';
                          }
                          return null;
                        },
                        prefix: Icons.search,
                        label: 'search',
                        onChanged: (String value) {
                          cubit.searchData(text: value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state is SearchingDataLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: defaultColor,
                          ),
                        )
                      else if (state is SearchingDataSuccess)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildProductItem(
                                cubit.searchModel!.data!.data![index], context,
                                isOldPrice: false),
                            separatorBuilder: (context, state) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: cubit.searchModel!.data!.data!.length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
