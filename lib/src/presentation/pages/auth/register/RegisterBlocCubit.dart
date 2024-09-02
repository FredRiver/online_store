import 'package:economerce_full/src/presentation/pages/auth/register/registerBlocState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  RegisterBlocCubit() : super(RegisterInitial());
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastNameStream => _lastNameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get passwordConfirmStream => _passwordConfirmController.stream;

  void changeName(String name) {
    if (name.isNotEmpty && name.length < 3) {
      _nameController.sink.addError('El nombre es muy corto');
    } else {
      _nameController.sink.add(name);
    }
  }

  void changeLastName(String lastName) {
    if (lastName.isNotEmpty && lastName.length < 3) {
      _lastNameController.sink.addError('El apellido es muy corto');
    } else {
      _lastNameController.sink.add(lastName);
    }
  }

  void changePhone(String phone) {
    if (phone.isNotEmpty && phone.length < 9) {
      _phoneController.sink.addError('El telefono no es valido');
    } else {
      _phoneController.sink.add(phone);
    }
  }

  void changeEmail(String email) {
    bool emailFormatValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isNotEmpty && email.length < 5) {
      _emailController.sink.addError('Al menos 5 caracteres');
    } else if (email.isNotEmpty && !emailFormatValid) {
      _emailController.sink.addError('El email no es valido');
    } else {
      _emailController.sink.add(email);
    }
  }

  void changePassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink
          .addError('La Longitud de caracteres debe ser mayor a 6');
    } else {
      _passwordController.sink.add(password);
    }
  }

  void changePasswordConfirm(
    String passwordConfirm,
  ) {
    if (passwordConfirm.isNotEmpty && passwordConfirm.length < 6) {
      _passwordConfirmController.sink.addError('aL MENOS 6 CARACTERES');
    } else if (passwordConfirm != _passwordController.value) {
      _passwordConfirmController.sink.addError('No coincide con la contraseña');
    } else {
      _passwordConfirmController.sink.add(passwordConfirm);
    }
  }

  Stream<bool> get validateForm => Rx.combineLatest6(
        emailStream,
        nameStream,
        lastNameStream,
        phoneStream,
        passwordStream,
        passwordConfirmStream,
        (a, b, c, d, e, f) => true,
      );

  void dispose() {
    changeEmail('');
    changePassword('');
    changePasswordConfirm('');
    changeName('');
    changeLastName('');
    changePhone('');
  }

  void register() {
    print('Name: ${_nameController.value},');
    print('LastName: ${_lastNameController.value},');
    print('Phone: ${_phoneController.value},');

    print('Email: ${_emailController.value},');
    print('password: ${_passwordController.value},');
    print('confirmPassword: ${_passwordConfirmController.value},');
  }
}
