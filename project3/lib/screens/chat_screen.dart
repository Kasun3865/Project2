import 'package:flutter/material.dart';
import 'package:project3/models/chatgpt_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ChatGPTService _chatGPTService = ChatGPTService();
  bool _isLoading = false;

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "message": _controller.text});
      _isLoading = true;
    });

    String response = await _chatGPTService.sendMessage(_controller.text);

    setState(() {
      _messages.add({"sender": "bot", "message": response});
      _isLoading = false;
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat With Doctor")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: _messages[index]['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    color: _messages[index]['sender'] == 'user'
                        ? Colors.blue[100]
                        : Colors.green[100],
                    child: Text(_messages[index]['message'] ?? ''),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Type your message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
