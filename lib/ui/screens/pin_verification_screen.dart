import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager2/ui/screens/reset_password_screen.dart';
import 'package:task_manager2/ui/screens/signup_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  final TextEditingController _pinTEController = TextEditingController();
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
                    "Pin Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),

                  Text(
                    "Enter the 6 digit verification code sent to your email address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    // enableActiveFill: true,
                    controller: _pinTEController,
                     appContext: context,
                  ),

                  const SizedBox(height: 30),
          
                  FilledButton(
                    onPressed: _onTapPinVerification,
                    child: Icon((Icons.arrow_forward_ios_outlined)),
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

  void _onTapPinVerification() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
  }

  @override
  void dispose() {
    super.dispose();
    _pinTEController.dispose();
  }
}
