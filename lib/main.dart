import 'package:economerce_full/src/blocProviders.dart';
import 'package:economerce_full/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:economerce_full/src/presentation/pages/auth/login/login_page.dart';
import 'package:economerce_full/src/presentation/pages/auth/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => const LoginPage(),
          'register': (BuildContext context) => const RegisterPage(),
        },
      ),
    );
  }
}
