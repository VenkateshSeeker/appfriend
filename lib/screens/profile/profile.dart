import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<Map<String, String>> highlights = [
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'title': 'Bali',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Alps',
    },
    {
      'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      'title': 'NYC',
    },
    {
      'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
      'title': 'Safari',
    },
    {'image': '', 'title': '+ New'},
  ];

  final List<Map<String, dynamic>> posts = List.generate(
    36,
        (i) => {
      'image': 'https://picsum.photos/id/${i + 10}/400/400',
      'views': 100 * (i + 1),
      'isReel': i % 3 == 0,
      'caption': 'Caption for post #${i + 1}',
    },
  );

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat('Posts', 48),
                      _buildStat('Followers', 1200),
                      _buildStat('Following', 180),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user?.displayName ?? 'User',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? '',
              style: GoogleFonts.poppins(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    child: Text(
                      'Share Profile',
                      style: GoogleFonts.poppins(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: highlights.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, i) {
                  final h = highlights[i];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: h['image']!.isNotEmpty
                            ? NetworkImage(h['image']!)
                            : null,
                        child: h['image']!.isEmpty
                            ? const Icon(Icons.add,
                            color: Colors.blueAccent, size: 32)
                            : null,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        h['title']!,
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            DefaultTabController(
              length: 3,
              child: SizedBox(
                height: 600,
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: Colors.blueAccent,
                      labelColor: Colors.blueAccent,
                      unselectedLabelColor: Colors.black54,
                      tabs: [
                        Tab(icon: Icon(Icons.grid_on)),
                        Tab(icon: Icon(Icons.movie_creation_outlined)),
                        Tab(icon: Icon(Icons.person_pin_outlined)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildGrid(context, posts),
                          _buildGrid(
                            context,
                            posts.where((p) => p['isReel']).toList(),
                          ),
                          _buildGrid(context, posts),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> items) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final post = items[i];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        post['image'],
                        fit: BoxFit.cover,
                        width: 320,
                        height: 320,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      post['caption'] ?? '',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        shadows: [const Shadow(blurRadius: 8, color: Colors.black)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              if (post['isReel'])
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.remove_red_eye,
                          color: Colors.white, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${post['views']}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
