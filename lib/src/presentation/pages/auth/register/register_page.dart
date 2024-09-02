import 'dart:ffi';
import 'dart:ui';

import 'package:economerce_full/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:economerce_full/src/presentation/widgets/default_butoon.dart';
import 'package:economerce_full/src/presentation/widgets/default_icon_back.dart';
import 'package:economerce_full/src/presentation/widgets/default_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBlocCubit? _registerBlocCubit;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _registerBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _registerBlocCubit =
        BlocProvider.of<RegisterBlocCubit>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/img/background3.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              color: const Color.fromRGBO(0, 0, 0, 0.3),
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(
                  255,
                  255,
                  255,
                  0.5,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: DefaultIconBack(
                        left: 20,
                        top: 10,
                      ),
                    ),
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    const Text(
                      'REGISTRO',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder<Object>(
                          stream: _registerBlocCubit?.nameStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Nombre',
                                icon: Icons.person,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit?.changeName(text);
                                });
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.lastNameStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Apellido',
                                icon: Icons.person,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit?.changeLastName(text);
                                });
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.emailStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Email',
                                icon: Icons.email,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit?.changeEmail(text);
                                });
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.phoneStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'telefono',
                                icon: Icons.phone,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit?.changePhone(text);
                                });
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.passwordStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Contraseña',
                                icon: Icons.lock,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit?.changePassword(text);
                                });
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.passwordConfirmStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Confirmar Contraseña ',
                                icon: Icons.lock_outlined,
                                obscureText: true,
                                errorText: snapshot.error?.toString(),
                                onChanged: (text) {
                                  _registerBlocCubit
                                      ?.changePasswordConfirm(text);
                                });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.validateForm,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: () {
                                if (snapshot.hasData) {
                                  _registerBlocCubit?.register();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: snapshot.hasData
                                      ? Colors.blueGrey
                                      : Colors.transparent),
                              child: const Text(
                                'Registrarse',
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
