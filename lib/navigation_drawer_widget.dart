import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/pages/searchpage.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      backgroundColor: const Color.fromARGB(253, 158, 158, 158),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(10))),
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 19, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Musify',
                  style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            onTap: () {
              showGeneralDialog(
                barrierColor: const Color.fromARGB(80, 0, 0, 0),
                context: context,
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var curve = Curves.elasticOut.transform(animation.value);
                  return Transform.scale(
                    scaleY: curve,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 900),
                pageBuilder: (context, a1, a2) {
                  return Dialog(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromARGB(255, 186, 186, 186),
                      ),
                      height: 320,
                      child: Column(
                        children: [
                          LottieBuilder.asset(
                            'assets/104320-warning-red.json',
                            height: 200,
                          ),
                          const Text(
                            'Do you want to reset ?',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          255, 69, 69, 69)),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white60),
                                      )),
                                ),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          255, 151, 28, 19)),
                                  child: TextButton(
                                      onPressed: () {
                                        PlaylistDB.instance.reset(context);
                                      },
                                      child: const Text(
                                        'Reset',
                                        style: TextStyle(color: Colors.white70),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            leading: const Icon(
              Icons.history,
              size: 30,
              color: Colors.black,
            ),
            title: const Text(
              'Reset',
              style: TextStyle(fontSize: 28),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  child: const SearchPage(),
                  type: PageTransitionType.leftToRight));
            },
            leading: const Icon(
              Icons.search_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 28),
            ),
          ),
          const Divider(
            thickness: 3,
            indent: 20,
            endIndent: 42,
            height: 40,
          ),
          ListTile(
            onTap: () {
              FutureBuilder(
                future: Future.delayed(
                  const Duration(milliseconds: 30),
                  () {
                    // return
                  },
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.data;
                },
              );
            },
            leading: const Icon(
              Icons.share,
              size: 25,
              color: Colors.black26,
            ),
            title: const Text(
              'Share',
              style: TextStyle(fontSize: 24, color: Colors.black38),
            ),
          ),
          ListTile(
            onTap: () {
              mail();
            },
            leading: const Icon(
              Icons.contact_support,
              size: 25,
              color: Colors.black26,
            ),
            title: const Text(
              'Contact',
              style: TextStyle(fontSize: 24, color: Colors.black38),
            ),
          ),
          ListTile(
            onTap: () {
              about();
            },
            leading: const Icon(
              Icons.person,
              size: 25,
              color: Colors.black26,
            ),
            title: const Text(
              'About Developer',
              style: TextStyle(fontSize: 24, color: Colors.black38),
            ),
          ),
          const SizedBox(
            height: 233,
          ),
          const Center(
            child: Text('V.1.0.0',
                style: TextStyle(fontSize: 17, color: Colors.black38),),
          )
        ],
      ),
    );
  }

  Future<void> mail() async {
    if (await launchUrlString('mailto:yadhusanil26@gmail.com')) {
      throw 'tryagain';
    }
  }

  Future<void> about() async {
    if (await launchUrlString('https://github.com/yasaleo')) {
      throw 'tryagain';
    }
  }
}
