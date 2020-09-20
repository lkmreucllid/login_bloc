import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

//Validators is mixin class
//Object is base class from Dart
//mixins can only be applied to the base class, thats why we first need to extend base class

class Bloc extends Object with Validators {
  //by adding '_' we made variable private.
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //add data to stream
  Stream<String> get emailGetter =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordGetter =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(emailGetter, passwordGetter, (e, p) => true);

  //retrived data from stream
  get changeEmail => _emailController.sink.add;
  get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
