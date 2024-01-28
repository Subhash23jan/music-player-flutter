import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/widgets/album%20widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/Global_Variables.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<AlbumModel>albumsList=[];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
      elevation: 15,
      shadowColor: Colors.white30,
      centerTitle: true,
      backgroundColor: Colors.black,
      title:Text("Song Albums ", style: GoogleFonts.manrope(
          color: Colors.white,
          fontSize: 18.5,
          fontWeight: FontWeight.w500),),
      toolbarHeight: kToolbarHeight,
    ),
      body:FutureBuilder<List<AlbumModel>>(
        builder: (context, item) {
          // Display error, if any.
          if (item.hasError) {
            return Text(item.error.toString());
          }

          // Waiting content.
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,));
          }

          // 'Library' is empty.
          if (item.data!.isEmpty) return const Text("Nothing found!");

          // You can use [item.data!] direct or you can create a:
          // List<SongModel> songs = item.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
            return showAlbum(context, item.data![index]);
          },);
        },
        future:audioQuery.queryAlbums(
          ignoreCase:true,
          uriType: UriType.EXTERNAL,
        ),
      ),
    );
  }
}
