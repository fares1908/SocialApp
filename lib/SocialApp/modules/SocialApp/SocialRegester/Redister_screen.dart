import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../lay_out/SocialApp/SocialLayout.dart';
import '../../../shared/compounant/compounts.dart';
import '../../../shared/compounant/constant.dart';
import '../../../shared/network/network.local.dart';
import 'cubit_register/social_Cubit_register_screen.dart';
import 'cubit_register/social_state_register_screen.dart';

class Social_register_Screen extends StatefulWidget {
  @override
  State<Social_register_Screen> createState() => _Social_register_ScreenState();
}

class _Social_register_ScreenState extends State<Social_register_Screen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  bool isPasswordShow = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
        listener:(context, state) {
          if(state is SocialCreateUserSuccessState){
            navigatAndfinshed(context, SocialLayout());
          }
        } ,
        builder: (context, state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Register Now To Connect',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),


                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(

                          controller: nameController,
                          type: TextInputType.name,
                          label: 'name',
                          icon: Icons.person,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Name';
                            } else {
                              return null;
                            }
                          },

                        ),

                        SizedBox(
                          height: 20,
                        ),

                        deflutformfield(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Email Address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(
                          isPassword: isPasswordShow,
                          controller: passwordController,
                          type: TextInputType.number,
                          label: 'Password',
                          icon: Icons.lock,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Password';
                            } else {
                              return null;
                            }
                          },
                          sofix: isPasswordShow ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPasswordShow = !isPasswordShow;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(
                          controller: phoneController,
                          type: TextInputType.number,
                          label: 'Phone',
                          icon: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Phone';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 45,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              color: Colors.deepPurple,
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
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
