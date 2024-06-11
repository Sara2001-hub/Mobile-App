import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);
  final ChatUser _currentUser =
      ChatUser(id: "1", firstName: "Sara", lastName: "Salim");
  final ChatUser _gptChatUser =
      ChatUser(id: "2", firstName: "AI", lastName: "Bot");
  List<ChatMessage> _chatMessages = [];

  List<ChatUser> _typingUsers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Chat Bot",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: DashChat(
        messageOptions: const MessageOptions(
            currentUserContainerColor: primaryColor,
            containerColor: secondaryColor),
        typingUsers: _typingUsers,
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _chatMessages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _chatMessages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    List<Messages> _messagesHistory = _chatMessages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();

    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: _messagesHistory,
        maxToken: 200);
    try {
      final response = await _openAI.onChatCompletion(request: request);

      for (var element in response!.choices) {
        if (element.message != null) {
          setState(() {
            _chatMessages.insert(
                0,
                ChatMessage(
                    user: _gptChatUser,
                    createdAt: DateTime.now(),
                    text: element.message!.content));
          });
        }
      }
      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
    }
    catch (e){
      print(e.toString());
    }
  }
}
