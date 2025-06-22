import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/login.dart';
import 'home_tab.dart';
import 'add_friends_tab.dart';
import 'add_post_tab.dart';
import 'search_tab.dart';
import 'profile_tab.dart';
import 'home_fab.dart';
import '../../screens/profile/profile.dart';

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
              MaterialPageRoute(builder: (context) => SignInScreen()),
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
              // Add your message icon action here
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeTab(),
          AddFriendsTab(),
          AddPostTab(),
          SearchTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
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
    title: const Text("Plan a trip"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: const Color.fromARGB(255, 24, 185, 83),
  ),
];
