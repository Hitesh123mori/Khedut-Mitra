import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';
import 'package:hack_24/screens/utils/widgets/auth_button.dart';
import 'package:hack_24/screens/utils/widgets/custom_text_field.dart';

import '../../utils/widgets/yeid_dialog.dart'; // Import the dialog widget

class YieldPrediction extends StatefulWidget {
  const YieldPrediction({super.key});

  @override
  State<YieldPrediction> createState() => _YieldPredictionState();
}

class _YieldPredictionState extends State<YieldPrediction> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _seasonController = TextEditingController();
  final TextEditingController _plantDistanceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  bool _isLoading = false;
  String _useFertilizer = 'No'; // Use 'Yes' or 'No' for radio buttons

  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateButtonState);
    _seasonController.addListener(updateButtonState);
    _plantDistanceController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _seasonController.text.isNotEmpty &&
          _plantDistanceController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(updateButtonState);
    _seasonController.removeListener(updateButtonState);
    _plantDistanceController.removeListener(updateButtonState);
    _nameController.dispose();
    _seasonController.dispose();
    _plantDistanceController.dispose();
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
                height: 450,
                width: 450,
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
                          color: AppColors.theme['fontColor']!.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: "Enter Crop Name",
                        isNumber: false,
                        prefixicon: const Icon(Icons.edit_attributes),
                        obsecuretext: false,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: "Season Name",
                        isNumber: false,
                        prefixicon: const Icon(Icons.edit_attributes),
                        obsecuretext: false,
                        controller: _seasonController,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Use of Fertilizer?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.theme['fontColor']!.withOpacity(0.9),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      activeColor: AppColors.theme['primaryColor'],
                                      groupValue: _useFertilizer,
                                      onChanged: (value) {
                                        setState(() {
                                          _useFertilizer = value ?? 'No';
                                        });
                                      },
                                    ),
                                    Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.theme['fontColor']!.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      activeColor: AppColors.theme['primaryColor'],
                                      groupValue: _useFertilizer,
                                      onChanged: (value) {
                                        setState(() {
                                          _useFertilizer = value ?? 'Yes';
                                        });
                                      },
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.theme['fontColor']!.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: "Plant Distance",
                        isNumber: true,
                        prefixicon: const Icon(Icons.edit_attributes),
                        obsecuretext: false,
                        controller: _plantDistanceController,
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
                            // Fetch values
                            final plantDistance = double.tryParse(_plantDistanceController.text) ?? 0;
                            final useFertilizerFactor = _useFertilizer == 'Yes' ? 1 : 0;

                            // Basic yield prediction formula
                            const double A = 10;
                            const double B = 50;

                            // Calculate yield prediction
                            final predictedYield = A * plantDistance + B * useFertilizerFactor;

                            // Generate a random yield value
                            final random = Random();
                            final randomYield = 1000 + random.nextDouble() * 1000; // Random value between 1000 and 2000

                            // Show dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return YieldDialog(
                                  predictedYield: predictedYield,
                                  randomYield: randomYield,
                                );
                              },
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        }
                            : null,
                        name: _isLoading ? 'Please wait...' : 'Predict',
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
