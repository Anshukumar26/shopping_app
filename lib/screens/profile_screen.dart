// // profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:shopping_app/screens/login_screen.dart';
// import 'package:shopping_app/screens/navigation_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final String userName = 'John Doe';
//   final String email = 'john.doe@example.com';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         automaticallyImplyLeading: Navigator.canPop(context), // only show back if possible
//         leading: Navigator.canPop(context)
//             ? IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: (){Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => NavigationScreen()),
//           );},
//         )
//             : null,
//       ),
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage('images/profile.jpg'),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     userName,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(email, style: TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             _buildSectionTitle('My Orders'),
//             _buildTile(Icons.shopping_bag, 'Track Orders', () {}),
//             _buildTile(Icons.repeat, 'Order History', () {}),
//             SizedBox(height: 20),
//             _buildSectionTitle('Personalization'),
//             _buildTile(Icons.star, 'Recommended for You', () {}),
//             _buildTile(Icons.style, 'Style Insights', () {}),
//             _buildTile(Icons.history, 'Recently Viewed', () {}),
//             SizedBox(height: 20),
//             _buildSectionTitle('Settings'),
//             _buildTile(Icons.settings, 'Account Settings', () {}),
//             _buildTile(Icons.logout, 'Logout', () {Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => LoginScreen()),
//             );}),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     );
//   }
//
//   Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.deepPurple),
//       title: Text(title),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: onTap,
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  Future<void> _signOut() async {
    try {
      setState(() => _isLoading = true);
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.pink[100],
                  child: Text(
                    _currentUser?.email?[0].toUpperCase() ?? 'U',
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // User Information Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'User Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.email, color: Colors.pink),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _currentUser?.email ?? 'No email available',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.pink),
                            const SizedBox(width: 10),
                            Text(
                              'UID: ${_currentUser?.uid.substring(0, 8) ?? 'N/A'}...',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Logout Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _signOut,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.pink,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}