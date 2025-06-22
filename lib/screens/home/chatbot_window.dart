import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBotWindow extends StatefulWidget {
  const ChatBotWindow({super.key});

  @override
  State<ChatBotWindow> createState() => _ChatBotWindowState();
}

class _ChatBotWindowState extends State<ChatBotWindow> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(role: 'assistant', content: 'Hi! How can I help you today?'),
  ];
  bool _isLoading = false;

  static const String _apiKey =
      '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';

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(role: 'user', content: text));
      _isLoading = true;
      _controller.clear();
    });
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': _messages
              .map((m) => {'role': m.role, 'content': m.content})
              .toList(),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'] as String?;
        if (reply != null) {
          setState(() {
            _messages.add(
              _ChatMessage(role: 'assistant', content: reply.trim()),
            );
          });
        }
      } else {
        setState(() {
          _messages.add(
            _ChatMessage(
              role: 'assistant',
              content: 'Sorry, there was an error.',
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(
          _ChatMessage(role: 'assistant', content: 'Failed to connect.'),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.smart_toy, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      'App Assistant',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (_isLoading && i == _messages.length) {
                        return const ListTile(
                          title: Text('Assistant is typing...'),
                        );
                      }
                      final msg = _messages[i];
                      return ListTile(
                        title: Text(msg.content),
                        leading: msg.role == 'assistant'
                            ? const Icon(Icons.smart_toy)
                            : null,
                        trailing: msg.role == 'user'
                            ? const Icon(Icons.person)
                            : null,
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String role;
  final String content;
  _ChatMessage({required this.role, required this.content});
}
