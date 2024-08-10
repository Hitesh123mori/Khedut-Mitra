import 'package:flutter/material.dart';
import 'package:hack_24/screens/models/ai_response.dart';

class ChatMessage {
  final bool isAi;
  final String? text;
  final AIResponse? aiResponse;

  ChatMessage({
    required this.isAi,
    this.text,
    this.aiResponse,
  });

  // Convert ChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'isAi': isAi,
      'text': text,
      'aiResponse': aiResponse?.toJson(),
    };
  }

  // Create ChatMessage from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      isAi: json['isAi'] as bool,
      text: json['text'] as String?,
      aiResponse: json['aiResponse'] != null
          ? AIResponse.fromJson(json['aiResponse'] as Map<String, dynamic>)
          : null,
    );
  }

  // Create ChatMessage from AIResponse
  factory ChatMessage.fromAiResponse(AIResponse response) {
    return ChatMessage(
      isAi: true,
      aiResponse: response,
    );
  }

  // Create ChatMessage from text message
  factory ChatMessage.fromText(String text) {
    return ChatMessage(
      isAi: false,
      text: text,
    );
  }
}
