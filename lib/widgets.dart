import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Customlisttile extends StatelessWidget {
 const Customlisttile(
      {super.key,
      required this.artistname,
      required this.widget,
      
      required this.id,
      required this.ontap,
      required this.songname});
 final Function ontap;


 final  Widget widget;

  final String songname;
  final String artistname;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(26, 0, 0, 0),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              horizontalTitleGap: 8,
              onTap: () {
                ontap();
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(13, 0, 0, 0),
                foregroundColor: Colors.black54,
                child: QueryArtworkWidget(
                  artworkFit: BoxFit.fill,
                  id: id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note_outlined),
                ),
              ),
              title: Text(
                songname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                artistname.toString() == "<unknown>"
                    ? 'Unknown Artist'
                    : artistname.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
              trailing: SizedBox(
                height: 55,
                width: 35,
                child: widget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
