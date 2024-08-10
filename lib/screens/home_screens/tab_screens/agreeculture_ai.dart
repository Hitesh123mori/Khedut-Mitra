import 'package:flutter/material.dart';

class AgreecultureAi extends StatefulWidget {
  const AgreecultureAi({super.key});

  @override
  State<AgreecultureAi> createState() => _AgreecultureAiState();
}

class _AgreecultureAiState extends State<AgreecultureAi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Center(
          child: Text("THIS IS AGGICULTURE SCREEN"),
        ),

      ),
    );
  }
}
