import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Gamepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    LeftPart(),
                    MidPart(),
                    RightPart(),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    BottomPart(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class LeftPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: 100.0,
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Text("Left"),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
        ],
      ),
    );
  }
}

class RightPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: 100.0,
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Text("Right"),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
          CreateCardImageBack(Offset(100.0, 100.0)),
        ],
      ),
    );
  }
}

class MidPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        height: 500.0,
        width: 211.4,
      ),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Text("Mid"),
          DragTarget(
            builder: (context, List<AssetImage> candidateData, rejectedData) {
              print(candidateData);
              return Center(
                  child: Text(
                    "Trump",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ));
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {},
          ),
        ],
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 159.0,

      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CreateCardImage(Offset(100.0, 100.0)),
              CreateCardImage(Offset(100.0, 100.0)),
              CreateCardImage(Offset(100.0, 100.0)),
              CreateCardImage(Offset(100.0, 100.0)),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("Player 1"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Take bet"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CreateCardImage extends StatefulWidget {
  final Offset offset;

  //CreateCardImage({Key key, this.offset}) : super(key: key);

  @override
  _CreateCardImageState createState() => _CreateCardImageState();

  CreateCardImage(this.offset);
}

class _CreateCardImageState extends State<CreateCardImage> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/3C.png",
            height: 80.0,
            width: 50.0,
          )),
      feedback: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/3C.png",
            height: 80.0,
            width: 50.0,
          )),
      childWhenDragging: Container(),
      onDraggableCanceled: (v, o) {
        setState(() {
          offset = o;
        });
      },
    );
  }
}

class CreateCardImageBack extends StatefulWidget {
  final Offset offset;

  @override
  _CreateCardImageBackState createState() => _CreateCardImageBackState();

  CreateCardImageBack(this.offset);
}

class _CreateCardImageBackState extends State<CreateCardImageBack> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: RotatedBox(
            quarterTurns: 5,
            child: Image.asset(
              "images/cards/blue_back.png",
              height: 80.0,
              width: 50.0,
            ),
          )),
      feedback: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: RotatedBox(
            quarterTurns: 5,
            child: Image.asset(
              "images/cards/blue_back.png",
              height: 80.0,
              width: 50.0,
            ),
          )),
      childWhenDragging: Container(),
      onDraggableCanceled: (v, o) {
        setState(() {
          offset = o;
        });
      },
    );
  }
}
