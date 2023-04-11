import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/layout_screen/layout_screen.dart';
import 'package:shop_app/presentation/register_screen/register_screen.dart';
import 'package:shop_app/view_model/login_cubit/login_cubit.dart';
import '../../data/data_resource/shared_prefrence.dart';
import '../../view_model/login_cubit/login_states.dart';
import '../../widgets/component/components.dart';

class LoginScreen extends StatelessWidget {
  var emailshopcontroller = TextEditingController();
  var passshopcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserLoginCubit(),
      child: BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, state) {
          if (state is LoginingUserSuccess) {
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
        },
        builder: (context, state) {
          var cubit = UserLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      textFormField(
                        controller: emailshopcontroller,
                        prefix: Icons.email,
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
                        height: 15,
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
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginingUserLoading,
                        builder: (context) => button(
                          x: 40,
                          width: double.infinity,
                          text: 'login',
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              cubit.loginUser(
                                email: emailshopcontroller.text,
                                password: passshopcontroller.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an account?'),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              navTo(context, register());
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    ],
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
