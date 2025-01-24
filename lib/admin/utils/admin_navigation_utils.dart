import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umuco_connect_hub/admin/admin_dashboard/management_screen.dart';
import '../admin_dashboard/account_screen.dart';
import '../admin_dashboard/order_screen.dart';
import '../admin_dashboard/search_screen.dart';
import '../admin_dashboard/all_courses_screen.dart';
import '../admin_dashboard/home_screen.dart';
import './notification_screen.dart';
import '../../theme/app_themes.dart';
import '../../theme/theme_provider.dart';

class AdminMainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  final String? userEmail;

  const AdminMainNavigationScreen({
    super.key,
    this.initialIndex = 0,
    this.userEmail,
  });

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<AdminMainNavigationScreen> {
  late int _currentIndex;

  // List of screens in the same order as bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AllCoursesScreen(),
    const ManagementScreen(),
    const OrderScreen(),
    const AccountScreen(
        userEmail: null), // Placeholder, will be replaced in initState
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Replace the last screen with HomePage with user email
    _screens[5] = AccountScreen(userEmail: widget.userEmail);
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
        return 'ADMIN CONNECT ';
      case 1:
        return 'Search';
      case 2:
        return 'Courses';
      case 3:
        return 'Wishlist';
      case 4:
        return 'Courses';
      case 5:
        return 'Account';
      default:
        return 'Umuco Connect';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Theme(
      data: isDark ? AppThemes.darkTheme : AppThemes.lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getAppBarTitle()),
          backgroundColor:
              isDark ? const Color(0xFF553723) : const Color(0xFFD8A98B),
          foregroundColor: isDark ? Colors.white : Colors.black,
          elevation: 0,
          actions: [
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
                switch (value) {
                  case 'theme':
                    themeProvider.toggleTheme();
                    break;
                  case 'settings':
                    // Navigate to settings page
                    break;
                  case 'help':
                    // Show help or support page
                    break;
                  case 'logout':
                    // TODO: Implement logout functionality
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                      const SizedBox(width: 8),
                      Text(isDark ? 'Light Mode' : 'Dark Mode'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'help',
                  child: Text('Help'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
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
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF553723)
                      : const Color(0xFFD8A98B),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.userEmail ?? 'Guest User',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
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
                  _onBottomNavTap(5);
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
          backgroundColor:
              isDark ? const Color(0xFF553723) : const Color(0xFFD8A98B),
          currentIndex: _currentIndex,
          onTap: _onBottomNavTap,
          selectedItemColor: const Color.fromARGB(255, 57, 5, 245),
          unselectedItemColor: isDark ? Colors.white70 : Colors.black,
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
              label: 'All Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Management',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
