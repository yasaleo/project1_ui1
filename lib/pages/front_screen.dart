import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project1_ui1/Database/favoritesdb.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/add_fav.dart';

import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';
import 'package:project1_ui1/listcard.dart';

import 'package:project1_ui1/navigation_drawer_widget.dart';
import 'package:project1_ui1/pages/addplaylist.dart';
import 'package:project1_ui1/pages/favorites.dart';
import 'package:project1_ui1/pages/home_page.dart';
import 'package:project1_ui1/pages/playlist_screen.dart';
import 'package:project1_ui1/playlist_card.dart';
import 'package:project1_ui1/my_colors.dart';

final mycolors = MyColors();

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => FrontScreenState();
}

class FrontScreenState extends State<FrontScreen>
    with TickerProviderStateMixin {
  final audioquery = OnAudioQuery();

  List<SongModel> songlist = [];

  late int passedindex;
  int indexxx = 0;
  SongModel? songModell;

  String songname = '';
  String songartist = '';
  bool isvisible = false;
  int id = 0;
  ScrollController scontrollerr = ScrollController();

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    PlaylistDB.instance.getallfolder();

    requestPermission();

    super.initState();
  }

  void requestPermission() async {
    var storagestatus = await Permission.storage.request();
    if (storagestatus.isGranted) {
      Variableclass.instance.isclickedd.notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
   
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      body: ValueListenableBuilder(
          valueListenable: Variableclass.instance.isclickedd,
          builder: (BuildContext context, bool newisclicked, Widget? child) {
            if (newisclicked) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            return AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Variableclass.instance.isclickedd.value
                  ? Color.fromARGB(
                      255, mycolors.color1, mycolors.color2, mycolors.color3)
                  : Colors.grey,
              child: CustomPaint(
                painter: LinePainter(),
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        PreferredSize(
                          preferredSize: const Size.fromHeight(180),
                          child: SliverAppBar(
                            stretch: true,
                            iconTheme: const IconThemeData(
                                size: 35, color: Colors.black),
                            pinned: true,
                            collapsedHeight:
                                MediaQuery.of(context).size.height * 9.2 / 100,
                            elevation: 0,
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            expandedHeight: 314,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Container(
                                color: Colors.transparent,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 60),
                                            Text('O',
                                                style: GoogleFonts.capriola(
                                                  textStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          185, 19, 19, 19),
                                                      fontSize: 80),
                                                )),
                                            Text('utburst',
                                                style: GoogleFonts.capriola(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 54,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 21),
                                          child: Text('your soul ',
                                              style: GoogleFonts.capriola(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 47,
                                                      fontWeight:
                                                          FontWeight.w400)))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 164),
                                        child: Text('with',
                                            style: GoogleFonts.capriola(
                                              textStyle: const TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 40),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              title: SizedBox(
                                height: 70,
                                width: 94.5,
                                child: Center(
                                    child: Text(
                                  'Musify',
                                  style: GoogleFonts.k2d(
                                    textStyle: const TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.black45,
                                              offset: Offset(2, 3),
                                              blurRadius: 8)
                                        ],
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      " Your playlist",
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 65,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor: Colors.black12,
                                            elevation: 0),
                                        onPressed: () {},
                                        child: const Text(
                                          'more',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
//---------------------------PLAYLISTS---------------------------------------------------------------------------------------------------
                              SizedBox(
                                height: 165,
                                child: ValueListenableBuilder(
                                    valueListenable:
                                        PlaylistDB.instance.playlistnotifier,
                                    builder: (context,
                                        List<FolderModel> playlistlist,
                                        Widget? _) {
                                      return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          print(playlistlist.length);

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 4.8, left: 4.8),
                                            child: index == 0
                                                ? Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      OpenContainer(
                                                        openElevation: 0,
                                                        closedElevation: 0,
                                                        middleColor:
                                                            Colors.grey,
                                                        openShape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            26))),
                                                        closedShape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            90))),
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    550),
                                                        closedColor:
                                                            Colors.transparent,
                                                        transitionType:
                                                            ContainerTransitionType
                                                                .fadeThrough,
                                                        closedBuilder: (BuildContext
                                                                context,
                                                            VoidCallback
                                                                opencontainer) {
                                                          return AddFavCard(
                                                            widget2:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 4),
                                                              child: Text(
                                                                'New playlist',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            height: 110,
                                                            width: 110,
                                                            borderRadius: 100,
                                                            widget:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 3.8),
                                                              child: Icon(
                                                                Icons
                                                                    .create_new_folder_rounded,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        37,
                                                                        37,
                                                                        37),
                                                                size: 42,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        openBuilder:
                                                            (context, action) {
                                                          return const AddPlaylist();
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      OpenContainer(
                                                        openElevation: 0,
                                                        closedElevation: 0,
                                                        middleColor:
                                                            Colors.grey,
                                                        openShape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            26))),
                                                        closedShape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    550),
                                                        closedColor:
                                                            Colors.transparent,
                                                        transitionType:
                                                            ContainerTransitionType
                                                                .fadeThrough,
                                                        closedBuilder: (BuildContext
                                                                context,
                                                            VoidCallback
                                                                opencontainer) {
                                                          return AddFavCard(
                                                            widget2:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 20),
                                                              child: Text(
                                                                'Favorites',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            height: 155,
                                                            width: 155,
                                                            borderRadius: 8,
                                                            widget:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10),
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        120,
                                                                        0,
                                                                        0),
                                                                size: 60,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        openBuilder:
                                                            (context, action) {
                                                          return const Favoritescreen();
                                                        },
                                                      )
                                                    ],
                                                  )
                                                : OpenContainer(
                                                    openElevation: 0,
                                                    closedElevation: 0,
                                                    middleColor: Colors.grey,
                                                    openShape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            26))),
                                                    closedShape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds: 550),
                                                    closedColor:
                                                        Colors.transparent,
                                                    transitionType:
                                                        ContainerTransitionType
                                                            .fadeThrough,
                                                    closedBuilder:
                                                        (BuildContext context,
                                                            VoidCallback
                                                                opencontainer) {
                                                      return PlaylistCard(
                                                        index: index - 1,
                                                        playlistname:
                                                            playlistlist[
                                                                    index - 1]
                                                                .name,
                                                      );
                                                    },
                                                    openBuilder:
                                                        (context, action) {
                                                      return PlaylistScreen(
                                                        folderindex: index - 1,
                                                        playlistname:
                                                            playlistlist[
                                                                    index - 1]
                                                                .name,
                                                      );
                                                    },
                                                  ),
                                          );
                                        },
                                        itemCount: playlistlist.length + 1,
                                        scrollDirection: Axis.horizontal,
                                      );
                                    }),
                              ),
//--------------------------AUDIO_FILES_LIST--------------------------------------------------------------------------------------------------------
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Audio files',
                                        style: TextStyle(
                                            fontSize: 23,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    1.8,
                                child: FutureBuilder<List<SongModel>>(
                                  future: audioquery.querySongs(
                                      sortType: SongSortType.DATE_ADDED,
                                      orderType: OrderType.DESC_OR_GREATER,
                                      uriType: UriType.EXTERNAL,
                                      ignoreCase: true),
                                  builder: (context, item) {
                                    if (item.data == null) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                    Variableclass.songlist = item.data!;
                                    if (!FavoritesDB.isintialised) {
                                      FavoritesDB.intialise(item.data!);
                                    }
                                    if (!item.hasData) {
                                      return const Center(
                                        child: Text('no songs'),
                                      );
                                    }
                                    return DraggableScrollbar.rrect(
                                      backgroundColor:
                                          const Color.fromARGB(255, 85, 85, 85),
                                      heightScrollThumb: 35,
                                      controller: scontrollerr,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        controller: scontrollerr,
                                        padding:
                                            const EdgeInsets.only(bottom: 90),
                                        itemBuilder: (context, index) {
                                          final songg = item.data!;

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: ListCard(
                                              songModell:
                                                  Variableclass.songlist[index],
                                              islikedd: FavoritesDB.isfavorite(
                                                  Variableclass
                                                      .songlist[index]),
                                              ontap: () {
                                                Variableclass.instance.isvisible
                                                    .notifyListeners();
                                                setState(() {

                                                  Variableclass.audioPlayer
                                                      .setAudioSource(
                                                          Variableclass
                                                              .playsongs(
                                                                  item.data!),
                                                          initialIndex: index);
                                                  Variableclass.audioPlayer
                                                      .play();

                                                  songModell = songg[index];
                                                  songlist = songg;
                                                  indexxx = index;
                                                  passedindex = index;
                                                  isvisible = true;
                                                  Variableclass.instance
                                                      .isclickedd.value = true;
                                                  _controller.forward();
                                                  mycolors.shufflemycolors();
                                                  id = songg[index].id;
                                                  songname = songg[index]
                                                      .displayNameWOExt;
                                                  songartist = songg[index]
                                                              .artist
                                                              .toString() ==
                                                          "<unknown>"
                                                      ? 'Unknown Artist'
                                                      : songg[index]
                                                          .artist
                                                          .toString();
                                                });
                                              },
                                              addingfav: () {
                                                if (FavoritesDB.isfavorite(
                                                    Variableclass
                                                        .songlist[index])) {
                                                  FavoritesDB.removefromfav(
                                                      Variableclass
                                                          .songlist[index].id);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                      Radius
                                                                          .circular(
                                                                              10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20))),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  250),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  99,
                                                                  7,
                                                                  0),
                                                          content: Text(
                                                            'Removed from Favorites',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        179,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )));
                                                } else {
                                                  FavoritesDB.addtofav(
                                                      Variableclass
                                                          .songlist[index]);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20))),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  250),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  131,
                                                                  131,
                                                                  131),
                                                          content: Text(
                                                            'Added to Favorites',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        86,
                                                                        0,
                                                                        0),
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )));
                                                }
                                                FavoritesDB.favorites
                                                    .notifyListeners();
                                              },
                                              title:
                                                  songg[index].displayNameWOExt,
                                              artist: songg[index]
                                                          .artist
                                                          .toString() ==
                                                      "<unknown>"
                                                  ? 'Unknown Artist'
                                                  : songg[index]
                                                      .artist
                                                      .toString(),
                                              id: songg[index].id,
                                            ),
                                          );
                                        },
                                        itemCount: item.data!.length,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
//------------------------------------------MINI_nowPlaying-------------------------------------------------------------------------------------------------------
                    Visibility(
                      visible: isvisible,
                      child: Positioned(
                        left: MediaQuery.of(context).size.width * 1.5 / 100,
                        right: MediaQuery.of(context).size.width * 1.5 / 100,
                        top: MediaQuery.of(context).size.height * 8.95 / 10,
                        bottom: MediaQuery.of(context).size.height * .6 / 100,
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(100, 61, 61, 61),
                                blurRadius: 10,
                                spreadRadius: 9,
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                                bottomLeft: Radius.circular(10)),
                            color: Color.fromARGB(250, 149, 149, 149),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(23),
                                  bottomLeft: Radius.circular(7),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1.6 / 1,
                                  child: ShaderMask(
                                    blendMode: BlendMode.dstOut,
                                    shaderCallback: (rect) =>
                                        const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                          Colors.transparent,
                                          Colors.black
                                        ]).createShader(rect),
                                    child: QueryArtworkWidget(
                                      artworkFit: BoxFit.fill,
                                      artworkBorder: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10)),
                                      id: id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget:
                                          const Icon(Icons.music_note_outlined),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 115,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        width: 140,
                                        child: Marquee(
                                          velocity: 35,
                                          fadingEdgeStartFraction: .6,
                                          showFadingOnlyWhenScrolling: false,
                                          text: songname,
                                          blankSpace: 90,
                                          pauseAfterRound:
                                              const Duration(milliseconds: 900),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 10, 10, 10),
                                          ),
                                        )),
                                    Text(
                                      songartist,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      mycolors.shufflemycolors();

                                      if (Variableclass
                                          .instance.isclickedd.value) {
                                        _controller.reverse();
                                      } else {
                                        _controller.forward();
                                      }
                                    },
                                  );

                                  if (Variableclass.instance.isclickedd.value) {
                                    
                                    Variableclass.audioPlayer.pause();
                                  } else {
                                    
                                    Variableclass.audioPlayer.play();
                                  }
                                  Variableclass.instance.isclickedd.value =
                                      !Variableclass.instance.isclickedd.value;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 133, 133, 133),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 84, 84, 84)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: AnimatedIcon(
                                      size: 44,
                                      icon: AnimatedIcons.play_pause,
                                      progress: _controller),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      curve: Curves.easeOutCirc,
                                      child: HomeScreen(
                                        songModel: songModell!,
                                        songlist: songlist,
                                        passedindex: passedindex,
                                        
                                        isclicked: Variableclass
                                            .instance.isclickedd.value,
                                      ),
                                      type: PageTransitionType.size,
                                      alignment: Alignment.bottomCenter,
                                      duration:
                                          const Duration(milliseconds: 1050),
                                      reverseDuration:
                                          const Duration(milliseconds: 534),
                                    ),
                                  );
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 133, 133, 133),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 84, 84, 84)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Transform.rotate(
                                      angle: 1.54,
                                      child: Icon(
                                          size: 25, Icons.arrow_back_ios_new),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = Colors.grey;

    canvas.drawLine(Offset(size.width * 0, size.height * 0),
        Offset(size.width * 7 / 20, size.height * 7 / 20), paint);

    final a = Offset(size.width * -1, size.height * 4 / 5);
    final b = Offset(size.width * 4 / 10, size.height * 1);

    final rect = Rect.fromPoints(a, b);

    canvas.drawRect(rect, paint);

    const radius = Radius.circular(20);

    final c = Offset(size.width * 1 / 2, size.height * 3 / 10);
    final d = Offset(size.width * 1.5, size.height * 3 / 5);

    final rrect = Rect.fromPoints(c, d);

    canvas.drawRRect(RRect.fromRectAndRadius(rrect, radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
