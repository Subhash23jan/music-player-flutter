import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:music_player_demo/provider/songs_provider.dart';
import 'package:music_player_demo/songs/song_widget.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  var permission=false;
  int sortingIndex=0;
  bool makeAsc=true;
  bool sorting=false;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    getPermission();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0B0642FF),
      appBar: AppBar(
        backgroundColor:Colors.black,
        toolbarHeight: kToolbarHeight+25,
        centerTitle: false,
        leadingWidth: 145,
        elevation: 2,
        shadowColor: Colors.cyanAccent,
        scrolledUnderElevation: 15,
        leading:  Container(
          alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      makeAsc=!makeAsc;
                    });
                  },
                  child: Row(
                  children: [
                  Text(makeAsc?"ASC":"DESC",style: GoogleFonts.manrope(color: Colors.red,fontSize: 15.5,fontWeight: FontWeight.bold),),
                  Icon(makeAsc?Icons.arrow_upward:CupertinoIcons.down_arrow,color: Colors.white,size: 18,),
          ],
        ),
                ),
                Container(
                    height: 35,
                    width: 60,
                    margin: const EdgeInsets.only(left: 12),
                    alignment: Alignment.center,
                    padding:  const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Sort By",style: GoogleFonts.manrope(color: Colors.white,fontSize: 11.5),)),
              ],
            )),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: kToolbarHeight+15,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setSortType(1),
                  child: Container(
                      height: 35,
                      width: 100,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      padding:  const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: sortingIndex==1?Colors.yellow.shade900:Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("Name",style: GoogleFonts.aBeeZee(color: sortingIndex==1?Colors.white:Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                ),
                GestureDetector(
                  onTap: () => setSortType(2),
                  child: Container(
                      height: 35,
                      width: 100,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      padding:  const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: sortingIndex==2?Colors.yellow.shade900:Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("Date Added",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                ),
                GestureDetector(
                  onTap: () => setSortType(3),
                  child: Container(
                      height: 35,
                      width: 100,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      padding:  const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: sortingIndex==3?Colors.yellow.shade900:Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("Duration",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                ),
                GestureDetector(
                  onTap: () => setSortType(5),
                  child: Container(
                      height: 35,
                      width: 100,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      padding:  const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: sortingIndex==5?Colors.yellow.shade900:Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("Title",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                ),
                GestureDetector(
                  onTap: () => setSortType(4),
                  child: Container(
                      height: 35,
                      width: 100,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      padding:  const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: sortingIndex==4?Colors.yellow.shade900:Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("Size",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600),)),
                ),
              ],
            ),
          ),
        ),
      ),
      body:sorting?const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)):Center(
        child: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
            sortType:makeSort(),
            orderType: getOrder(),
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
              return const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,));
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
                return songWidget(context, item.data!,index,audioQuery);
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
  SongSortType makeSort(){
    switch(sortingIndex){
      case 0: return SongSortType.DATE_ADDED;
      case 1: return SongSortType.DISPLAY_NAME;
      case 2: return SongSortType.DATE_ADDED;
      case 3: return SongSortType.DURATION;
      case 4: return SongSortType.SIZE;
      case 5:return  SongSortType.TITLE;
      default: return SongSortType.DATE_ADDED;
    }
  }
  OrderType getOrder(){
    return makeAsc==true?OrderType.ASC_OR_SMALLER:OrderType.DESC_OR_GREATER;
  }

  setSortType(int index) {
    setState(() {
      sorting=true;
      sortingIndex=index;
    });
    Future.delayed(const Duration(milliseconds: 1000),() {
      setState(() {
        sorting=false;
      });
    },);

  }

}

