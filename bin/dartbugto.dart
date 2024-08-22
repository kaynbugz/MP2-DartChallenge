import 'dart:math';

// Class representing a Song
class Song {
  String title;
  String artist;
  int duration; // Duration in seconds

  // Constructor to initialize the song
  Song(this.title, this.artist, this.duration);

  // Method to get the song's details as a string
  String getDetails() {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '$title by $artist (${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})';
  }
}

// Class representing a Playlist
class Playlist {
  String name;
  List<Song> songs;

  // Constructor to initialize the playlist with a name
  Playlist(this.name) : songs = [];

  // Method to add a song to the playlist
  void addSong(Song song) {
    songs.add(song);
  }

  // Method to get the playlist's details as a string
  String getDetails() {
    String details = 'Playlist: $name\n';
    for (var song in songs) {
      details += '${song.getDetails()}\n';
    }
    return details;
  }

  // Method to get the total duration of the playlist
  int getTotalDuration() {
    return songs.fold(0, (sum, song) => sum + song.duration);
  }

  // Method to sort songs by artist
  void sortByArtist() {
    songs.sort((a, b) => a.artist.compareTo(b.artist));
  }
}

// Class representing a Music Festival
class MusicFestival {
  String name;
  List<Playlist> playlists;

  // Constructor to initialize the festival with a name
  MusicFestival(this.name) : playlists = [];

  // Method to add a playlist to the festival
  void addPlaylist(Playlist playlist) {
    playlists.add(playlist);
  }

  // Method to get the festival's details as a string
  String getDetails() {
    String details = 'Total Festival Duration: ${getTotalDuration()} seconds\n\n';
    return details;
  }

  // Method to get the total duration of the festival
  int getTotalDuration() {
    return playlists.fold(0, (sum, playlist) => sum + playlist.getTotalDuration());
  }

  // Method to get random songs from different stages
  String getRandomSongs() {
    var random = Random();
    String details = 'Random Songs:\n';

    for (var playlist in playlists) {
      if (playlist.songs.isNotEmpty) {
        var randomSong = playlist.songs[random.nextInt(playlist.songs.length)];
        details += '${playlist.name} Stage: ${randomSong.getDetails()}\n';
      }
    }

    return details;
  }

  // Method to get the main stage playlist sorted by artist
  String getMainStageSortedByArtist() {
    var mainStagePlaylist = playlists.firstWhere((playlist) => playlist.name == 'Main Stage', orElse: () => Playlist('Main Stage'));

    mainStagePlaylist.sortByArtist();

    return 'Main Stage playlist sorted by artist:\n${mainStagePlaylist.getDetails()}';
  }
}

void main() {
  // Create some Radiohead songs
  var song1 = Song('Creep', 'Radiohead', 219); 
  var song2 = Song('Karma Police', 'Radiohead', 258); 
  var song3 = Song('No Surprises', 'Radiohead', 210); 
  var song4 = Song('Paranoid Android', 'Radiohead', 391); 
  var song5 = Song('High and Dry', 'Radiohead', 238); 
  var song6 = Song('Fake Plastic Trees', 'Radiohead', 291); 
  var song7 = Song('Street Spirit', 'Radiohead', 267); 

  // Create playlists
  var mainStage = Playlist('Main Stage');
  mainStage.addSong(song1);
  mainStage.addSong(song4);
  mainStage.addSong(song5);
  mainStage.addSong(song6);
  mainStage.addSong(song7);

  var indieStage = Playlist('Indie Stage');
  indieStage.addSong(song2);
  indieStage.addSong(song3);

  var electronicStage = Playlist('Electronic Stage');
  electronicStage.addSong(song7);

  // Create a music festival and add playlists
  var festival = MusicFestival('Radiohead Music Festival');
  festival.addPlaylist(mainStage);
  festival.addPlaylist(indieStage);
  festival.addPlaylist(electronicStage);

  // Print details about the festival
  print(festival.getDetails());
  print(festival.getRandomSongs());
  print(festival.getMainStageSortedByArtist());
}
