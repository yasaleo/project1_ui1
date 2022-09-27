// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';
import 'package:project1_ui1/pages/custom_animated.dart';
import 'package:project1_ui1/pages/home_page.dart';

import '../commonvariables.dart';
import 'front_screen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen(
      {super.key, required this.folderindex, required this.moldermodel});
  final int folderindex;

  final FolderModel moldermodel;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late List<SongModel> songmodellist = [];
  @override
  void initState() {
    songmodellist = Variableclass.fullsongmodellist;
    super.initState();
  }

  late List<SongModel> playlistsong;
  final OnAudioQuery audioQuery = OnAudioQuery();
  final snackbar = const SnackBar(
      backgroundColor: Color.fromARGB(255, 99, 7, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      duration: Duration(milliseconds: 450),
      content: Text(
        'Removed from Playlist',
        style: TextStyle(
            color: Color.fromARGB(179, 255, 255, 255),
            fontSize: 19,
            fontWeight: FontWeight.w700),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(189, 177, 177, 177),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () {
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
                                                    .instance.playlistnotifier,
                                                builder: (context, value,
                                                    Widget? _) {
                                                  return ListView.builder(
                                                    controller: controller,
                                                    itemCount:
                                                        songmodellist.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                bottom: 8),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 4,
                                                                    sigmaY: 4),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            26,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    blurRadius:
                                                                        8,
                                                                    spreadRadius:
                                                                        1,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: ListTile(
                                                                horizontalTitleGap:
                                                                    8,
                                                                onTap: () {},
                                                                leading:
                                                                    CircleAvatar(
                                                                  radius: 25,
                                                                  backgroundColor:
                                                                      const Color
                                                                              .fromARGB(
                                                                          13,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black54,
                                                                  child:
                                                                      QueryArtworkWidget(
                                                                    artworkFit:
                                                                        BoxFit
                                                                            .fill,
                                                                    id: songmodellist[
                                                                            index]
                                                                        .id,
                                                                    type: ArtworkType
                                                                        .AUDIO,
                                                                    nullArtworkWidget:
                                                                        const Icon(
                                                                            Icons.music_note_outlined),
                                                                  ),
                                                                ),
                                                                title: Text(
                                                                  songmodellist[
                                                                          index]
                                                                      .displayNameWOExt,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                subtitle: Text(
                                                                  songmodellist[index]
                                                                              .artist
                                                                              .toString() ==
                                                                          "<unknown>"
                                                                      ? 'Unknown Artist'
                                                                      : songmodellist[
                                                                              index]
                                                                          .artist
                                                                          .toString(),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                trailing:
                                                                    SizedBox(
                                                                  height: 55,
                                                                  width: 35,
                                                                  child:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (widget.moldermodel.isValuein(songmodellist[index].id)) {
                                                                              widget.moldermodel.deletedata(songmodellist[index].id);

                                                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                                              PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                            } else {
                                                                              playlistCheck(songmodellist[index]);
                                                                              PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                              Variableclass.instance.isclickedd.notifyListeners();
                                                                              PlaylistDB.instance.getallfolder();
                                                                            }
                                                                          },
                                                                          icon:
                                                                              AddRemoveButton(isclickedd: widget.moldermodel.isValuein(songmodellist[index].id))),
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
                    },
                    icon: const Icon(Icons.my_library_music_outlined)),
              ),
            )
          ],
          centerTitle: true,
          stretch: true,
          elevation: 0,
          backgroundColor: Colors.grey,
          expandedHeight: 280,
          collapsedHeight: 60,
          pinned: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Padding(
              padding: EdgeInsets.only(top: 8, right: 0),
              child: Icon(
                Icons.expand_more_outlined,
                color: Colors.black,
                size: 50,
                shadows: [
                  Shadow(
                    color: Colors.black87,
                    blurRadius: 9,
                  )
                ],
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            collapseMode: CollapseMode.pin,
            background: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (rect) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black])
                  .createShader(rect),
              child: widget.moldermodel.image == ''
                  ? LottieBuilder.asset(
                      'assets/57276-astronaut-and-music.json',
                      repeat: false,
                    )
                  : Image.memory(
                      base64Decode(widget.moldermodel.image),
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(widget.moldermodel.name,
                style: GoogleFonts.capriola(
                    textStyle: const TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontWeight: FontWeight.w500))),
            titlePadding: const EdgeInsets.only(left: 115),
            expandedTitleScale: 1.6,
          ),
        ),
        SliverToBoxAdapter(
            child: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: SongSortType.DATE_ADDED,
              orderType: OrderType.DESC_OR_GREATER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'NO Songs Found',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              );
            }
            return ValueListenableBuilder(
                valueListenable: PlaylistDB.instance.playlistnotifier,
                builder: (context, List<FolderModel> value, Widget? _) {
                  final songlistids = value[widget.folderindex].songids;
                  playlistsong =
                      playlistsongs(ids: songlistids, songs: item.data!);
                  return songlistids.isEmpty
                      ? Center(
                          child: ShaderMask(
                            blendMode: BlendMode.hue,
                            shaderCallback: (rect) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey,
                                  Color.fromARGB(174, 158, 158, 158)
                                ]).createShader(rect),
                            child: LottieBuilder.asset(
                              'assets/67379-no-data.json',
                              reverse: false,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          primary: true,
                          shrinkWrap: true,
                          itemCount: playlistsong.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
                                        mycolors.shufflemycolors();

                                        List<SongModel> newlist = playlistsong;
                                        Variableclass.miniplsonglist =
                                            playlistsong;
                                        Variableclass.audioPlayer.stop();
                                        Variableclass.audioPlayer
                                            .setAudioSource(
                                                Variableclass.playsongs(
                                                    newlist),
                                                initialIndex: index);
                                        Variableclass.audioPlayer.play();
                                        Variableclass
                                            .instance.isclickedd.value = true;
                                        Variableclass.minivisible = true;

                                        Variableclass.instance.isclickedd
                                            .notifyListeners();

                                        Navigator.of(context)
                                            .push(PageTransition(
                                          curve: Curves.easeOutCirc,
                                          child: HomeScreen(songlist: newlist),
                                          type: PageTransitionType.size,
                                          alignment: Alignment.bottomCenter,
                                          duration:
                                              const Duration(milliseconds: 750),
                                          reverseDuration:
                                              const Duration(milliseconds: 534),
                                        ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            const Color.fromARGB(13, 0, 0, 0),
                                        foregroundColor: Colors.black54,
                                        child: QueryArtworkWidget(
                                          artworkFit: BoxFit.fill,
                                          id: playlistsong[index].id,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: const Icon(
                                              Icons.music_note_outlined),
                                        ),
                                      ),
                                      title: Text(
                                        playlistsong[index].displayNameWOExt,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        playlistsong[index].artist.toString() ==
                                                "<unknown>"
                                            ? 'Unknown Artist'
                                            : playlistsong[index]
                                                .artist
                                                .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      trailing: SizedBox(
                                        height: 55,
                                        width: 35,
                                        child: IconButton(
                                          onPressed: () {
                                            widget.moldermodel.deletedata(
                                                playlistsong[index].id);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackbar);
                                            PlaylistDB.instance.playlistnotifier
                                                .notifyListeners();
                                          },
                                          icon: const Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color:
                                                Color.fromARGB(255, 83, 6, 1),
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                });
          },
        ))
      ]),
    );
  }

  List<SongModel> playlistsongs(
      {required List<int> ids, required List<SongModel> songs}) {
    List<SongModel> pls = [];
    for (var i = 0; i < songs.length; i++) {
      for (var j = 0; j < ids.length; j++) {
        if (songs[i].id == ids[j]) {
          pls.add(songs[i]);
        }
      }
    }
    return pls;
  }

  void playlistCheck(SongModel data) {
    if (!widget.moldermodel.isValuein(data.id)) {
      widget.moldermodel.add(data.id);
      const snackbar = SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13), topRight: Radius.circular(13))),
          duration: Duration(milliseconds: 450),
          backgroundColor: Color.fromARGB(255, 131, 131, 131),
          content: Text(
            'song Added to Playlist',
            style: TextStyle(
                color: Color.fromARGB(255, 86, 0, 0),
                fontSize: 19,
                fontWeight: FontWeight.w700),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
