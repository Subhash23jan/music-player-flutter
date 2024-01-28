import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_demo/Animations/beat_animation.dart';
import 'package:music_player_demo/Services/notification_services.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/models/favourites_model.dart';
import 'package:music_player_demo/models/recent_listens.dart';
import 'package:music_player_demo/provider/songs_provider.dart';
import 'package:music_player_demo/songs/others_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:uri_to_file/uri_to_file.dart';

import '../constants/Global_Variables.dart';
import '../constants/songs_manager.dart';
import '../provider/play_song_provider.dart';

class PlaySong extends StatefulWidget {
  const PlaySong({super.key, required this.audioQuery, required this.songList, required this.index});
  final List<SongModel> songList;
  final int index;
  final OnAudioQuery audioQuery;

  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  // final  _audioPlayer = AudioPlayer();
  LocalNotificationService localNotificationService=LocalNotificationService();
 // final _audioPlayer=audio.AudioPlayer()..setReleaseMode(audio.ReleaseMode.loop);
  final DataBaseHelper _dataBaseHelper=DataBaseHelper();
  double sliderValue = 0.0;
  double position=0;
  bool isPlaying = true;
  bool isInLikedList=false;
  Duration currentPosition=const Duration();
  Duration songDuration=const Duration();
  SongModel? song;
  final List<String> lyrics = [
    "please wait ",
    "Our team is working ",
    "for this feature",
    "Thanks - Team Shashank",
  ];
  bool isLyricsOpened = false;

  @override
  void initState() {
    super.initState();
   // objectInitialize();
    Future.delayed(Duration.zero, () => playSongFromUri(context));
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //   _songsProvider = Provider.of<SongsProvider>(context, listen: false);
  }
  @override
  void dispose() {
    // Dispose audio player instance
    super.dispose();
  }

  objectInitialize()async{
    if(SongsManager.audioPlayer==null){
      SongsManager.audioPlayer=audio.AudioPlayer()..setReleaseMode(audio.ReleaseMode.loop);
    }else{
      await SongsManager.audioPlayer!.stop();
      SongsManager.audioPlayer=audio.AudioPlayer()..setReleaseMode(audio.ReleaseMode.loop);
    }
  }
  isItInLikedList() async {
    print("subhash d abs");
    bool ans=await DataBaseHelper().isPresentInFavourites(song?.id??0);
    print("subhash d $ans");
    if(ans){
      isInLikedList=true;
      setState(() {});
    }
  }
  Future<void> playSongFromUri(BuildContext context)  async {

     song = Provider.of<SongsProvider>(context, listen: false).currentSong;
    _dataBaseHelper.addToRecent(RecentSong(song!.getMap));
    if(SongsManager.audioPlayer!=null) {
      SongsManager.audioPlayer!.dispose();
    }
     SongsManager.audioPlayer=audio.AudioPlayer()..setReleaseMode(audio.ReleaseMode.loop);
    File file=await toFile(song!.uri??"");

     isItInLikedList();
    await SongsManager.audioPlayer!.play(audio.BytesSource(await file.readAsBytes()));
    localNotificationService.showNotificationAndroid(song!.title,song?.artist??song!.composer??song!.displayNameWOExt);
     addListeners();
     SongsManager.audioPlayer!.onPositionChanged.listen((duration) {
      Provider.of<PlayControllerProvider>(context, listen: false).addCurrentPosition(duration);
    });
     SongsManager.audioPlayer!.onDurationChanged.listen((duration) {
        Provider.of<PlayControllerProvider>(context, listen: false).addDuration(duration);
    });
  }
  void addListeners()async{
    SongsManager.audioPlayer!.getDuration().then((value){
       Provider.of<PlayControllerProvider>(context, listen: false).addDuration(value!);
    });
    SongsManager.audioPlayer!.getCurrentPosition().then((value){
      Provider.of<PlayControllerProvider>(context, listen: false).addCurrentPosition(value!);
    });
  }
  double durationToDouble(Duration duration) {
    return duration.inSeconds.toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, child) {
        return Scaffold(
          backgroundColor: GlobalVariables.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: kToolbarHeight+10,
            elevation: 38,
            shadowColor: Colors.black12,
            leading: IconButton(onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white70)),
            centerTitle: true,
            title: Column(
              children: [
                Text("Now Playing", style: GoogleFonts.manrope(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                const SizedBox(height: 4,),
                Text(widget.songList[widget.index].title,
                  style: const TextStyle(color: Colors.white24,
                      fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,)
              ],
            ),
            actions: const [
              Icon(Icons.more_vert_outlined,color: Colors.white,),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                // isPlaying?const Align(
                //   alignment: Alignment.center,
                //     child: BeatButton()):const SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.45,
                      child: Center(
                        child: CircleAvatar(
                          radius: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: QueryArtworkWidget(
                              controller: widget.audioQuery,
                              artworkHeight: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.4,
                              artworkWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
                              artworkFit: BoxFit.cover,
                              id: song?.id??Provider.of<SongsProvider>(context, listen: false).currentSong.id,
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(top: 1),
                      alignment: Alignment.center,
                      child: ListTile(
                          subtitle: Text(widget.songList[widget.index].artist ??
                              widget.songList[widget.index].composer ?? "unknown",
                            style: GoogleFonts.manrope(color: Colors.white24,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                          title: Text(widget.songList[widget.index].title,
                            style: GoogleFonts.openSans(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                          trailing: GestureDetector(
                            onTap: () async {
                              DataBaseHelper dbhelper=DataBaseHelper();
                              if(isInLikedList) {
                                dbhelper.removeFromFavourites(song?.id??0);
                                isInLikedList=false;
                                setState(() {});
                              }else{
                                dbhelper.addFavourites(Favourites(widget.songList[widget.index].getMap));
                                isInLikedList=true;
                                setState(() {});
                              }
                            },
                            child:  Icon(
                              Icons.favorite_outlined, color:isInLikedList?Colors.red:Colors.white, size: 30,),
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5,),
                        Text(formatDuration(Provider.of<PlayControllerProvider>(context, listen: true).currentPosition),
                          style: GoogleFonts.manrope(color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width-80,
                          child: Slider(
                            value: durationToDouble(Provider.of<PlayControllerProvider>(context, listen: true).currentPosition),
                            thumbColor: Colors.black,
                            activeColor: Colors.white30,
                            autofocus: true,
                            allowedInteraction: SliderInteraction.tapAndSlide,
                            label: getSongPosition(Provider.of<PlayControllerProvider>(context, listen: true).currentPosition.inSeconds),
                            onChanged: (value) {
                              Provider.of<PlayControllerProvider>(context, listen: false).addCurrentPosition(doubleToDuration(value));
                            },
                            onChangeEnd: (value) {
                              Provider.of<PlayControllerProvider>(context, listen: false).addCurrentPosition(doubleToDuration(value));
                              SongsManager.audioPlayer!.seek(doubleToDuration(value));
                            },
                            min: 0.0,
                            max:durationToDouble(Provider.of<PlayControllerProvider>(context, listen: true).songDuration),
                          ),
                        ),
                        Text(formatDuration(Provider.of<PlayControllerProvider>(context, listen: true).songDuration),
                          style: GoogleFonts.manrope(color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,),
                        const SizedBox(width: 1,),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: () {},
                            icon: const Icon(Icons.shuffle,
                              color: CupertinoColors.white, size: 30,)),
                        IconButton(onPressed: () {
                          if (widget.index > 0) {
                            songsProvider.updateCurrentSong(
                                widget.songList[widget.index - 1]);
                            SongsManager.audioPlayer!.dispose();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) =>
                                    PlaySong(audioQuery: widget.audioQuery,
                                        songList: widget.songList,
                                        index: widget.index - 1),));
                          }
                        },
                            icon: const Icon(CupertinoIcons.backward_end,
                              color: CupertinoColors.white, size: 30,)),
                        isPlaying ? IconButton(onPressed: () {
                          isPlaying = !isPlaying;
                          setState(() {});
                          SongsManager.audioPlayer!.pause();
                        },
                          icon: const Icon(
                            CupertinoIcons.pause, color: CupertinoColors.systemCyan,
                            size: 35,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,
                              ),
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,

                              ),
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,

                              ),
                            ],),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(25),
                            // Set the elevation as needed
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.cyan.shade200),
                            // Set the button color
                          ),) :
                        IconButton(onPressed: () {
                          isPlaying = !isPlaying;
                          setState(() {});
                          SongsManager.audioPlayer!.resume();
                        },
                          icon: const Icon(
                            CupertinoIcons.play, color: CupertinoColors.systemCyan,
                            size: 35,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,
                              ),
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,

                              ),
                              Shadow(
                                color: Colors.white,
                                blurRadius: 6,

                              ),
                            ],),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(25),
                            // Set the elevation as needed
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.cyan.shade200),
                            // Set the button color
                          ),),
                        IconButton(onPressed: () {
                          if(widget.index<widget.songList.length-1){
                            print(
                                "Before updateCurrentSong: ${songsProvider.currentSong.displayName}");
                            songsProvider.updateCurrentSong(
                                widget.songList[widget.index + 1]);
                            print(
                                "After updateCurrentSong: ${songsProvider.currentSong.displayName}");
                            SongsManager.audioPlayer!.dispose();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlaySong(audioQuery: widget.audioQuery, songList: widget.songList, index: widget.index+1),));
                            // songsProvider.updateCurrentSong(widget.songList[widget.index+1]);
                            print("clicked");
                          }
                        },
                            icon: const Icon(CupertinoIcons.forward_end,
                              color: CupertinoColors.white, size: 30,)),
                        IconButton(onPressed: () {},
                            icon: const Icon(Icons.repeat,
                              color: CupertinoColors.white, size: 30,)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text("Lyrics", style: GoogleFonts.manrope(
                                color: Colors.white24,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                            IconButton(onPressed: () {
                              setState(() {
                                isLyricsOpened = !isLyricsOpened;
                              });
                            },
                                icon: Icon(isLyricsOpened
                                    ? CupertinoIcons.chevron_compact_down
                                    : CupertinoIcons.chevron_compact_up,
                                  color: Colors.white,
                                  size: 40,)),
                          ],
                        )),
                    isLyricsOpened ? AnimatedContainer(
                        duration: const Duration(seconds: 4),
                        // Adjust the duration as needed
                        curve: Curves.easeInExpo,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 25,),
                        padding: const EdgeInsets.only(top: 15),
                        decoration: const BoxDecoration(
                            color: GlobalVariables.appBarColor,
                            border: null,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)
                            )
                        ),
                        constraints: const BoxConstraints(
                            minHeight: 400,
                            maxHeight: 500
                        ),
                        child: ListView.builder(
                          itemCount: lyrics.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) =>
                              Center(child: index % 2 == 0 ? ShaderMask(
                                  shaderCallback: (bounds) {
                                    return GlobalVariables.getLineGradient()
                                        .createShader(bounds);
                                  },
                                  child: Text(
                                    lyrics[index],
                                    style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: 17.5,
                                        fontWeight: FontWeight
                                            .w500),
                                  )) : Text(lyrics[index],
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16))),)
                    ) : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Duration doubleToDuration(double seconds) {
    return Duration(seconds: seconds.toInt());
  }
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;

    return '$minutes:${twoDigits(seconds)}';
  }
  String getSongPosition(int seconds)
  {
    int cnt=0;
    while(seconds/10>1){
      cnt++;
      seconds=seconds~/10;
    }
    return "$cnt.${seconds%10}";
  }
}
