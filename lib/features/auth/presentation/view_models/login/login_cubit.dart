import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';
import 'package:shopping_app/features/auth/domain/usecases/login_use_case.dart';
import 'login_intent.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(const LoginState());

  Future<void> intent(LoginIntent loginIntent) async {
    switch (loginIntent) {
      case Login(:final body):
        await _login(body);
    }
  }

  Future<void> _login(LoginRequestBody body) async {
    emit(state.copyWith(loginState: BaseLoadingState()));
    final result = await _loginUseCase.invoke(body);
    switch (result) {
      case Success<UserEntity>(data: final user):
        emit(state.copyWith(loginState: BaseSuccessState(data: user)));
      case Error<UserEntity>(messageError: final message):
        emit(state.copyWith(loginState: BaseFailureState(errorMessage: message)));
    }
  }
}
