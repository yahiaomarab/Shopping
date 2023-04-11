import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/layout_screen/layout_screen.dart';
import 'package:shop_app/view_model/register_cubit/register_cubit.dart';
import '../../data/data_resource/shared_prefrence.dart';
import '../../view_model/register_cubit/register_states.dart';
import '../../widgets/component/components.dart';

class register extends StatelessWidget {
  var emailshopcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var usernamecontroller = TextEditingController();
  var passshopcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserRegisterCubit(),
      child: BlocConsumer<UserRegisterCubit, UserRegisterStates>(
          listener: (context, state) {
        if (state is RegisteringUserSuccess) {
          if (state.userModel.status!) {
            toastMessage(
                message: state.userModel.message!, state: ToastState.success);
            AdvancedSharedPreferences.setString('token', state.userModel.data!.token);
            print(state.userModel.data!.token);
            navAndReplace(context, LayoutScreen());
          } else {
            toastMessage(
                message: state.userModel.message!, state: ToastState.error);
          }
        }
        else if(state is  RegisteringUserErorr){

            toastMessage(
                message: state.erorr.toString(), state: ToastState.error);


      }}, builder: (context, state) {
        var cubit = UserRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(35.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    textFormField(
                      controller: usernamecontroller,
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
                      controller: emailshopcontroller,
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
                        controller: passshopcontroller,
                        prefix: Icons.password,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        isPassword: cubit.iconVisibility,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'pass adress must not be written';
                          } else {
                            return null;
                          }
                        },
                        suffix: cubit.suffixIcon,
                        onSuffixPressed: () {
                          cubit.changeIconVisibility();
                        }),
                    const SizedBox(
                      height: 35,
                    ),
                    textFormField(
                      controller: phonecontroller,
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
                    ConditionalBuilder(
                      condition: state is! RegisteringUserLoading,
                      builder: (context) => button(
                        x: 50,
                        text: 'Register',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.registerUser(
                              email: emailshopcontroller.text,
                              password: passshopcontroller.text,
                              phone: phonecontroller.text,
                              username: usernamecontroller.text,
                            );
                          }
                        },
                        width: double.infinity,
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
