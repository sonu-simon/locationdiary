import 'package:flutter/material.dart';
import 'package:geoloc/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  dynamic value;
  String phone;
  String name;

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      final key = 'loginState';
      final nameKey = 'name';
      final phoneKey = 'phone';
      value = sharedPreferences.getInt(key) ?? 0;
      name = sharedPreferences.getString(nameKey);
      phone = sharedPreferences.getString(phoneKey);
      print(name);
      print(phone);
      print(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = value;
    if (user == 1) {
      return MyHomePage();
    } else {
      return LoginPage();
    }
  }
}

//Login Page, if not registered already
class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String name;
  String phone;

  _login() async {
    name = nameController.text;
    phone = phoneController.text;

    final prefs = await SharedPreferences.getInstance();
    final key = 'loginState';
    final value = 1;
    final nameKey = 'name';
    final phoneKey = 'phone';
    prefs.setInt(key, value);
    prefs.setString(nameKey, name);
    prefs.setString(phoneKey, phone);
    Navigator.push(context, MaterialPageRoute(builder: (context) => First()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Location Diary',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Login'),
                        onPressed: _login)),
              ],
            )));
  }
}
