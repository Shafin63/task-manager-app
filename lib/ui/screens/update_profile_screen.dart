import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager2/data/models/user_model.dart';
import 'package:task_manager2/data/services/api_caller.dart';
import 'package:task_manager2/data/utils/urls.dart';
import 'package:task_manager2/ui/controllers/auth_controller.dart';
import 'package:task_manager2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';
import 'package:task_manager2/ui/widgets/snack_bar_message.dart';
import 'package:task_manager2/ui/widgets/tm_appbar.dart';

import '../widgets/photo_picker_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    final UserModel user = AuthController.userModel!;

    _emailTEController.text = user.email;
    _firstNameTEController.text = user.firstName;
    _lastNameTEController.text = user.lastName;
    _mobileTEController.text = user.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(fromUpdateProfile: true),
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 30),
                  PhotoPickerField(
                    onTap: _pickImage,
                    selectedPhoto: _selectedImage,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid first name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Last Name"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid last name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Mobile"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password (Optional)",
                    ),
                    validator: (String? value) {
                      if ((value != null && value.isNotEmpty) &&
                          value.length < 6) {
                        return "Password must be more than 6 characters";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapUpdateProfile,
                      child: Text("Update"),
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

  void _onTapUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    final Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    String? encodedPhoto;
    if (_selectedImage != null) {
      List<int> bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = jsonEncode(bytes);
      requestBody['photo'] = encodedPhoto;
    }
    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.updateProfileUrl,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _passwordTEController.clear();
      UserModel model = UserModel(
        id: AuthController.userModel!.id,
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
        photo: encodedPhoto ?? AuthController.userModel!.photo,
      );
      await AuthController.updateUserData(model);
      showSnackBarMessage(context, "Your profile has been updated");
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
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
