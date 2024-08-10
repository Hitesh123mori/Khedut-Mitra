import 'package:flutter/material.dart';
import 'package:hack_24/apis/gen_api.dart';
import 'package:hack_24/screens/models/app_user.dart';
import 'package:hack_24/screens/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../apis/chat_messages/chat_msg.dart';
import '../../models/ai_response.dart';
import '../../models/chat_model.dart';
import '../../utils/color.dart';
import '../../utils/widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double _textFieldMaxHeight = 130.0;
  final FocusNode _messageFocusNode = FocusNode();
  bool _isMessageTextFieldFocused = false;
  final TextEditingController _textController = TextEditingController();
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

   return Consumer<AppUserProvider>(builder: (context, userProvider, child){return Scaffold(
     body: Column(
       children: [
         Expanded(
           child: StreamBuilder<List<ChatMessage>>(
             stream: ChatApi().getChatMessages(),
             builder: (context, snapshot) {
               switch (snapshot.connectionState) {
                 case ConnectionState.waiting:
                 case ConnectionState.none:
                 // return Center(child: CircularProgressIndicator());
                 case ConnectionState.active:
                 case ConnectionState.done:
                   if (snapshot.hasData) {
                     final List<ChatMessage> messages = snapshot.data!;
                     if (messages.isNotEmpty) {
                       return ListView.builder(
                         reverse: true,
                         itemCount: messages.length,
                         physics: BouncingScrollPhysics(),
                         itemBuilder: (context, index) {
                           final chatMessage = messages[index];
                           return MessageCard(
                             cm: chatMessage,
                           );
                         },
                       );
                     } else {
                       return Center(
                         child: Text(
                           "How to remove diseases in crop",
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 23,
                           ),
                         ),
                       );
                     }
                   } else {
                     return Center(child: Text("No messages available."));
                   }
               }
             },
           ),
         ),
         buildChatInput(userProvider.user!),
       ],
     ),
   );}) ;
  }

  Widget buildChatInput(AppUser user) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mq.width * 0.01,
        vertical: mq.height * 0.01,
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              color: AppColors.theme['primaryColor'].withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: mq.width * 0.03),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _showEmoji = !_showEmoji;
                      });
                    },
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: AppColors.theme['iconColor'],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: _textFieldMaxHeight),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: _textController,
                          focusNode: _messageFocusNode,
                          onChanged: (text) {
                            setState(() {
                              _isMessageTextFieldFocused = _messageFocusNode.hasFocus;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _isMessageTextFieldFocused = _messageFocusNode.hasFocus;
                              if (_showEmoji) _showEmoji = !_showEmoji;
                            });
                          },
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: AppColors.theme['primaryTextColor'],
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Message...",
                            hintStyle: TextStyle(
                              color: AppColors.theme['secondaryTextColor'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: mq.width * 0.03),
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            shape: CircleBorder(),
            onPressed: () {
              setState(() {
                _isMessageTextFieldFocused = false;
              });
              if (_textController.text.isNotEmpty) {

                ChatMessage userMessage = ChatMessage(isAi: false, text: _textController.text);
                ChatApi.sendMessage(userMessage).then((_) {

                  ApiService.getDiseaseSolution(user.curDeaseas!).then((response) {

                    ChatMessage aiMessage = ChatMessage(
                        isAi: true,
                        text: _textController.text,
                        aiResponse: AIResponse.fromJson(response)
                    );

                    ChatApi.sendMessage(aiMessage).then((_) {

                      print('AI response sent successfully');
                    }).catchError((error) {

                      print('Error sending AI response: $error');
                    });
                  }).catchError((error) {

                    print('Error fetching API response: $error');
                  }).whenComplete(() {
                    _textController.text = "";
                  });
                }).catchError((error) {

                  print('Error sending user message: $error');
                });

              }

            },
            color: AppColors.theme['primaryColor'],
            child: Icon(Icons.send),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
