import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/Database/favoritesdb.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/pages/custom_animated.dart';

import 'dbmodel/foldermodel.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String artist;
  final int id;
  final Function ontap;
  final Function addingfav;
  final bool islikedd;
  final SongModel songModell;

  ListCard(
      {Key? key,
      required this.artist,
      required this.title,
      required this.ontap,
      required this.id,
      required this.addingfav,
      required this.islikedd,
      required this.songModell})
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
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.001),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: DraggableScrollableSheet(
                                    initialChildSize: 0.4,
                                    minChildSize: 0.2,
                                    maxChildSize: 0.75,
                                    builder: (_, controller) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.remove,
                                              color: Colors.grey[600],
                                            ),
                                            Expanded(
                                              child: ValueListenableBuilder(
                                                  valueListenable: PlaylistDB
                                                      .instance
                                                      .playlistnotifier,
                                                  builder: (context,
                                                      List<FolderModel> value,
                                                      Widget? _) {
                                                    return value.isEmpty
                                                        ? Center(
                                                            child: Column(
                                                              children: [
                                                                LottieBuilder.asset('assets/WaYDLCo9Ux.json'
                                                                ,width: 170,height: 170,),
                                                                Text(
                                                                  'No Playlist found !',
                                                                  style: TextStyle(
                                                                      fontSize: 40,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            controller:
                                                                controller,
                                                            itemCount:
                                                                value.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            8),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child:
                                                                      BackdropFilter(
                                                                    filter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            4,
                                                                        sigmaY:
                                                                            4),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            color: Color.fromARGB(
                                                                                26,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            blurRadius:
                                                                                8,
                                                                            spreadRadius:
                                                                                1,
                                                                            offset:
                                                                                Offset(0, 0),
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        horizontalTitleGap:
                                                                            8,
                                                                        onTap:
                                                                            () {
                                                                          if (value[index].isValuein(songModell.id)) {
                                                                            value[index].deletedata(songModell.id);
                                                                            PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                          } else {
                                                                            value[index].add(songModell.id);
                                                                            PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                          }
                                                                        },
                                                                        leading:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundColor: const Color.fromARGB(
                                                                              13,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          foregroundColor:
                                                                              Colors.black54,
                                                                          child:
                                                                              Text("$index"),
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          value[index]
                                                                              .name,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        trailing: SizedBox(
                                                                            height:
                                                                                55,
                                                                            width:
                                                                                35,
                                                                            child:
                                                                                AddRemoveButton(isclickedd: value[index].isValuein(songModell.id))

                                                                        
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
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
                  artworkFit: BoxFit.fill,
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
                height: 48,
                width: 38,
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
                  likeBuilder: (islikedd) {
                    return FavoritesDB.isfavorite(songModell)
                        ? Icon(
                            Icons.favorite,
                            color: const Color.fromARGB(255, 129, 9, 0),
                            size: 32,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Color.fromARGB(225, 0, 0, 0),
                            size: 32,
                          );
                  },
                  onTap: (islikedd) async {
                   await addingfav();
                    Variableclass.instance.isclickedd.notifyListeners();

                    return !islikedd;
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
