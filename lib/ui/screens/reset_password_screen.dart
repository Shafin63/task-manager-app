import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager2/ui/screens/login_screen.dart';
import 'package:task_manager2/ui/screens/pin_verification_screen.dart';
import 'package:task_manager2/ui/screens/signup_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _newPassTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Set Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),

                  Text(
                    "A 6 digit verification code will be sent to your email address",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _newPassTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "New Password"),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _confirmPassTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                  ),
                  const SizedBox(height: 30),

                  FilledButton(
                    onPressed: _onTapResetPasswordConfirmButton,
                    child: Text('Confirm'),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Column(
                      children: [
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

  void _onTapResetPasswordConfirmButton() {
    if (_newPassTEController.text == _confirmPassTEController.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
          (predicate) => false,
      );
    } else {
      print("Password Mismatch");
    }

  }

  @override
  void dispose() {
    super.dispose();
    _newPassTEController.dispose();
    _confirmPassTEController.dispose();
  }
}
