import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      backgroundColor: const Color.fromARGB(236, 158, 158, 158),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(10))),
      child: Container(
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 0),
              child: Text(
                'Musify',
                style: GoogleFonts.k2d(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            const ListTile(
              leading: Icon(
                Icons.history,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'History',
                style: TextStyle(fontSize: 28),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 28),
              ),
            ),
            const Divider(
              thickness: 3,
              endIndent: 42,
              height: 40,
            ),
            const ListTile(
              leading: Icon(
                Icons.share,
                size: 25,
                color: Colors.black26,
              ),
              title: Text(
                'Share',
                style: TextStyle(fontSize: 24, color: Colors.black38),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.contact_support,
                size: 25,
                color: Colors.black26,
              ),
              title: Text(
                'Contact',
                style: TextStyle(fontSize: 24, color: Colors.black38),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
                color: Colors.black26,
              ),
              title: Text(
                'about',
                style: TextStyle(fontSize: 24, color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
