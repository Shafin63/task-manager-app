import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager2/data/services/api_caller.dart';
import 'package:task_manager2/data/utils/urls.dart';
import 'package:task_manager2/ui/screens/login_screen.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';
import 'package:task_manager2/ui/widgets/snack_bar_message.dart';

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

  bool signUpInProgress = false;

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
                    validator: (String? value) {
                      String inputText = value ?? "";
                      if (EmailValidator.validate(inputText) == false) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter first name";
                      }
                      return null;
                    },
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "First Name"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter last name";
                      }
                      return null;
                    },
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter mobile number";
                      }
                      return null;
                    },
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return "Enter a password more than 6 characters";
                      }
                      return null;
                    },
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 30),

                  Visibility(
                    visible: signUpInProgress == false,
                    replacement: CircularProgressIndicator(),
                    child: FilledButton(
                      onPressed: signUpButton,
                      child: Icon((Icons.arrow_forward_ios_outlined)),
                    ),
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapLoginButton,
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

  void signUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  //api call
  Future<void> _signUp() async {
    signUpInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.registerUrl,
      body: requestBody,
    );
    signUpInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, "Registration Successful");
    } else {
      showSnackBarMessage(context, (response.errorMessage!));
    }
  }

  void _onTapLoginButton() {
    Navigator.pop(context);
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
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
