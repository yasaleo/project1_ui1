import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

class PlaylistCard extends StatelessWidget {
  FolderModel foldermodel;
  
  int index;
  PlaylistCard({Key? key,  required this.index,required this.foldermodel})
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
                  child: foldermodel.image==''
                  ?Text('nope')
                   :Image.memory(
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
                    PlaylistDB.instance.deletefolder(index);
                    PlaylistDB.instance.playlistnotifier.notifyListeners();
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
