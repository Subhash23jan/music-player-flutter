class Tables{
static const  historyTableName='SONGS_HISTORY';
static const allSongsTableName='ALL_SONGS';
static const recentSongTableName="RECENT_SONGS";
static const favouriteSongTableName="FAVOURITE_SONGS";
static const userTableName="USERS";

 static  String  userTable=''' create table if not exists $userTableName(
          email text,
          password text
      );   ''';

static String recentListenedTable=''' CREATE TABLE IF NOT EXISTS $recentSongTableName (
     dataId INTEGER PRIMARY KEY AUTOINCREMENT,
    _id INTEGER,
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

static String favouriteSongsTable=''' CREATE TABLE IF NOT EXISTS $favouriteSongTableName (
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

static String playListsTable=''' CREATE TABLE IF NOT EXISTS Playlists (
    playListId INTEGER PRIMARY KEY,
    name TEXT
); ''';

static String customPlaylists=''' CREATE TABLE IF NOT EXISTS customPlaylist (
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
static String historyTable=''' CREATE TABLE IF NOT EXISTS $historyTableName (
     GENRE TEXT PRIMARY KEY,
     DURATION INTEGER,
     SONGS COUNT 
);
  ''';

static String allSongsTable = ''' 
  CREATE TABLE IF NOT EXISTS $allSongsTableName (
    dataId INTEGER PRIMARY KEY AUTOINCREMENT,
    _id INTEGER,
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
    is_alarm INTEGER CHECK (is_alarm IN (0, 1)),
    is_audiobook INTEGER CHECK (is_audiobook IN (0, 1)),
    is_music INTEGER CHECK (is_music IN (0, 1)),
    is_notification INTEGER CHECK (is_notification IN (0, 1)),
    is_podcast INTEGER CHECK (is_podcast IN (0, 1)),
    is_ringtone INTEGER CHECK (is_ringtone IN (0, 1))
  );
''';



}