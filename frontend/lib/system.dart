// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/individual.dart';
import 'package:frontend/writepost.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/singlequery.dart';
import 'package:frontend/query.dart';

class System extends StatefulWidget {
  final String email;
  System(this.email);

  @override
  _SystemState createState() => _SystemState();
}

List<Singlequery> _queriesSystem = [];
List<Singlequery> temp = [];

class _SystemState extends State<System> {
  @override
  _SystemState createState() => _SystemState();

  Future<List<Singlequery>> fetchjson() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var res = await http.get("http://localhost:8080/queriessystem");
    // print(res.body);
    List<Singlequery> queriesSystem = [];
    if (res.statusCode == 200) {
      var queriesjson = json.decode(res.body);
      for (var Singlequeryjson in queriesjson) {
        queriesSystem.add(Singlequery.fromJson(Singlequeryjson));
      }
    }
    return queriesSystem;
  }

  void initState() {
    fetchjson().then((value) {
      setState(() {
        _queriesSystem.addAll(value);
        temp.addAll(_queriesSystem);
      });
    });
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Singlequery> results = [];
    _queriesSystem = [];
    if (enteredKeyword.isEmpty) {
      results = temp;
    } else {
      results = temp
          .where((element) => element.q
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _queriesSystem = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FloatingActionButton.extended(
          heroTag: "btn1",
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => Writepost()));
          },
          icon: const Icon(Icons.edit),
          label: const Text('Write Query'),
        ),
      ]),
      appBar: AppBar(
        title: Text("System Design Queries"),
        titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   child: SingleChildScrollView(
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  String qu;
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: ListTile(
                        onTap: () => {
                          qu = _queriesSystem[index].id.toString(),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Individual(
                                      query: qu, email: widget.email))))
                        },
                        leading: Icon(Icons.ads_click),
                        title: Text(_queriesSystem[index].q.toString()),
                        trailing: Icon(Icons.comment),
                        tileColor: Colors.blue,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  );
                },
                itemCount: _queriesSystem.length,
              ),
            ),
          ])),
    );
    //   ),
    // );
  }
  // );
}
// }
