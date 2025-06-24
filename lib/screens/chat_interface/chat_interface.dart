import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String lastSeen;
  final String backgroundUrl;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.lastSeen,
    required this.backgroundUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with overlay for the entire screen
          Positioned.fill(
            child: Stack(
              children: [
                Image.network(
                  backgroundUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[200]),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.45),
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Foreground: header, chat, input
          Column(
            children: [
              // Header bar at the very top
              SafeArea(
                child: Container(
                  // Removed background color and borderRadius for transparency
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(userAvatar),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              lastSeen,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 13,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              // Main chat area
              Expanded(
                child: Stack(
                  children: [
                    // Static message bubbles
                    Positioned.fill(
                      top: 0,
                      bottom: 70, // leave space for input bar
                      child: SingleChildScrollView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildMessageBubble(
                              context,
                              isMe: false,
                              text: "Hey there! Welcome to Nomado 👋",
                              time: "09:30",
                              avatar: userAvatar,
                            ),
                            _buildMessageBubble(
                              context,
                              isMe: true,
                              text: "Hi! Thanks, excited to chat!",
                              time: "09:31",
                            ),
                            _buildMessageBubble(
                              context,
                              isMe: false,
                              text: "How can I help you plan your next trip?",
                              time: "09:32",
                              avatar: userAvatar,
                            ),
                            _buildMessageBubble(
                              context,
                              isMe: true,
                              text: "Looking for adventure destinations!",
                              time: "09:33",
                            ),
                            // Add more static messages as needed
                          ],
                        ),
                      ),
                    ),
                    // Message input bar
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(userAvatar),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.92),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        minLines: 1,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          hintText: 'Message',
                                          hintStyle: GoogleFonts.poppins(
                                            color: Colors.grey[600],
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                        ),
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.attach_file,
                                        color: Colors.blueAccent,
                                        size: 22,
                                      ),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.mic,
                                        color: Colors.green,
                                        size: 22,
                                      ),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.18),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                                padding: const EdgeInsets.all(12),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context, {
    required String text,
    required bool isMe,
    String? avatar,
    String? time,
  }) {
    final bubble = Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isMe ? 60 : 0,
        right: isMe ? 0 : 60,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe
            ? Colors.blueAccent.withOpacity(0.92)
            : Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isMe ? 20 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: isMe ? Colors.white : Colors.black87,
              fontSize: 15,
            ),
          ),
          if (time != null) ...[
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                color: isMe ? Colors.white70 : Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
    if (isMe) {
      return Align(alignment: Alignment.centerRight, child: bubble);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (avatar != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(avatar),
              ),
            ),
          bubble,
          const Spacer(),
        ],
      );
    }
  }
}
