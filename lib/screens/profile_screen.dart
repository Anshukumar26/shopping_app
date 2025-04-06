// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/navigation_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = 'John Doe';
  final String email = 'john.doe@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: Navigator.canPop(context), // only show back if possible
        leading: Navigator.canPop(context)
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
          );},
        )
            : null,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(email, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('My Orders'),
            _buildTile(Icons.shopping_bag, 'Track Orders', () {}),
            _buildTile(Icons.repeat, 'Order History', () {}),
            SizedBox(height: 20),
            _buildSectionTitle('Personalization'),
            _buildTile(Icons.star, 'Recommended for You', () {}),
            _buildTile(Icons.style, 'Style Insights', () {}),
            _buildTile(Icons.history, 'Recently Viewed', () {}),
            SizedBox(height: 20),
            _buildSectionTitle('Settings'),
            _buildTile(Icons.settings, 'Account Settings', () {}),
            _buildTile(Icons.logout, 'Logout', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
