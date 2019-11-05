import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wizard2/gamepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wizard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: AppBar(leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: null)),*/
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(

                  height: 70.0,
                  width: 70.0,
                  decoration: new BoxDecoration(
                      borderRadius:  new BorderRadius.circular(10.0),
                      color: Colors.grey
                  ),


                ),
                new Container(

                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius:  new BorderRadius.circular(10.0),
                      color: Colors.green
                  ),
                  child: new Icon(Icons.gamepad,color: Colors.white,),

                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Wizard",style: new TextStyle(fontSize: 30.0),),

                )
              ],),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Gamepage()),
                      );},

                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("New Game",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Gamepage()),
                      );},

                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Continue",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(

                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Settings",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(onTap: ()=>exit(0),

                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Quit",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}



