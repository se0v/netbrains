import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String uid;
  final String name;
  final String username;
  final String note;
  final Timestamp timestamp;

  Note(
      {required this.id,
      required this.uid,
      required this.name,
      required this.username,
      required this.note,
      required this.timestamp});

  // convert a firestore document to a Note object (to use in our app)
  factory Note.fromDocument(DocumentSnapshot doc) {
    return Note(
        id: doc.id,
        uid: doc['uid'],
        name: doc['name'],
        username: doc['username'],
        note: doc['note'],
        timestamp: doc['timestamp']);
  }

  // convert a note object to a map (to store in Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'note': note,
      'timestamp': timestamp,
    };
  }
}
