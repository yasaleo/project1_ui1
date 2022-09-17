import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen(
      {super.key, required this.folderindex, required this.playlistname});
  final int folderindex;
  String playlistname;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late List<SongModel> playlistsong;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          actions: [
            
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
              child: Image.asset(
                'assets/imageee2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(widget.playlistname,
                style: GoogleFonts.capriola(
                    textStyle: const TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 85, 85, 85),
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
                  // print(value[widget.folderindex].songids[1]);
                  final songlistids = value[widget.folderindex].songids;
                  playlistsong =
                      playlistsongs(ids: songlistids, songs: item.data!);
                  return songlistids.isEmpty
                      ? const Center(child: Text('nope  '))
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
                                      onTap: () {},
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
                                          onPressed: () {},
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
      // print(songs[i].id);
      // print(
      //     '====================================================================================================================================##################');
      // print(ids.length);
      for (var j = 0; j < ids.length; j++) {
        // print(ids[j]);
        if (songs[i].id == ids[j]) {
          print('found');
          pls.add(songs[i]);
        }
      }
    }
    return pls;
  }
}
