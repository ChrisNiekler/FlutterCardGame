import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard/0auth/models/score.dart';
import 'package:wizard/shared/theme.dart' as Theme;

class ScoreList extends StatefulWidget {

  @override
  _ScoreListState createState() => _ScoreListState();

}

class _ScoreListState extends State<ScoreList> {


  @override
  Widget build(BuildContext context) {

    final score = Provider.of<List<Score>>(context);
    Comparator<Score> scoreComparator = (a, b) => b.score_number.compareTo(a.score_number);
    score.sort(scoreComparator);

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
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.green, Colors.black],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        color: Colors.white,
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