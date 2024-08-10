import 'package:flutter/material.dart';
import 'package:hack_24/screens/models/ai_response.dart';
import 'package:hack_24/screens/models/chat_model.dart';
import '../color.dart';

class MessageCard extends StatefulWidget {
  final ChatMessage cm;

  const MessageCard({super.key, required this.cm});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.cm.isAi) {
      final aiResponse = widget.cm.aiResponse;
      if (aiResponse == null) {
        return Center(child: Text("No AI response available."));
      }
      return AiMessage(aiResponse);
    } else {
      final text = widget.cm.text;
      if (text == null || text.isEmpty) {
        return Center(child: Text("No message text available."));
      }
      return UserMessage(text);
    }
  }

  Widget AiMessage(AIResponse aiResponse) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 5.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
            color: AppColors.theme['primaryColor'].withOpacity(0.4),
            borderRadius: BorderRadius.circular(20).copyWith(
              topLeft: Radius.circular(0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("Best Medicine", aiResponse.best_pesticide),
              _buildRow("Amount Per Acre", aiResponse.amount_per_acre),
              _buildRow("Recovery Time", aiResponse.recovery_time),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.theme['fontColor'], fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(color: AppColors.theme['fontColor'].withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget UserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 5.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
            color: AppColors.theme['primaryColor'],
            borderRadius: BorderRadius.circular(20).copyWith(
              topRight: Radius.circular(0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
