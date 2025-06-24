import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Post Composer
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Write something...',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey[500],
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {},
                                tooltip: 'Photo',
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.videocam,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {},
                                tooltip: 'Video',
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                onPressed: () {},
                                tooltip: 'Location',
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.orange,
                                ),
                                onPressed: () {},
                                tooltip: 'Emoji',
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  textStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text('Post'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Posts Feed
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                post['avatar'] ?? '',
                              ),
                              onBackgroundImageError: (_, __) {},
                              child: post['avatar'] == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['user'] ?? '',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  post['handle'] ?? '',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.more_horiz, size: 22),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          post['caption'] ?? '',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        if (post['image'] != null &&
                            post['image'].toString().isNotEmpty) ...[
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              post['image'],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: 200,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 22,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${post['likes'] ?? 0}',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            const SizedBox(width: 18),
                            Icon(
                              Icons.mode_comment_outlined,
                              color: Colors.blueAccent,
                              size: 22,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${post['comments'] ?? 0}',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            const SizedBox(width: 18),
                            Icon(Icons.share, color: Colors.green, size: 22),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> posts = [
  {
    'user': 'Alice Wanderlust',
    'handle': '@alicew',
    'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
    'caption': 'Woke up to this view in the Swiss Alps! 🏔️',
    'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'likes': 120,
    'comments': 18,
  },
  {
    'user': 'Bob Nomad',
    'handle': '@bobnomad',
    'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
    'caption': 'Desert nights under a million stars.',
    'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'likes': 98,
    'comments': 12,
  },
  {
    'user': 'Priya Patel',
    'handle': '@priyapatel',
    'avatar': 'https://randomuser.me/api/portraits/women/65.jpg',
    'caption': 'Exploring the hidden gems of Kyoto.',
    'image': 'https://images.unsplash.com/photo-1507089947368-19c1da9775ae',
    'likes': 76,
    'comments': 9,
  },
  {
    'user': 'David Lee',
    'handle': '@davidlee',
    'avatar': 'https://randomuser.me/api/portraits/men/76.jpg',
    'caption': 'Hiking the Inca Trail was a dream come true!',
    'image': 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
    'likes': 54,
    'comments': 7,
  },
  {
    'user': 'Sara Kim',
    'handle': '@sarakim',
    'avatar': 'https://randomuser.me/api/portraits/women/12.jpg',
    'caption': 'Sunrise yoga on the beach. Namaste! 🌅',
    'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    'likes': 132,
    'comments': 21,
  },
  {
    'user': 'Liam Traveler',
    'handle': '@liamtravels',
    'avatar': 'https://randomuser.me/api/portraits/men/45.jpg',
    'caption': 'Safari adventure in Kenya. 🦁',
    'image': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    'likes': 88,
    'comments': 10,
  },
  {
    'user': 'Emma Globe',
    'handle': '@emmaglobe',
    'avatar': 'https://randomuser.me/api/portraits/women/22.jpg',
    'caption': 'Canoeing through the Amazon rainforest.',
    'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
    'likes': 77,
    'comments': 8,
  },
  {
    'user': 'Carlos Rivera',
    'handle': '@carlosr',
    'avatar': 'https://randomuser.me/api/portraits/men/34.jpg',
    'caption': 'Street food tour in Bangkok. So tasty! 🍜',
    'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'likes': 91,
    'comments': 13,
  },
  {
    'user': 'Mia Explorer',
    'handle': '@miaexplorer',
    'avatar': 'https://randomuser.me/api/portraits/women/33.jpg',
    'caption': 'Cliff diving in Croatia. What a rush!',
    'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'likes': 105,
    'comments': 15,
  },
  {
    'user': 'Noah Trekker',
    'handle': '@noahtrekker',
    'avatar': 'https://randomuser.me/api/portraits/men/23.jpg',
    'caption': 'Camping under the northern lights.',
    'image': 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
    'likes': 112,
    'comments': 17,
  },
  {
    'user': 'Olivia Journey',
    'handle': '@oliviajourney',
    'avatar': 'https://randomuser.me/api/portraits/women/55.jpg',
    'caption': 'Road tripping through New Zealand.',
    'image': 'https://images.unsplash.com/photo-1507089947368-19c1da9775ae',
    'likes': 99,
    'comments': 11,
  },
  {
    'user': 'Ethan Roamer',
    'handle': '@ethanroamer',
    'avatar': 'https://randomuser.me/api/portraits/men/56.jpg',
    'caption': 'Paragliding over the Dolomites!',
    'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'likes': 87,
    'comments': 9,
  },
  {
    'user': 'Sophia Trail',
    'handle': '@sophiatrail',
    'avatar': 'https://randomuser.me/api/portraits/women/77.jpg',
    'caption': 'Hot air balloon ride in Cappadocia.',
    'image': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    'likes': 124,
    'comments': 19,
  },
  {
    'user': 'Lucas Path',
    'handle': '@lucaspath',
    'avatar': 'https://randomuser.me/api/portraits/men/78.jpg',
    'caption': 'Surfing the waves in Hawaii.',
    'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    'likes': 93,
    'comments': 14,
  },
  {
    'user': 'Ava Globe',
    'handle': '@avaglobe',
    'avatar': 'https://randomuser.me/api/portraits/women/88.jpg',
    'caption': 'Snorkeling in the Great Barrier Reef.',
    'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
    'likes': 101,
    'comments': 16,
  },
  {
    'user': 'Mason Journey',
    'handle': '@masonjourney',
    'avatar': 'https://randomuser.me/api/portraits/men/89.jpg',
    'caption': 'Biking through Amsterdam’s canals.',
    'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'likes': 85,
    'comments': 10,
  },
  {
    'user': 'Ella Trek',
    'handle': '@ellatrek',
    'avatar': 'https://randomuser.me/api/portraits/women/90.jpg',
    'caption': 'Jungle trekking in Borneo.',
    'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'likes': 97,
    'comments': 12,
  },
  {
    'user': 'Henry Roam',
    'handle': '@henryroam',
    'avatar': 'https://randomuser.me/api/portraits/men/91.jpg',
    'caption': 'Kayaking in the Norwegian fjords.',
    'image': 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
    'likes': 109,
    'comments': 13,
  },
  {
    'user': 'Zoe Adventure',
    'handle': '@zoeadventure',
    'avatar': 'https://randomuser.me/api/portraits/women/92.jpg',
    'caption': 'Exploring the Sahara on camelback.',
    'image': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    'likes': 115,
    'comments': 18,
  },
  {
    'user': 'Jack Nomad',
    'handle': '@jacknomad',
    'avatar': 'https://randomuser.me/api/portraits/men/93.jpg',
    'caption': 'Skiing in the Rockies. Powder day!',
    'image': 'https://images.unsplash.com/photo-1507089947368-19c1da9775ae',
    'likes': 102,
    'comments': 15,
  },
];
