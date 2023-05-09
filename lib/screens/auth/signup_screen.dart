import 'package:flutter/material.dart';

import '../../widgets/auth/signup/signup_form.dart';
import '../../widgets/auth/signup/signup_footer.dart';
import '../../widgets/auth/signup/signup_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: const <Widget>[
              SignUpHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 30,
                  left: 30,
                  bottom: 10,
                ),
                child: LoginForm(),
              ),
              LoginWith(),
            ],
          ),
        ),
      ),
    );
  }
}
