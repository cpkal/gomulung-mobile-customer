import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/bloc/login/login_bloc.dart';

class ForgotPassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  void _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // snackbar success sending email link for forgot password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Link untuk reset password telah dikirim ke email anda'),
        ),
      );

      // pop after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Lupa Password',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Masukan email yang terdaftar untuk mendapatkan link reset password',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                //textformfield
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ElevatedButton(
            onPressed: () {
              _handleSubmit(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Text("Masuk"),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
