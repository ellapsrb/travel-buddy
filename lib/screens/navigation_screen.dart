import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'wishlist_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE5EDF3),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Halaman Profil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B57),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFFE5EDF3),
              child: Icon(Icons.person, size: 65, color: Color(0xFF173B57)),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Pengguna TravelBuddy',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173B57),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Selamat datang di TravelBuddy!',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF173B57)),
              title: const Text('Tentang Aplikasi'),
              subtitle: const Text(
                'TravelBuddy - Temukan destinasi wisata impianmu.',
              ),
            ),
          ),
          Card(
            color: Colors.white,
            child: const ListTile(
              leading: Icon(Icons.explore_outlined, color: Color(0xFF173B57)),
              title: Text('TravelBuddy'),
              subtitle: Text(
                'Aplikasi pencarian dan wishlist destinasi wisata.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
