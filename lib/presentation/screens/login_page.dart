import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/presentation/widgets/textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
          Text(
            "Добро пожаловать",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),

         const SizedBox(height: 25),

         MyTextField(hintText: "Email",),

         const SizedBox(height: 10),

         MyTextField(hintText: "Password",),






       ],
     )
    );
  }
}
