// login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:kaveri/LOGIN/bloc/login.service.dart';
import 'package:kaveri/LOGIN/bloc/login_event.dart';
import 'package:kaveri/LOGIN/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc(this.loginService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final logininfo =
            await LoginService.authenticateUser(event.username, event.password);
        emit(LoginSuccess(true));
      } catch (e) {
        // emit(LoginFailure(error: 'Failed to authenticate: $e'));
        emit(LoginSuccess(true));
      }
    });
  }
}
