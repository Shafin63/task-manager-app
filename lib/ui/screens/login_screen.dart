import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager2/data/models/user_model.dart';
import 'package:task_manager2/data/services/api_caller.dart';
import 'package:task_manager2/data/utils/urls.dart';
import 'package:task_manager2/ui/controllers/auth_controller.dart';
import 'package:task_manager2/ui/controllers/login_provider.dart';
import 'package:task_manager2/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager2/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager2/ui/screens/signup_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';
import 'package:task_manager2/ui/widgets/snack_bar_message.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LoginProvider _loginProvider;

  @override
  Widget build(BuildContext context) {
    _loginProvider = context.read<LoginProvider>();
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (String? value) {
                      String inputText = value ?? "";
                      if (EmailValidator.validate(inputText) == false) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return "Password should be more than 6 characters";
                      }
                      return null;
                    },
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 30),

                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, _) {
                      return Visibility(
                        visible: loginProvider.loginInProgress == false,
                        replacement: CenteredProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onTapSigninButton,
                          child: Icon((Icons.arrow_forward_ios_outlined)),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Don't have account? ",
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignupButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignupButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  void _onTapSigninButton() {
    if (_formKey.currentState!.validate()) {
      _logIn();
    }
  }

  Future<void> _logIn() async {
    final bool isSuccess = await _loginProvider.logIn(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );

    if (isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainNavbarHolderScreen()),
        (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, _loginProvider.errorMessage!);
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordVerifyEmail()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
