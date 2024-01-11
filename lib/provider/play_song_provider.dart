import 'package:flutter/cupertino.dart';

class PlayControllerProvider extends ChangeNotifier{
     bool isPlaying=true;
     Duration songDuration=const Duration();
     Duration currentPosition=const Duration();

     bool get getState  => isPlaying;
     Duration get getSongDuration=>songDuration;
     Duration get getCurrentPosition=>currentPosition;
     void addDuration(Duration duration){
       print(duration);
       songDuration=duration;
       notifyListeners();
     }
     void addCurrentPosition(Duration duration){
       currentPosition=duration;
       notifyListeners();
     }
     void songState(){
       isPlaying=!isPlaying;
     }

}