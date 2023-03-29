import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ShopApp/network/network.local.dart';
import '../../../lay_out/SocialApp/SocialLayout.dart';
import '../../../shared/compounant/compounts.dart';
import '../SocialRegester/Redister_screen.dart';
import 'cubit/social_Cubit_login_screen.dart';
import 'cubit/social_state_login_screen.dart';

class Social_Login_Screen extends StatefulWidget {

  @override
  State<Social_Login_Screen> createState() => _Social_Login_ScreenState();
}

class _Social_Login_ScreenState extends State<Social_Login_Screen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPasswordShow = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(
                text: state.error,
                state: ToastStates.ERROR,
            );
          }if(state is SocialLoginSuccessState){
            CashHelper.saveData(
              key: 'uid',
              value: state.uid,)
                .then((value)
            {
              navigatAndfinshed(context, SocialLayout());
            }
            );
          }
        } ,
        builder: (context, state) {
          return Scaffold(
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Login Now To Connect with your friends',
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
                          sofix: isPasswordShow ? Icons.visibility         : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPasswordShow = !isPasswordShow;
                            });
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 45,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              color: Colors.deepPurple,
                              child: Text(
                                'LOGIN',
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, Social_register_Screen());
                              },
                              child: Text('REGISTER'),
                            ),
                          ],
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
    );;
  }
}
