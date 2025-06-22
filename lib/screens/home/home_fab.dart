import 'package:flutter/material.dart';
import 'chatbot_window.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'chatbot_fab',
      backgroundColor: Colors.black,
      child: const Icon(Icons.smart_toy, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => const ChatBotWindow(),
        );
      },
    );
  }
}
