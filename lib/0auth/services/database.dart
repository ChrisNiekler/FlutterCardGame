import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wizard/0auth/models/score.dart';

class DatabaseService {

  final String uid;

  // Collection reference
  final CollectionReference scoreCollection = Firestore.instance.collection('score');

  DatabaseService({this.uid});


  Future updateScoreData(String username, int score_number) async {
    return await scoreCollection.document(uid).setData({
      'username': username,
      'score_number': score_number
    });
  }

  List<Score> scoreListFromFirestore(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Score(
        username: doc.data['username'] ?? '',
        score_number: doc.data['score_number'] ?? 0
      );
    }).toList();
  }

  // get score data for all users
  Stream<List<Score>> get score {
    return scoreCollection.snapshots()
    .map(scoreListFromFirestore);
  }

}