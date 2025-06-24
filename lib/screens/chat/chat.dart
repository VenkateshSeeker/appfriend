import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../chat_interface/chat_interface.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = const [
    {
      'name': 'Alice Johnson',
      'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
      'lastMessage': 'See you at 7pm!',
      'timestamp': '09:24',
      'online': true,
      'typing': false,
      'seen': true,
    },
    {
      'name': 'Bob Smith',
      'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
      'lastMessage': 'Typing...',
      'timestamp': '08:55',
      'online': true,
      'typing': true,
      'seen': false,
    },
    {
      'name': 'Priya Patel',
      'avatar': 'https://randomuser.me/api/portraits/women/65.jpg',
      'lastMessage': 'Thanks for the update!',
      'timestamp': 'Yesterday',
      'online': false,
      'typing': false,
      'seen': true,
    },
    {
      'name': 'David Lee',
      'avatar': 'https://randomuser.me/api/portraits/men/76.jpg',
      'lastMessage': 'Let’s catch up soon.',
      'timestamp': 'Yesterday',
      'online': false,
      'typing': false,
      'seen': false,
    },
    {
      'name': 'Sara Kim',
      'avatar': 'https://randomuser.me/api/portraits/women/12.jpg',
      'lastMessage': 'Photo looks great! 📸',
      'timestamp': 'Mon',
      'online': true,
      'typing': false,
      'seen': true,
    },
  ];

  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Inbox',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
              ),
              style: GoogleFonts.poppins(),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (context, index) =>
                  const Divider(indent: 80, endIndent: 16, height: 0),
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userName: chat['name'],
                          userAvatar: chat['avatar'],
                          lastSeen: chat['typing']
                              ? 'typing...'
                              : 'Last seen ${chat['timestamp']}',
                          backgroundUrl:
                              chat['image'] ??
                              'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                        ),
                      ),
                    );
                  },
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(chat['avatar']),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: chat['online']
                                ? Colors.green
                                : Colors.grey[400],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['name'],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        chat['timestamp'],
                        style: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      if (chat['typing'])
                        Text(
                          'Typing...',
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      else
                        Expanded(
                          child: Text(
                            chat['lastMessage'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      if (chat['seen'])
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.done_all,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
