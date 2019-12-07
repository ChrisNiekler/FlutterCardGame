import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard/0auth/models/score.dart';

class ScoreList extends StatefulWidget {

  @override
  _ScoreListState createState() => _ScoreListState();

}

class _ScoreListState extends State<ScoreList> {


  @override
  Widget build(BuildContext context) {

    final score = Provider.of<List<Score>>(context);

    return ListView.builder(
      itemCount: score.length,
      itemBuilder: (context, index) {
        return ScoreTile(scoreItem: score[index]);
      }
    );
  }
}

class ScoreTile extends StatelessWidget {
  final Score scoreItem;

  ScoreTile({this.scoreItem});

  @override
  Widget build(BuildContext) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.album, size: 50),
              title: Text(scoreItem.username.toUpperCase()),
              subtitle: Text(scoreItem.score_number.toString() + " Points"),
            ),
          ],
        ),
      ),
    );
  }

}