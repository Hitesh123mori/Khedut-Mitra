import 'package:flutter/material.dart';
import 'package:hack_24/screens/auth_screens/sign_up.dart';
import 'package:hack_24/screens/transition/left_right.dart';
import '../../apis/auth_apis/auth_api.dart';
import '../utils/color.dart';
import '../utils/widgets/auth_button.dart';
import '../utils/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateButtonState);
    _passController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty && _passController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(updateButtonState);
    _passController.removeListener(updateButtonState);
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: mq.height * 0.1),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 350,
                    width: 350,
                  ),
                  SizedBox(height: mq.height * 0.003),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: mq.height * 0.5,
                width: mq.width,
                decoration: BoxDecoration(
                  color: AppColors.theme['primaryColor'],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: mq.height * 0.02),
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.theme['backgroundColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        Text(
                          "Welcome back! Please enter your details.",
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.theme['backgroundColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextField(
                            controller: _emailController,
                            hintText: 'Enter your email',
                            isNumber: false,
                            prefixicon: Icon(Icons.mail_outline_outlined),
                            obsecuretext: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextField(
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
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AuthButton(
                            onpressed: isButtonEnabled && !_isLoading
                                ? () async {
                              setState(() {
                                _isLoading = true;
                              });
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                await AppFirebaseAuth.signIn(
                                  context,
                                  _emailController.text,
                                  _passController.text,
                                ) ;
                                print("#done");
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            }
                                : null,
                            name: _isLoading ? 'Please wait...' : 'Log In',
                            bcolor: isButtonEnabled
                                ? AppColors.theme['fontColor']
                                : AppColors.theme['fontColor'].withOpacity(0.4),
                            tcolor: isButtonEnabled
                                ? AppColors.theme['secondaryColor']
                                : AppColors.theme['secondaryColor'],
                            isLoading: _isLoading,
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColors.theme['backgroundColor'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  LeftToRight(Register()),
                                );
                              },
                              child: Text(
                                "Sign Up",
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
          ],
        ),
      ),
    );
  }
}
