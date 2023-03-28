import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/query.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Writepost());

class Writepost extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyGridScreen(),
    );
  }
}

class MyGridScreen extends StatefulWidget {
  MyGridScreen({Key key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var res = await http.post("http://localhost:8080/query",
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': query.email,
          'query': query.q,
          'category': query.category
        });
    print(res.body);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => Dashboard(query.email)));
  }

  Query query = Query('', '', 'Android Development');
  String selected = "Android Development";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post your Query"),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: query.email),
                        onChanged: (value) {
                          query.email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Container(
                      width: 350,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors
                                  .lightBlue, //background color of dropdown button
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 3), //border of dropdown button
                              borderRadius: BorderRadius.circular(
                                  16.0), //border raiuds of dropdown button
                              boxShadow: <BoxShadow>[
                                //apply shadow on Dropdown button
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.57), //shadow for button
                                    blurRadius: 5) //blur radius of shadow
                              ]),
                          child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: DropdownButton(
                                value: selected,

                                items: [
                                  //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Data-structure and Algorithm"),
                                    value: "Data-structure and Algorithm",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Machine Learning"),
                                    value: "Machine Learning",
                                  ),

                                  DropdownMenuItem(
                                    child: Text("Android Development"),
                                    value: "Android Development",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Web Development"),
                                    value: "Web Development",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("System Design"),
                                    value: "System Design",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Others"),
                                    value: "Others",
                                  ),
                                ],

                                onChanged: (value) {
                                  //get value when changed
                                  setState(() {
                                    //set state will update UI and State of your App
                                    selected = value
                                        .toString(); //change selectval to new value
                                  });
                                  query.category = value;
                                  print("You selected $value");
                                },
                                icon: Padding(
                                    //Icon at tail, arrow bottom is default icon
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.arrow_circle_down_sharp)),
                                iconEnabledColor: Colors.white, //Icon color
                                style: TextStyle(
                                    //te
                                    color: Colors.white, //Font color
                                    fontSize: 20 //font size on dropdown button
                                    ),

                                dropdownColor: Colors
                                    .lightBlue, //dropdown background color
                                underline: Container(), //remove underline
                                isExpanded: true, //make true to make width 100%
                              ))),
                    ),
                    Container(
                      height: 400,
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: TextEditingController(text: query.q),
                        onChanged: (value) {
                          query.q = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Write your query',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 300,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                save();
                              } else {
                                print("not ok");
                              }
                            },
                            child: Text(
                              "Publish",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
