class Singlequery {
  String name = "name";
  String q = "query";
  String category = "category";
  String id = "id";
  Singlequery(this.name, this.q, this.category, this.id);
  Singlequery.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    q = json['query'];
    category = json['category'];
    id = json['_id'];
  }
}
