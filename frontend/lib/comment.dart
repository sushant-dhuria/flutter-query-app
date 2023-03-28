class Comment {
  String id = "id";
  String email = "email";
  String comment = "comment";

  Comment(this.id, this.comment, this.email);
  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    email = json['email'];
  }
}
