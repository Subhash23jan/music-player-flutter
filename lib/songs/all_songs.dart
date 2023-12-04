import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/Global_Variables.dart';
import 'package:music_player_demo/songs/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  var permission=false;

  @override
  void initState() {
    super.initState();
    getPermission();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor:Colors.black,
        toolbarHeight: kToolbarHeight+25,
        centerTitle: false,
        leadingWidth: 70,
        leading:  InkWell(
          onTap: (){},
            child: Center(child: Text("DESC",style: GoogleFonts.manrope(color: Colors.red,fontSize: 13.5,fontWeight: FontWeight.bold),))),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: kToolbarHeight+15,
            child: Row(
              children: [
                 Container(
                   height: 35,
                   width: 60,
                   margin: const EdgeInsets.only(right: 4),
                   alignment: Alignment.center,
                   padding:  const EdgeInsets.all(5),
                     decoration:  BoxDecoration(
                       color: Colors.redAccent,
                       borderRadius: BorderRadius.circular(12)
                     ),
                     child: Text("Sort By",style: GoogleFonts.manrope(color: Colors.white,fontSize: 11.5),)),
                Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Name",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Date Added",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Duration",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Size",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Title",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
              ],
            ),
          ),
        ),
      ),
      body:Center(
        child: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
            sortType:SongSortType.DATE_ADDED,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            // Display error, if any.
            if (item.hasError) {
              return Text(item.error.toString());
            }

            // Waiting content.
            if (item.data == null) {
              return const CircularProgressIndicator();
            }

            // 'Library' is empty.
            if (item.data!.isEmpty) return const Text("Nothing found!");

            // You can use [item.data!] direct or you can create a:
            // List<SongModel> songs = item.data!;
            return ListView.builder(
              itemCount: item.data!.length,
              shrinkWrap: true,
              physics:const ScrollPhysics(),
              itemBuilder: (context, index) {
                return songWidget(context, item.data![index],audioQuery);
              },
            );
          },
        ),
      ),
    );
  }
  getPermission() async {
    var result=await Permission.storage.request();
    if(result.isDenied){
      getPermission();
    }
    if(result.isGranted){
      permission=true;
      setState(() {});
    }else{
      getPermission();
    }
  }
}

