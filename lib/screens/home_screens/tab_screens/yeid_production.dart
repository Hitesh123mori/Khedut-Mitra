import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';
import 'package:hack_24/screens/utils/widgets/auth_button.dart';
import 'package:hack_24/screens/utils/widgets/custom_text_field.dart';

class YieldPrediction extends StatefulWidget {
  const YieldPrediction({super.key});

  @override
  State<YieldPrediction> createState() => _YieldPredictionState();
}

class _YieldPredictionState extends State<YieldPrediction> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(updateButtonState);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Form(
        key: _formKey,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: AppColors.theme['primaryColor']!.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Yield Prediction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['fontColor']!.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        hintText: "Enter Crop Name",
                        isNumber: false,
                        prefixicon: const Icon(Icons.edit_attributes),
                        obsecuretext: false,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 20),
                      AuthButton(
                        onpressed: isButtonEnabled && !_isLoading
                            ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            // Add your logic here for yield prediction.
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        }
                            : null,
                        name: _isLoading ? 'Please wait...' : 'Log In',
                        bcolor: isButtonEnabled
                            ? AppColors.theme['primaryColor']
                            : AppColors.theme['fontColor']!.withOpacity(0.4),
                        tcolor: AppColors.theme['secondaryColor'],
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
