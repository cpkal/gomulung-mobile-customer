import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/core/util/constants.dart';
import 'package:las_customer/presentation/bloc/register/register_bloc.dart';

class RegisterSelectRolePage extends StatefulWidget {
  @override
  _RegisterSelectRolePageState createState() => _RegisterSelectRolePageState();
}

class _RegisterSelectRolePageState extends State<RegisterSelectRolePage> {
  String? selectedOption; // Keep track of selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterState) {
            selectedOption = state.serviceType;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Daftar',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Pilih jasa sesuai kebutuhan anda',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),

              // Card for Option 1
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                  RegisterServiceSelected(
                                      RegisterConstant.SERVICE_HOME),
                                );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: selectedOption ==
                                        RegisterConstant.SERVICE_HOME
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rumahan",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child:
                                        Image.asset('assets/images/home.png'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        // Card for Option 2
                        GestureDetector(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                  RegisterServiceSelected(
                                      RegisterConstant.SERVICE_INDUSTRY),
                                );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: selectedOption ==
                                        RegisterConstant.SERVICE_INDUSTRY
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Bisnis",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: Image.asset(
                                        'assets/images/factory.jpg'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Button to navigate to the next page
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.registerInputAccount,
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: Text("Lanjut"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
