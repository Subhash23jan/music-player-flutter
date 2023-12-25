import 'package:on_audio_query/on_audio_query.dart';

class Favourites extends SongModel{
  Favourites(super.info);
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "_data": data,
      "_uri": uri,
      "_display_name": displayName,
      "_display_name_wo_ext": displayNameWOExt,
      "_size": size,
      "album": album,
      "album_id": albumId,
      "artist": artist,
      "artist_id": artistId,
      "genre": genre,
      "genre_id":0,
      "bookmark": bookmark,
      "composer": composer,
      "date_added": dateAdded,
      "date_modified": dateModified,
      "duration": duration,
      "title": title,
      "track": track,
      "file_extension": fileExtension,
      "is_alarm": isAlarm,
      "is_audiobook": isAudioBook,
      "is_music": isMusic,
      "is_notification": isNotification,
      "is_podcast": isPodcast,
      "is_ringtone": isRingtone,
    };
  }

}