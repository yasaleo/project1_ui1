import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

class AddPlaylist extends StatefulWidget {
  const AddPlaylist({Key? key}) : super(key: key);

  @override
  State<AddPlaylist> createState() => _AddPlaylistState();
}

class _AddPlaylistState extends State<AddPlaylist> {
  final nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OnAudioQuery audioQuery = OnAudioQuery();
  final List<int> ids = [];
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 15, left: 15, bottom: 10),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor:
                            const Color.fromARGB(166, 176, 176, 176),
                        fixedSize: const Size(95, 20)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addsong();
                        PlaylistDB.instance.getallfolder();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              ),
            ],
            stretch: true,
            elevation: 2,
            backgroundColor: Colors.grey,
            expandedHeight: 280,
            collapsedHeight: 60,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.expand_more_outlined,
                color: Colors.black,
                size: 46,
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
                          colors: [Colors.transparent, Colors.grey])
                      .createShader(rect),
                  child: GestureDetector(
                    onTap: () => pickimage(),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.add_photo_alternate,
                            size: 160,
                          ),
                  )),
              title: Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 140,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Give your Playlist a name';
                          } else {
                            return null;
                          }
                        },
                        style: GoogleFonts.capriola(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabled: true,
                          hintText: ' playlist name',
                        ),
                      ),
                    ),
                  )),
              titlePadding: const EdgeInsets.only(left: 95, right: 16),
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
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
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
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget:
                                    const Icon(Icons.music_note_outlined),
                              ),
                            ),
                            title: Text(
                              item.data![index].displayNameWOExt,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              item.data![index].artist.toString() == "<unknown>"
                                  ? 'Unknown Artist'
                                  : item.data![index].artist.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                            trailing: SizedBox(
                              height: 48,
                              width: 38,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (!ids.contains(item.data![index].id)) {
                                      ids.add(item.data![index].id);
                                    } else {
                                      ids.remove(item.data![index].id);
                                    }
                                  });
                                },
                                icon: Icon(
                                  ids.contains(item.data![index].id)
                                      ? Icons.remove_circle_outline_outlined
                                      : Icons.playlist_add_circle_outlined,
                                  size: 33,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  addsong()  {
    final model = FolderModel(name: nameController.text, songids: ids);

    PlaylistDB.instance.addfolder(model);
    nameController.clear();
    ids.clear();
  }

  Future pickimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final tempimage = File(image.path);
    setState(() {
      this.image = tempimage;
    });
  }
}
