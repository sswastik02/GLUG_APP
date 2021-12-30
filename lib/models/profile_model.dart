class Profile {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String alias;
  final String bio;
  final int yearName;
  final String position;
  final String email;
  final String image;
  final String degreeName;
  final String gitLink;
  final String facebookLink;
  final String redditLink;
  final String linkedinLink;

  Profile(
      this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.alias,
      this.bio,
      this.yearName,
      this.position,
      this.email,
      this.image,
      this.degreeName,
      this.gitLink,
      this.facebookLink,
      this.redditLink,
      this.linkedinLink);

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['user_name'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        alias = json['alias'],
        bio = json['bio'],
        yearName = json['year_name'],
        position = json['position'],
        email = json['email'],
        image = json['image'],
        degreeName = json['degree_name'],
        gitLink = json['git_link'],
        facebookLink = json['facebook_link'],
        redditLink = json['reddit_link'],
        linkedinLink = json['linkedin_link'];
}
