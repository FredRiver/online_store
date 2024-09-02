import 'package:economerce_full/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:economerce_full/src/presentation/widgets/default_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBlocCubit? _loginBlocCubit;
  @override
  void initState() {
    print('Init state');
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _loginBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginBlocCubit = BlocProvider.of<LoginBlocCubit>(context, listen: false);

    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          'assets/img/background2.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 125,
              ),
              const Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: StreamBuilder(
                    stream: _loginBlocCubit?.emailStream,
                    builder: (context, snapshot) {
                      return DefaultTextField(
                        label: 'Correo Electronico',
                        icon: Icons.email,
                        errorText: snapshot.error?.toString(),
                        onChanged: (text) {
                          _loginBlocCubit?.changeEmail(text);
                        },
                      );
                    }),
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                  child: StreamBuilder(
                      stream: _loginBlocCubit?.passwordStream,
                      builder: (context, snapshot) {
                        return DefaultTextField(
                          label: 'Contraseña',
                          icon: Icons.lock,
                          obscureText: true,
                          errorText: snapshot.error?.toString(),
                          onChanged: (text) {
                            _loginBlocCubit?.changePassword(text);
                          },
                        );
                      })),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                margin: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 15),
                child: StreamBuilder(
                    stream: _loginBlocCubit?.validateForm,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: () {
                          if (snapshot.hasData) {
                            _loginBlocCubit?.login();
                          } else {
                            Fluttertoast.showToast(
                                msg: 'El Formulario no es valido',
                                toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: snapshot.hasData
                                ? Colors.blueGrey
                                : Colors.transparent),
                        child: const Text(
                          'Iniciar Session',
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 65,
                    color: Colors.white,
                    margin: EdgeInsets.only(right: 5),
                  ),
                  Text(
                    '¿No tienes Cuenta',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Container(
                    height: 1,
                    width: 65,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 5),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: Text('Registrate'),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
