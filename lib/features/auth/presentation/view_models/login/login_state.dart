part of 'login_cubit.dart';

@immutable
class LoginState extends Equatable {
  final BaseState<UserEntity> loginState;
  const LoginState({this.loginState = const BaseLoadingState()});

  LoginState copyWith({BaseState<UserEntity>? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}
