//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../helpers/auth_manager/auth_cubit/auth_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/styling/styling.dart';
import '../../../widgets/main_widgets.dart';
import 'login_bloc/login_bloc.dart';
import 'login_widgets.dart';
import 'service/login_service_impl.dart';
import 'service/login_service_mock.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authCubit: context.read<AuthCubit>(),
        service: Constants.isDebuging ? LoginServiceMock() : LoginServiceImpl(),
      ),
      child: const LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginEmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Stack(
                children: [
                  Image.asset(Assests.loginBackground),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      _content(context),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Terms of Service       Privacy Policy
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Terms of Service'),
                          ),
                          const SizedBox(width: 48),
                          TextButton(
                            onPressed: () {},
                            child: Text('Privacy Policy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LoadingView(isVisible: state.status.isSubmissionInProgress),
          ],
        );
      },
    );
  }

  SizedBox _logo() {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          const Spacer(),
          Image.asset(
            Assests.logo,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _logo(),
                const SizedBox(height: 8),
                LoginInputs(
                  emailFocusNode: _emailFocusNode,
                  passwordFocusNode: _passwordFocusNode,
                ),
                const SizedBox(height: 8),
                LoginButtons(
                  onResetPassword: () {
                    // => Navigator.of(context)
                    // .pushNamed(NavLinks.identifyingAccount)
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
