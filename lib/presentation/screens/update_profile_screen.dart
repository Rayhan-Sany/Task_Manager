import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _photoTEController = TextEditingController();
  bool _updateProfileInProgress = false;
  String? photo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData? userData = AuthController.userData;
    _emailTEController.text = userData?.email ?? '';
    _firstNameTEController.text = userData?.firstName ?? '';
    _lastNameTEController.text = userData?.lastName ?? '';
    _mobileTEController.text = userData?.mobile ?? '';
    photo = userData?.photo;
    _photoTEController.text= userData?.photo??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDefaultAppBar.appBar(isNotInProfileScreen: false),
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 45),
        child: updateProfileForm(context),
      )),
    );
  }

  Form updateProfileForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Update Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  log("Image Picker____________");
                  _pickImageFromGallery();
                },
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                      hintText: 'Photos',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: Colors.black54),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: _photoTEController,
                enabled: true,
                decoration: const InputDecoration(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: false,
          decoration: const InputDecoration(
              hintText: 'Email', border: InputBorder.none),
          controller: _emailTEController,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'First Name'),
          controller: _firstNameTEController,
          validator:emptyCheckValidator,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'Last Name'),
          controller: _lastNameTEController,
          validator:emptyCheckValidator,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'Mobile'),
          controller: _mobileTEController,
          validator:emptyCheckValidator,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'Password (optional)'),
          controller: _passwordTEController,
        ),
        const SizedBox(height: 12),
        Visibility(
          visible: _updateProfileInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updateProfile();
              }
            },
            child: const Icon(Symbols.expand_circle_right),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have account?',
                style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sign In'),
            )
          ],
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    List<int> bytes = File(pickedImage!.path).readAsBytesSync();
    photo = base64Encode(bytes);
    _photoTEController.text = pickedImage.name;
    setState(() {});
  }

  String? emptyCheckValidator(String? value){
    if(value==null||value.isEmpty) {
      return "Field Can't Be Empty";
    }
    else {
      return null;
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      inputParams["password"] = _passwordTEController.text;
    }
    if (photo != null) {
      inputParams["photo"] = photo;
    }
    final response =
        await NetworkCaller.postRequest(Url.updateProfileUrl, inputParams);
    if (response.isSuccess) {
      if (response.body['status'] == 'success') {
        UserData userData = UserData(
            email: _emailTEController.text,
            firstName: _firstNameTEController.text.trim(),
            lastName: _lastNameTEController.text.trim(),
            mobile: _mobileTEController.text.trim(),
            photo: photo);
        AuthController.saveUserData(userData);
      }
      if (mounted) {
        _updateProfileInProgress = false;
        setState(() {});
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavBarScreen()),
            (route) => false);
      }
    } else {
      if (!mounted) return;
      _updateProfileInProgress = false;
      setState(() {});
      commonSnackBar(
          context: context,
          snackBarContent: 'Profile Update Failed',
          isErrorSnack: true);
    }
  }
}
