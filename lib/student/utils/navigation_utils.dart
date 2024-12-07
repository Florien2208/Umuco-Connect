import 'package:flutter/material.dart';
import '../pages/account_screen.dart';
import '../pages/wishlist_screen.dart';
import '../pages/search_screen.dart';
import '../pages/courses_screen.dart';
import '../pages/home_screen.dart';

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

  // List of screens in the same order as bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CoursesScreen(),
    const WishlistScreen(),
    HomePage(userEmail: null), // Placeholder, will be replaced in initState
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
        title: Text(_getAppBarTitle()),
        backgroundColor: const Color(0xFFEFC94C),
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notification functionality
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
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFEFC94C),
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
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color(0xFFEFC94C),
        
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFFEFC94C),
        unselectedItemColor: Colors.grey,
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
