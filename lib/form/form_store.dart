import 'package:form_mobx/form/form_error_state.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  @observable
  String name = "";

  @observable
  String email = "";

  @observable
  String password = "";

  @action
  void setUsername(String value) {
    name = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  final FormErrorState error = FormErrorState();
  late List<ReactionDisposer> _disposers;
  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateUsername),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validateUsername(String value) {
    if (value.isEmpty || isNull(value)) {
      error.username = "cannot be blank";
      return;
    }
    error.username = null;
  }

  @action
  void validateEmail(String value) {
    if (isEmail(value) || value.isEmpty) {
      error.email = "not a valid email";
      return;
    }
    error.email = null;
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty || isNull(value)) {
      error.password = "cannot be blank";
      return;
    }
    error.password = null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
    validateUsername(name);
  }
}
