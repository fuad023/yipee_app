
class UserCredentials {
  final String uid;
  String profileName;
  final String userName;
  final String email;
  int friends;
  int posts;
  int likes;
  String bioText;
  String handle;

  UserCredentials({
    required this.uid,
    required this.profileName,
    required this.userName,
    required this.email,
    this.friends = 0,
    this.posts = 0,
    this.likes = 0,
    this.bioText = 'Hey there!',
    this.handle = ''
  });

  factory UserCredentials.fromFirestore(Map<String, dynamic> data) {
    return UserCredentials(
      uid: data['uid'] ?? 'Unavailable',
      profileName: data['name'] ?? "Unavailable", 
      userName: data['user_id'] ?? "Unavailable",
      email: data['email'] ?? "Unavailable",
      friends: data['friends'] ?? 0,
      posts: data['posts'] ?? 0,
      likes: data['likes'] ?? 0,
      bioText: data['bio'] ?? 'Hey there!',
      handle: data['handle'] ?? "Unavailable"
    );
  }

  void setProfileName(String newProfileName) {
    profileName = newProfileName;
  }

  void setFriends() {
    friends++;
  }

  void removeFriends() {
    if(friends > 0) {
      friends--;
    }
  }

  void setPosts() {
    posts++;
  }

  void setLikes() {
    likes++;
  }

  void setBioText(String newBio) {
    bioText = newBio;
  }
}