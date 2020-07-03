import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeStatePerson createState() => _HomeStatePerson();
}

class _HomeStatePerson extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("List")
      ),
      body: Place(),
      );
  }
}


class Place extends StatefulWidget {
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  Future getPosts()async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("pls").getDocuments();
    print("=========");
    print(qn);
    print('==========');
    return qn.documents;

  }
  
navToDeet(DocumentSnapshot data){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPageppl(dat:data)));
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Center(child:Column(
            
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children:<Widget>[
            CircularProgressIndicator()]));
        }
        else{
         
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_,index){

              final item = snapshot.data[index];
              
              return Card(child:ListTile(
                title: Text(snapshot.data[index].data["public"],
                //subtitle:Text(snapshot.data[index].data["streetName"])
                //"Value"
                ),
                onTap: (){
                  navToDeet(snapshot.data[index]);
                },));
            });
        }

      }),
    );
       
   
}
}


class DetailPageppl extends StatefulWidget {

  final DocumentSnapshot dat;
  DetailPageppl({this.dat});
  
  @override
  _DetailPagepplState createState() => _DetailPagepplState();
}

class _DetailPagepplState extends State<DetailPageppl> {


//var a = dat.data['person']==null?"none":"some";

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Pers")),
      body:Container(
        padding: EdgeInsets.all(20),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
// Text("Met",textAlign: TextAlign.center,style :TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
//        Text(widget.dat.data['Person'],textAlign: TextAlign.center,),
//        SizedBox(height: 10,),



       Text("Date",textAlign: TextAlign.center,style :TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
       Text(widget.dat.data['now'],textAlign: TextAlign.center,),
       SizedBox(height: 10,),
        Text("Place Name",textAlign: TextAlign.center,style :TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
       Text(widget.dat.data['public'],textAlign: TextAlign.center,),

       
       ]
      ),
      
    ));
  }
}



