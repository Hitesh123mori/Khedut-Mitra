import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hack_24/screens/models/chat_model.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../utils/color.dart';
import '../../utils/widgets/message_card.dart';
import 'chat_room.dart';


class AgreecultureAi extends StatefulWidget {
  const AgreecultureAi({super.key});

  @override
  State<AgreecultureAi> createState() => _AgreecultureAiState();
}

class _AgreecultureAiState extends State<AgreecultureAi> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.theme['primaryColor'].withOpacity(0.12),
            centerTitle: true,
            title: Text(
              "Welcome to Agree Assistant",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          body: ChatScreen(),
        );
      },
    );
  }
}
