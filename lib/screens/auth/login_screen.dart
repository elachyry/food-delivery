import 'package:flutter/material.dart';

import '../../widgets/auth/login/login_form.dart';
import '../../widgets/auth/login/login_footer.dart';
import '../../widgets/auth/login/login_header.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: const <Widget>[
              LoginHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 30,
                  left: 30,
                  bottom: 10,
                ),
                child: LoginForm(),
              ),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
