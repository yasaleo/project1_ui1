import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String artist;
  final int id;
  final Function ontap;
  const ListCard(
      {Key? key,
      required this.artist,
      required this.title,
      required this.ontap,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: 72,
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
          child: Slidable(
            useTextDirection: true,
            endActionPane: ActionPane(
                extentRatio: 1 / 4.5,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: ((context) {
                      showModalBottomSheet(
                        enableDrag: true,
                        backgroundColor: const Color.fromARGB(255, 158, 158, 158),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? const Padding(
                                          padding:  EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 130),
                                          child: Text('Select a Playlist'),
                                        )
                                      : ListTile(
                                          title: Text('Playlist $index'),
                                        );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: 10),
                          );
                        },
                      );
                    }),
                    icon: Icons.playlist_add,
                    backgroundColor: const Color.fromARGB(145, 158, 158, 158),
                    foregroundColor: const Color.fromARGB(255, 7, 7, 7),
                  ),
                ]),
            child: ListTile(
              horizontalTitleGap: 8,
              onTap: () => ontap(),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(13, 0, 0, 0),
                foregroundColor: Colors.black54,
                child: QueryArtworkWidget(
                  id: id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note_outlined),
                ),
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
              trailing: SizedBox(
                height: 25,
                width: 35,
                child: LikeButton(
                  animationDuration: const Duration(milliseconds: 1450),
                  bubblesSize: 70,
                  circleSize: 50,
                  circleColor: const CircleColor(
                    start: Color.fromARGB(52, 10, 10, 10),
                    end: Color.fromARGB(255, 255, 0, 0),
                  ),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color.fromARGB(255, 255, 22, 1),
                    dotSecondaryColor: Color.fromARGB(255, 125, 0, 0),
                    dotThirdColor: Color.fromARGB(255, 255, 95, 92),
                    dotLastColor: Color.fromARGB(255, 80, 5, 0),
                  ),
                  likeBuilder: (isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? const Color.fromARGB(255, 129, 9, 0)
                          : Colors.black,
                      size: 29.5,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
