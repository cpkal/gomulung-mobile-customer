import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/main.dart';
import 'package:las_customer/presentation/bloc/register/register_bloc.dart';

class RegisterVerifyEmailPage extends StatefulWidget {
  @override
  _RegisterVerifyEmailPageState createState() =>
      _RegisterVerifyEmailPageState();
}

class _RegisterVerifyEmailPageState extends State<RegisterVerifyEmailPage> {
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    focusNodes[0].requestFocus(); // Focus on the first input field
  }

  void handleInput(String value, int index) {
    if (value.length == 1) {
      // Move to the next input field
      setState(() {
        currentIndex = (index + 1).clamp(0, 5); // Limit index to 0-5
      });
      if (currentIndex < controllers.length) {
        focusNodes[currentIndex].requestFocus(); // Focus next input
      }
    } else if (value.isEmpty) {
      // Move back to the previous input field
      setState(() {
        currentIndex = (index - 1).clamp(0, 5);
      });
      if (currentIndex >= 0) {
        focusNodes[currentIndex].requestFocus(); // Focus previous input
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Verifikasi Email',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Cek email anda untuk mendapatkan kode aktivasi',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                //textformfield
                SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          handleInput(value, index);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // context.read<RegisterBloc>().add(RegisterVerifyEmail());
                //push and remove all previous routes
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutePaths.subRoot, (route) => false);
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
      ),
    );
  }
}
