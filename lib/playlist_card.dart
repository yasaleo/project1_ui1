import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

class PlaylistCard extends StatelessWidget {
  FolderModel foldermodel;

  int index;
  PlaylistCard({Key? key, required this.index, required this.foldermodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(26, 0, 0, 0),
                blurRadius: 8,
                spreadRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(17),
          ),
          width: 155,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  child: foldermodel.image == ''
                      ? Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: LottieBuilder.asset(
                            'assets/46352-folder-icon-animation.json',
                            repeat: false,
                          ),
                        )
                      : Image.memory(
                          base64Decode(foldermodel.image),
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 10, left: 14),
                child: Text(
                  foldermodel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: const Color.fromARGB(13, 0, 0, 0),
                      fixedSize: const Size(85, 15)),
                  onPressed: () {
                    showGeneralDialog(
                      barrierColor: const Color.fromARGB(80, 0, 0, 0),
                      context: context,
                      transitionBuilder: (context, animation, secondaryAnimation, child) {
                        var curve = Curves.elasticOut.transform(animation.value);
                        return Transform.scale(
          scale: curve,
          child: child,
        );
                      },
                      transitionDuration: Duration(milliseconds: 900),
                      pageBuilder: (context,a1,a2) {
                        return Dialog(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color.fromARGB(255, 152, 112, 112),
                            ),
                            height: 320,
                            child: Column(
                              children: [
                                LottieBuilder.asset(
                                  'assets/1vc5MThiKE.json',
                                  height: 200,
                                ),
                                const Text(
                                  'Do you want to delete ?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 69, 69, 69)),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            )),
                                      ),
                                      Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 151, 28, 19)),
                                        child: TextButton(
                                            onPressed: () {
                                              PlaylistDB.instance
                                                  .deletefolder(index);
                                              PlaylistDB
                                                  .instance.playlistnotifier
                                                  .notifyListeners();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white70),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Color.fromARGB(255, 71, 5, 0),
                        size: 18,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
