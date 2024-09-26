import 'package:flutter/material.dart';
import 'package:las_customer/core/route/route_paths.dart';

class AskLoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // This will expand and center the image in the available space
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/forms.jpg',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          // Spacer or other widgets can be placed here if needed

          // Buttons aligned at the bottom of the screen
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.login);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text("Sudah punya akun? Masuk sekarang"),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RoutePaths.registerInputAccount);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text('Belum punya akun? Daftar sekarang'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
