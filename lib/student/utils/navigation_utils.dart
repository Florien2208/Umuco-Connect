import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/account_screen.dart';
import '../pages/wishlist_screen.dart';
import '../pages/search_screen.dart';
import '../pages/courses_screen.dart';
import '../pages/home_screen.dart';
import './notification_screen.dart';
import '../../theme/app_themes.dart';
import '../../theme/theme_provider.dart';

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
  List<dynamic> _searchResults = [];

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CoursesScreen(),
    const CourseWishlistScreen(),
    const AccountScreen(userEmail: null),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _screens[4] = AccountScreen(userEmail: widget.userEmail);
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
      if (index != 1) {
        _searchController.clear();
        _searchResults.clear();
      }
    });
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _searchResults = List.generate(
          5,
          (index) => {
            'title': 'Search Result ${index + 1}',
            'description': 'Description for $query result ${index + 1}'
          },
        );
      } else {
        _searchResults.clear();
      }
    });
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'UMUCO CONNECT';
      case 1:
        return 'Search';
      case 2:
        return 'Courses';
      case 3:
        return 'Wishlist';
      case 4:
        return 'Account';
      default:
        return 'UMUCO CONNECT';
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
          title: _currentIndex == 1
              ? Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
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
                      prefixIcon: Icon(Icons.search,
                          color: isDark ? Colors.white70 : Colors.black54),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color:
                                      isDark ? Colors.white70 : Colors.black54),
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
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16),
                    onChanged: _performSearch,
                  ),
                )
              : Text(_getAppBarTitle()),
          titleSpacing: 10,
          backgroundColor:
              isDark ? const Color(0xFF553723) : const Color(0xFFD8A98B),
          foregroundColor: isDark ? Colors.white : Colors.black,
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
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
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
                  const HomeScreen(),
                  if (_searchController.text.isNotEmpty)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: isDark
                            ? Colors.black.withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
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
          backgroundColor:
              isDark ? const Color(0xFF553723) : const Color(0xFFD8A98B),
          currentIndex: _currentIndex,
          onTap: _onBottomNavTap,
          selectedItemColor: const Color.fromARGB(255, 24, 45, 227),
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
      ),
    );
  }
}
