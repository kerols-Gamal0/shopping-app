part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountDataState extends AccountState {
  final BaseState<UserEntity?> state;
  AccountDataState(this.state);
}

class AccountImageSelectedState extends AccountState {
  final String imagePath;
  AccountImageSelectedState(this.imagePath);
}
