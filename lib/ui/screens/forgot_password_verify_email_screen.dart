import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager2/ui/screens/pin_verification_screen.dart';
import 'package:task_manager2/ui/screens/signup_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';

class ForgotPasswordVerifyEmail extends StatefulWidget {
  const ForgotPasswordVerifyEmail({super.key});

  @override
  State<ForgotPasswordVerifyEmail> createState() => _ForgotPasswordVerifyEmailState();
}

class _ForgotPasswordVerifyEmailState extends State<ForgotPasswordVerifyEmail> {
  final TextEditingController _emailTEController = TextEditingController();
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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),

                  Text(
                    "A 6 digit verification code will be sent to your email address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 30),
          
                  FilledButton(
                    onPressed: _onTapEmailAddressButton,
                    child: Icon((Icons.arrow_forward_ios_outlined)),
                  ),
          
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Have an account? ",
                            children: [
                              TextSpan(
                                  text: "Log In",
                                  style: TextStyle(color: Colors.green),
                                  recognizer: TapGestureRecognizer()..onTap = _onTapLoginButton
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
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
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignupButton
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  void _onTapEmailAddressButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PinVerification()));
  }

  void _onTapLoginButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
