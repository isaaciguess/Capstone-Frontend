import 'package:flutter/material.dart';  
  
void main() {  
  runApp(MaterialApp( home: MyApp(),));  
}  
  
class MyApp extends StatefulWidget {  
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<MyApp> {  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
        appBar: AppBar(  
          title: Text('TextField FirstApp'),  
        ),  
        body: Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Your User Name',  
                      hintText: 'Enter Your Name',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Your Password',  
                      hintText: 'Enter Password',  
                    ),  
                  ),  
                ),  
                RaisedButton(  
                  textColor: Colors.white,  
                  color: Colors.black,  
                  child: Text('Sign In'),  
                  onPressed: (){},  
                )  
              ],  
            )  
        )  
    );  
  }  
}  