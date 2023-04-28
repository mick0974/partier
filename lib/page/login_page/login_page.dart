
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, this.from}) : super(key: key);

  final String? from;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await context.read<LoginInfo>().signInWithGoogle();

              // if there's a deep link, go there
              if (from != null) {
                if (!context.mounted) return;
                context.go(from!);
              }
            },
            child: Text("Accedi con Google"),
          ),
        )
    );
  }

}