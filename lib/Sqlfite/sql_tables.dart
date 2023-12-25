class Tables{
  String userTable=''' create table if not exists user(
          email text,
          password text,
      )   ''';

  String recentListenedTable=''' CREATE TABLE IF NOT EXISTS recentListened (
    _id INTEGER PRIMARY KEY,
    _data TEXT,
    _uri TEXT,
    _display_name TEXT,
    _display_name_wo_ext TEXT,
    _size INTEGER,
    album TEXT,
    album_id INTEGER,
    artist TEXT,
    artist_id INTEGER,
    genre TEXT,
    genre_id INTEGER,
    bookmark INTEGER,
    composer TEXT,
    date_added INTEGER,
    date_modified INTEGER,
    duration INTEGER,
    title TEXT,
    track INTEGER,
    file_extension TEXT,
    is_alarm INTEGER,
    is_audiobook INTEGER,
    is_music INTEGER,
    is_notification INTEGER,
    is_podcast INTEGER,
    is_ringtone INTEGER
);
  ''';

  String favouriteSongsTable=''' CREATE TABLE IF NOT EXISTS favouriteSongs (
    _id INTEGER PRIMARY KEY,
    _data TEXT,
    _uri TEXT,
    _display_name TEXT,
    _display_name_wo_ext TEXT,
    _size INTEGER,
    album TEXT,
    album_id INTEGER,
    artist TEXT,
    artist_id INTEGER,
    genre TEXT,
    genre_id INTEGER,
    bookmark INTEGER,
    composer TEXT,
    date_added INTEGER,
    date_modified INTEGER,
    duration INTEGER,
    title TEXT,
    track INTEGER,
    file_extension TEXT,
    is_alarm bool,
    is_audiobook bool,
    is_music bool,
    is_notification bool,
    is_podcast bool,
    is_ringtone bool
);
  ''';

  String playListsTable=''' CREATE TABLE IF NOT EXISTS Playlists (
    playListId INTEGER PRIMARY KEY,
    name TEXT
); ''';

  String customPlaylists=''' CREATE TABLE IF NOT EXISTS customPlaylist (
     playListId INTEGER ,
    _id INTEGER ,
    _data TEXT,
    _uri TEXT,
    _display_name TEXT,
    _display_name_wo_ext TEXT,
    _size INTEGER,
    album TEXT,
    album_id INTEGER,
    artist TEXT,
    artist_id INTEGER,
    genre TEXT,
    genre_id INTEGER,
    bookmark INTEGER,
    composer TEXT,
    date_added INTEGER,
    date_modified INTEGER,
    duration INTEGER,
    title TEXT,
    track INTEGER,
    file_extension TEXT,
    is_alarm INTEGER,
    is_audiobook INTEGER,
    is_music INTEGER,
    is_notification INTEGER,
    is_podcast INTEGER,
    is_ringtone INTEGER
);
  ''';

}