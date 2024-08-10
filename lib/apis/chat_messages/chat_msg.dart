import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_24/apis/var_setup.dart';
import 'package:hack_24/screens/models/ai_response.dart';
import '../../screens/models/chat_model.dart';

class ChatApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ChatMessage>> getChatMessages() {
    return _db
        .collection('chat_msg')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final bool isAi = data['isAi'] ?? false;
        final String? text = data['text'] as String?;
        final AIResponse? aiResponse = data['aiResponse'] != null
            ? AIResponse.fromJson(data['aiResponse'] as Map<String, dynamic>)
            : null;

        return ChatMessage(
          isAi: isAi,
          text: text,
          aiResponse: aiResponse,
        );
      }).toList();
    });
  }

  // Send a message to Firestore with a timestamp
  static Future<void> sendMessage(ChatMessage cm) async {
    final message = ChatMessage(
      isAi: cm.isAi,
      text: cm.text,
      aiResponse: cm.aiResponse,
    );

    final messageJson = message.toJson();
    messageJson['timestamp'] = FieldValue.serverTimestamp(); // Add timestamp

    await FirebaseAPIs.firestore.collection("chat_msg").add(messageJson);
    print("#ChatAdded");
  }
}
