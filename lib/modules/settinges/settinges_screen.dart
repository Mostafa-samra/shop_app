import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/sheard/components/components.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailEontroller = TextEditingController();
  var phoneController = TextEditingController();
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).loginModel;
        nameController.text = model!.data!.name!;
        emailEontroller.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return ' Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailEontroller,
                      type: TextInputType.name,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return ' Email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.name,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return ' Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone Number',
                      prefix: Icons.phone),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailEontroller.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        sigOut(context);
                      },
                      text: 'Logout'),
                ],
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
