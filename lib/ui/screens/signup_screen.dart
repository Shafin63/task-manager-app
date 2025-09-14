import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager2/ui/screens/login_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Join With Us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "First Name"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 30),

                  FilledButton(
                    onPressed: () {},
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

  void _onTapLoginButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
  }
}
