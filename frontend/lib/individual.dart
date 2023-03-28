import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/comment.dart';
import 'package:http/http.dart' as http;
import 'package:comment_box/comment/comment.dart';

class Individual extends StatefulWidget {
  String query, email;
  Individual({this.query, this.email});

  @override
  _IndividualState createState() => _IndividualState();
}

List<Comment> _queriesml = [];
List<Comment> temp = [];

var upvotes = 0;

class _IndividualState extends State<Individual> {
  Future<List<Comment>> fetchjson() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var qu = widget.query;
    var url = "http://localhost:8080/queries/$qu/comments";

    var res = await http.get(url);
    var obj = jsonDecode(res.body);

    List<Comment> queriesml = [];
    _queriesml = [];
    if (res.statusCode == 200) {
      var queriesjson = json.decode(res.body);

      for (var Commentjson in queriesjson) {
        queriesml.add(Comment.fromJson(Commentjson));
      }
    }

    _queriesml = queriesml;
  }

  Future upvote(email, index) async {
    print(email);
    print(index);
    print(_queriesml[index].comment);
  }

  Future Save() async {
    var qu = widget.query;
    var res = await http.post("http://localhost:8080/queries/$qu/comments",
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': widget.email,
          'queryid': widget.query,
          'comment': user.comment
        });
  }

  Comment user = Comment('', '', '');

  void initState() {
    fetchjson();
    super.initState();
  }

  final TextEditingController _commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild(data) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 194, 220, 241),
            ),
            child: ListTile(
                onTap: () => {},
                title: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.supervised_user_circle_rounded,
                        color: Colors.blue),
                    Text(data[index].email),
                  ],
                ),
                subtitle: Text(data[index].comment.toString()),
                textColor: Colors.black,
                iconColor: Colors.black,
                contentPadding: EdgeInsets.all(8),
                trailing: SizedBox.fromSize(
                  size: Size(56, 56), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {
                          upvote(widget.email, index);
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.thumb_up), // icon
                            Text("$upvotes"), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
      itemCount: data.length,
    );
  }

  // Widget commentChild(data) {
  //   print(data.length);
  //   return ListView(
  //     children: [
  //       for (var i = 0; i < data.length; i++)
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
  //           child: ListTile(
  //             leading: GestureDetector(
  //               onTap: () async {
  //                 // Display the image in large form.
  //                 print("Comment Clicked");
  //               },
  //               child: Container(
  //                 height: 50.0,
  //                 width: 50.0,
  //                 decoration: new BoxDecoration(
  //                     color: Colors.blue,
  //                     borderRadius: new BorderRadius.all(Radius.circular(50))),
  //               ),
  //             ),
  //             title: Text(
  //               data[i].email,
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //             subtitle: Text(data[i].comment),
  //           ),
  //         )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          child: commentChild(_queriesml),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState.validate()) {
              user.comment = commentController.text;
              user.id = widget.query;

              Save();
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
