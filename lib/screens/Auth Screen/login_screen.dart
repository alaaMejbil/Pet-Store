import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/http_excaption.dart';
import 'package:untitled15/providers/auth_provider.dart';
import 'package:untitled15/screens/main%20screen/main_screen.dart';
import 'package:untitled15/services/cashe_helper.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'login_header.dart';
import 'roundedButton.dart';
import 'package:untitled15/screens/Auth%20Screen/label_button.dart';
import 'Animation/fade_animation.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final authKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            LoginScreenHeader(),
            FadeAnimation(
              1.3,
              Text(
                provider.currentAuthMode == AuthMode.login
                    ? 'Login'
                    : 'New Account',
                style: TextStyle(
                  color: Colors.indigo.withOpacity(0.8),
                  fontSize: 40,
                  letterSpacing: 2.5,
                  fontFamily: "signatra",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeAnimation(
              1.6,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                //height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.secondaryColor!.withOpacity(0.12),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: authKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: FadeAnimation(
                    2,
                    Column(
                      children: <Widget>[
                        buildUserNameTextField(),
                        const Divider(),
                        buildPasswordTextField(),
                        if (provider.currentAuthMode == AuthMode.signUp)
                          const Divider(),
                        if (provider.currentAuthMode == AuthMode.signUp)
                          buildConfirmPassTextField(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (provider.currentAuthMode == AuthMode.login)
              FadeAnimation(
                2.3,
                LabelButton(
                  text: 'Forgot Password?',
                  textColor: Colors.deepPurple.withOpacity(0.6),
                  onPress: () async {},
                ),
              ),
            if (provider.currentAuthMode == AuthMode.signUp)
              const SizedBox(
                height: 15,
              ),
            FadeAnimation(
              2.7,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                          strokeWidth: 3,
                        ),
                      )
                    : RoundedButton(
                        colorButton: Colors.indigo.withOpacity(0.8),
                        textColor: Colors.white70,
                        text: provider.currentAuthMode == AuthMode.login
                            ? 'Login'
                            : 'Register',
                        width: double.infinity,
                        onPressed: () {
                          final isValid = authKey.currentState!.validate();
                          if (isValid) {
                            authKey.currentState!.save();
                            FocusScope.of(context).unfocus();

                            try {
                              if (provider.currentAuthMode == AuthMode.login) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .login(emailController.text,
                                        passwordController.text);
                              } else {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .signUp(emailController.text,
                                        passwordController.text);
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),
              ),
            ),
            FadeAnimation(
              3.1,
              LabelButton(
                text: provider.currentAuthMode == AuthMode.login
                    ? 'Create Account'
                    : 'I have account',
                textColor: MyColors.secondaryColor!,
                onPress: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .changeAuthMode();
                },
              ),
            ),

            //if Keyboard open
            if (MediaQuery.of(context).viewInsets.bottom != 0)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
              ),
          ],
        ),
      ),
    );
  }

  TextFormField buildConfirmPassTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
        contentPadding: const EdgeInsets.fromLTRB(12, 5, 10, 0),
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'This Field can not be Empty!';
        }
        if (value != passwordController.text) {
          print(passwordController.text);
          return "confirm password does not Match";
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
        border: InputBorder.none,
      ),
      onChanged: (value) => passwordController.text = value,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'This Field can not be Empty!';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildUserNameTextField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'User Name',
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
        contentPadding: const EdgeInsets.fromLTRB(12, 5, 10, 5),
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'This Field can not be Empty!';
        } else {
          return null;
        }
      },
    );
  }
}
