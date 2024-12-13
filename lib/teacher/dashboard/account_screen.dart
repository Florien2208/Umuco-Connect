import 'package:flutter/material.dart';
import '../../authentication/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  final String? userEmail;

  const AccountScreen({super.key, this.userEmail});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AccountScreen> {
  void _handleLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _navigateToScreen(VoidCallback navigationAction) {
    navigationAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom header
          

          // Account menu items
          Expanded(
            child: ListView(
              children: [
                AccountMenuItem(
                  icon: Icons.person,
                  title: 'My details',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('My Details screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.credit_card,
                  title: 'My payment methods',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Payment Methods screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.directions_car,
                  title: 'My vehicles',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Vehicles screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.local_offer,
                  title: 'My promo codes',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Promo Codes screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.notifications,
                  title: 'My notifications',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Notifications screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.help,
                  title: 'Help and support',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Help and Support screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.space_dashboard,
                  title: 'List your space',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('List Your Space screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.feedback,
                  title: 'App feedback',
                  onTap: () => _navigateToScreen(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('App Feedback screen coming soon!')),
                    );
                  }),
                ),
                AccountMenuItem(
                  icon: Icons.logout,
                  title: 'Log out',
                  onTap: _handleLogout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFEFC94C)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
