import 'package:cpims_app/constants/global_constants.dart';
import 'package:cpims_app/endpoints/token_service_endpoint.dart';
import 'package:cpims_app/screens/home_screen.dart';
import 'package:cpims_app/widgets/custom_button.dart';
import 'package:cpims_app/widgets/custom_text_field.dart';
import 'package:cpims_app/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final signInFormKey = GlobalKey<FormState>();

    void signIn({
      required String userName,
      required String password,
    }) async {
      try {
        final accessToken = await logIn(
          context: context,
          userName: userName,
          password: password,
          onError: () {
            showSnackBar(context, 'Error occurred while logging in.');
          },
        );

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                accessToken: accessToken,
              ),
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error logging in $e');
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // size70VerticalSizedBox,
              const Text(
                'CPIMS App',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              mediumVerticalSizedBox,
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 20,
                ),
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: userNameController,
                        hintText: 'Username',
                        textInputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(
                            RegExp(
                              r'\s',
                            ),
                          )
                        ],
                      ),
                      mediumVerticalSizedBox,
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      mediumVerticalSizedBox,
                      CustomButton(
                        text: 'Login',
                        color: Colors.deepPurple,
                        onTap: () {
                          if (signInFormKey.currentState!.validate()) {
                            signIn(
                              userName: userNameController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
