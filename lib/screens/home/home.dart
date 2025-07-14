import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/screens/profile/profile.dart';
import '../login/login.dart';
import 'home_tab.dart';
import 'home_fab.dart';
import '../add_post/add_post.dart';
import '../../screens/plan a trip/plan_a_trip.dart';
import '../chat/chat.dart';
import '../add_friend/add_friend.dart';

class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({super.key});

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            : Text(
                'Welcome Venkatesh',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ChatListScreen()));
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeTab(),
          AddFriendsScreen(),
          AddPostScreen(),
          PlanATripScreen(), // ✅ corrected here
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
      floatingActionButton: const HomeFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person_add),
    title: const Text("Add Friends"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.add_box),
    title: const Text("Add Post"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.flight),
    title: const Text("Plan a Trip"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
];
