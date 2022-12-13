import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../screens/auth/login_screen/models/login_response/user.dart';
import '../../safe/safe.dart';
import '../models/auth_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Safe safe;
  LoginUser? user;
  AuthCubit({
    required this.safe,
  }) : super(AuthState(target: safe.getAuthStatus()));

  endOnboarding() async {
    await safe.endOnBoardingStatus();
    emit(const AuthState(target: AuthStatus.login));
  }

  userLogedIn(LoginUser user) {
    this.user = user;
    emit(const AuthState(target: AuthStatus.home));
  }
}
