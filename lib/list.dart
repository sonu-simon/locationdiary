import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoloc/login.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("$name - $phone").getDocuments();
    print("=========");
    print(qn);
    print('==========');
    return qn.documents;
  }

  navToDeet(DocumentSnapshot data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(dat: data)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[CircularProgressIndicator()]));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data[index];

                    return Card(
                        child: ListTile(
                          trailing: IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: () {
                            String mapsURL =
                                snapshot.data[index].data["locURL"];
                            launch(mapsURL);
                          }),
                      subtitle: Text(snapshot.data[index].data["now"]),
                      title: Text(
                        snapshot.data[index].data["streetName"],
                        //subtitle: Text('Here is a second line'),
                        //"Value"
                      ),
                      onTap: () {
                        navToDeet(snapshot.data[index]);
                      },
                    ));
                  });
            }
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot dat;
  DetailPage({this.dat});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
//var a = dat.data['person']==null?"none":"some";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Date")),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.dat.data['now'],
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Street Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.dat.data['streetName'],
                  textAlign: TextAlign.center,
                ),
              ]),
        ));
  }
}