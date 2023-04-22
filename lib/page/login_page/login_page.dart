
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              signInWithGoogle();
            },
            child: Text("Accedi con Google"),
          ),
        )
    );
  }

}