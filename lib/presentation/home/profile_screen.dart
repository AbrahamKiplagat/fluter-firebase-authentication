import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:hotel/presentation/dashboard/bookedby.dart';
import 'package:hotel/presentation/home/widgets/bottom_nav.dart';
import 'package:hotel/presentation/home/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hotel/domain/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final UserModel? user = authProvider.user;
    //debugPrint('${user!.email} is the user\'s name from the profile screen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple,Colors.yellow], // Replace with your desired colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Hi,  ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: user?.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('My name is pressed');
                        },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            _listTiles(
              title: 'Address 2',
              subtitle: 'My subtitle',
              icon: IconlyLight.profile,
              onPressed: () {},
              color: Colors.white,
            ),
            _listTiles(
              title: 'Bookings',
              icon: Icons.book,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingDisplayScreen()),
                );
              },
              color: Colors.white,
            ),
            _listTiles(
              title: 'Viewed',
              icon: IconlyLight.show,
              onPressed: () {},
              color: Colors.white,
            ),
            _listTiles(
              title: 'Forget password',
              icon: IconlyLight.unlock,
              onPressed: () {},
              color: Colors.white,
            ),
            _listTiles(
              title: 'Logout',
              icon: IconlyLight.logout,
              onPressed: () {
                authProvider.signOut(context);
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
      ),
      subtitle: TextWidget(
        text: subtitle ?? '',
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon, color: color),
      trailing: const Icon(IconlyLight.arrowRight2, color: Colors.white),
      onTap: () {
        onPressed();
      },
    );
  }
}
