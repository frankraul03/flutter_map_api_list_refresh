import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_listview_json/entities/dealer_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_listview_json/entities/map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dealers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

// final TextEditingController _textController = new TextEditingController();

  List<DealerInfo> _dealerInfoFullList = List<DealerInfo>();
  List<DealerInfo> _dealerInfoTempForDisplay = List<DealerInfo>();

  Future<List<DealerInfo>> fetchNotes() async {
    var url = 'https://www.tesla.com.np/api/app/get_dealers.php';
    var response = await http.get(url);

    var notes = List<DealerInfo>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(DealerInfo.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _dealerInfoFullList.addAll(value);
        _dealerInfoTempForDisplay = _dealerInfoFullList;
      });
    });
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    //Clear the list initially on request
    _dealerInfoFullList.clear();

    fetchNotes().then((value) {
      setState(() {
        _dealerInfoFullList.addAll(value);
        _dealerInfoTempForDisplay = _dealerInfoFullList;
      });
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealers List'),
      ),
      body: RefreshIndicator(
          onRefresh: refreshList,
          key: refreshKey,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return index == 0 ? _searchBar() : _listItem(index - 1);
            },
            itemCount: _dealerInfoTempForDisplay.length + 1,
          )),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        // controller: _textController,
        decoration: InputDecoration(
            labelText: "Search Dealers",
            hintText: "Search Dealers",
            prefixIcon: Icon(Icons.search),
            // suffixIcon: IconButton(onPressed:(){
            //   // _textController.clear();
            // },icon:Icon(Icons.close)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _dealerInfoTempForDisplay = _dealerInfoFullList.where((note) {
              var noteTitle = note.location.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new MapApp()));
      },
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 18.0, bottom: 18.0, left: 9.0, right: 9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _dealerInfoTempForDisplay[index].location,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent),
                  ),
                  _dealerInfoTempForDisplay[index].dealerName != ""
                      ? SizedBox(
                          height: 10.0,
                        )
                      : new Container(width: 0, height: 0),
                  _dealerInfoTempForDisplay[index].dealerName != ""
                      ? Text(
                          _dealerInfoTempForDisplay[index].dealerName,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey.shade600),
                        )
                      : new Container(width: 0, height: 0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _dealerInfoTempForDisplay[index].dealerContact != ""
                        ? Icon(
                            Icons.phone,
                            size: 20.0,
                            color: Colors.lightBlue,
                          )
                        : new Container(width: 0, height: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _dealerInfoTempForDisplay[index].dealerContact != ""
                        ? Text(
                            _dealerInfoTempForDisplay[index].dealerContact,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey.shade600),
                          )
                        : new Container(width: 0, height: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.lightBlue),
                        child: Icon(Icons.location_on,
                            size: 20.0, color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
