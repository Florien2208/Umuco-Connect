import 'package:flutter/material.dart';
import '../pages/account_screen.dart';
import '../pages/wishlist_screen.dart';
import '../pages/search_screen.dart';
import '../pages/courses_screen.dart';
import '../pages/home_screen.dart';
import './notification_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  final String? userEmail;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
    this.userEmail,
  });

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = []; // Add this to store search results

  // List of screens in the same order as bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CoursesScreen(),
    const CourseWishlistScreen(),
    const HomePage(
        userEmail: null), // Placeholder, will be replaced in initState
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Replace the last screen with HomePage with user email
    _screens[4] = HomePage(userEmail: widget.userEmail);
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;

      // Reset search state when navigating away from search
      if (index != 1) {
        _searchController.clear();
        _searchResults.clear(); // Clear search results
      }
    });
  }

  // Function to perform search
  void _performSearch(String query) {
    // TODO: Implement actual search logic
    // This is a placeholder implementation
    setState(() {
      if (query.isNotEmpty) {
        _searchResults = List.generate(
            5,
            (index) => {
                  'title': 'Search Result ${index + 1}',
                  'description': 'Description for $query result ${index + 1}'
                });
      } else {
        _searchResults.clear();
      }
    });
  }

  // Function to get the title based on the current screen
  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'UMUCO CONNECT ';
      case 1:
        return 'Search';
      case 2:
        return 'Courses';
      case 3:
        return 'Wishlist';
      case 4:
        return 'Account';
      default:
        return 'Electric Vehicle App';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 1
            ? Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search courses, content...',
                    prefixIcon: const Icon(Icons.search, color: Colors.black54),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon:
                                const Icon(Icons.clear, color: Colors.black54),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchResults.clear();
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: _performSearch,
                ),
              )
            : Text(_getAppBarTitle()),
        titleSpacing: 10,
        backgroundColor: const Color(0xFFD8A98B),
        foregroundColor: Colors.black,
        elevation: 0,
        actions: _currentIndex != 1
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsPage()),
                    );
                  },
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (String value) {
                    // TODO: Implement menu item actions
                    switch (value) {
                      case 'settings':
                        // Navigate to settings page
                        break;
                      case 'help':
                        // Show help or support page
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'settings',
                      child: Text('Settings'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'help',
                      child: Text('Help'),
                    ),
                  ],
                ),
              ]
            : null,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFD8A98B),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.userEmail ?? 'Guest User',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onBottomNavTap(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_eta),
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context);
                _onBottomNavTap(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_parking),
              title: const Text('Courses'),
              onTap: () {
                Navigator.pop(context);
                _onBottomNavTap(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Wishlist'),
              onTap: () {
                Navigator.pop(context);
                _onBottomNavTap(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
                _onBottomNavTap(4);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // TODO: Implement logout functionality
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentIndex == 1
          ? Stack(
              children: [
                const HomeScreen(), // Keep home screen as background
                if (_searchController.text.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final result = _searchResults[index];
                          return ListTile(
                            title: Text(result['title']),
                            subtitle: Text(result['description']),
                            onTap: () {
                              // TODO: Implement result selection logic
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ],
            )
          : IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFD8A98B),
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color.fromARGB(255, 24, 45, 227),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
