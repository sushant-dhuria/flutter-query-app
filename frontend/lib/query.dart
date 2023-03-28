class Query {
  String email = "email";
  String q = "query";
  String category = "category";
  Query(this.email, this.q, this.category);
  Query.fromJson(Map<String, dynamic> json) {
    email = json['name'];
    q = json['query'];
    category = json['category'];
  }
}
