import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/sheard/components/components.dart';
import 'package:shop_app/sheard/components/constants.dart';
import 'package:shop_app/sheard/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status!) {
              CacheHelper.saveDate(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = state.registerModel.data!.token!;
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
              });
              showToast(
                  text: state.registerModel.message!,
                  states: ToastStates.success);
            } else {
              showToast(
                  text: state.registerModel.message!,
                  states: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            label: 'name',
                            prefix: Icons.person),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter your Email';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (p0) {
                            if (p0!.isEmpty) {
                              return 'password is too Short';
                            }
                            return null;
                          },
                          onSubmit: (p0) {},
                          isPassword: RegisterCubit.get(context).isPasswordShow,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter your Phone';
                              }
                              return null;
                            },
                            label: 'phone',
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true,
                            );
                          },
                          fallback: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
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
