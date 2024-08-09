import 'package:flutter/material.dart';
import 'package:hack_24/apis/var_setup.dart';
import 'package:hack_24/screens/auth_screens/login_screen.dart';
import 'package:hack_24/screens/transition/right_left.dart';

import '../../apis/auth_apis/auth_api.dart';
import '../../main.dart';
import '../utils/color.dart';
import '../utils/widgets/auth_button.dart';
import '../utils/widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateButtonState);
    _passController.addListener(updateButtonState);
    _confirmpassController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty &&
          _passController.text.isNotEmpty &&
          _confirmpassController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(updateButtonState);
    _passController.removeListener(updateButtonState);
    _confirmpassController.removeListener(updateButtonState);
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _confirmpassController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              color: AppColors.theme['backgroundColor'],
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.1,
                    ),
                    // Add logo or other content here if needed
                    SizedBox(
                      height: mq.height * 0.003,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: mq.height * 0.8,
                width: mq.width * 1,
                decoration: BoxDecoration(
                  color: AppColors.theme['primaryColor'],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          Text(
                            "Create Account to continue!",
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.theme['backgroundColor'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: mq.height * 0.04,
                          ),
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Enter your name',
                            isNumber: false,
                            prefixicon: Icon(Icons.person),
                            obsecuretext: false,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Enter your email',
                            isNumber: false,
                            prefixicon: Icon(Icons.mail_outline_outlined),
                            obsecuretext: false,
                            validator: _validateEmail,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _passController,
                            hintText: 'Enter your password',
                            isNumber: false,
                            prefixicon: Icon(Icons.password),
                            obsecuretext: _isPasswordHidden,
                            suffix: IconButton(
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                            ),
                            validator: _validatePassword,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _confirmpassController,
                            hintText: 'Confirm your password',
                            isNumber: false,
                            prefixicon: Icon(Icons.password),
                            obsecuretext: _isConfirmPasswordHidden,
                            suffix: IconButton(
                              icon: Icon(
                                _isConfirmPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordHidden =
                                      !_isConfirmPasswordHidden;
                                });
                              },
                            ),
                            validator: _validateConfirmPassword,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _cityController,
                            hintText: 'Enter your city',
                            isNumber: false,
                            prefixicon: Icon(Icons.location_city),
                            obsecuretext: false,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _stateController,
                            hintText: 'Enter your state',
                            isNumber: false,
                            prefixicon: Icon(Icons.location_on),
                            obsecuretext: false,
                          ),
                          SizedBox(height: 20),
                          _isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.theme["fontColor"],
                                )
                              : AuthButton(
                                  onpressed: isButtonEnabled
                                      ? () async {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await AppFirebaseAuth.signUp(
                                                context,
                                                _emailController.text,
                                                _passController.text,
                                                _nameController.text,
                                                _stateController.text,
                                                _cityController.text);
                                          }

                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      : () async {
                                          FocusScope.of(context).unfocus();
                                        },
                                  name:
                                      _isLoading ? 'Please wait...' : 'Sign Up',
                                  bcolor: isButtonEnabled
                                      ? AppColors.theme['fontColor']
                                      : AppColors.theme['fontColor'].withOpacity(0.4),
                                  tcolor: isButtonEnabled
                                      ? AppColors.theme['secondaryColor']
                                      : AppColors.theme['secondaryColor'],
                                  isLoading: _isLoading,
                                ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.theme['secondaryColor'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    RightToLeft(LoginScreen()),
                                  );
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.theme['secondaryColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
