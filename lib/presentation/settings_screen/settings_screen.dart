import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/user_cubit/user_cubit.dart';
import 'package:shop_app/view_model/user_cubit/user_states.dart';

import '../../data/models/user/user_model.dart';
import '../../widgets/component/components.dart';

class SettingsScreen extends StatelessWidget {
  var updatekey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        var model = cubit.userData;
        cubit.NameController.text = model!.data!.name;
        cubit.EmailController.text = model.data!.email;
        cubit.PhoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: true,
          builder: (context) => Card(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: updatekey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 100.0),
                  child: Column(
                    children: [
                      textFormField(
                        controller: cubit.NameController,
                        prefix: Icons.person,
                        type: TextInputType.text,
                        label: 'User Name',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'user name must not be written';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      textFormField(
                        controller: cubit.EmailController,
                        prefix: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'email adress must not be written';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      textFormField(
                        controller: cubit.PhoneController,
                        prefix: Icons.phone,
                        type: TextInputType.phone,
                        label: 'Phone Number',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone number must not be written';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      button(
                        x: 40,
                        text: 'UPDATE',
                        onPressed: () {
                          cubit.updateUserProfileData();
                        },
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      button(
                        x: 40,
                        text: 'LOGOUT',
                        onPressed: () {
                          cubit.signOut(context);
                        },
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
