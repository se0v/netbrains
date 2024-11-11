/*
- User profile
- Post message
- Likes
- Comments
- Acc stuff
- Follow?
- Search?
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netbrains/models/comment.dart';
import 'package:netbrains/models/post.dart';
import 'package:netbrains/models/user.dart';
import 'package:netbrains/services/auth/auth_service.dart';

import '../../models/note.dart';

class DatabaseService {
  // get instance of firebase db & auth
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  /*

  USER PROFILE

  */

  // Save user info
  Future<void> saveUserInfoInFirebase(
      {required String name, required String email}) async {
    // get current uid
    String uid = _auth.currentUser!.uid;

    // extract username from email
    String username = email.split('@')[0];

    // create a user profile
    UserProfile user = UserProfile(
        uid: uid, name: name, email: email, username: username, bio: '');

    // convert user into a map so that we can store in firebase
    final userMap = user.toMap();

    // save user info in firebase
    await _db.collection("Users").doc(uid).set(userMap);
  }

  // Get user info
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      // retrieve user doc from firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      // convert doc to user profile
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Update user bio
  Future<void> updateUserBioInFirebase(String bio) async {
    // get current uid
    String uid = AuthService().getCurrentUid();

    // attempt to update in firebase
    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  /*

  CREATE NOTE
  
  */

  // create a note
  Future<void> createNoteInFirebase(String note) async {
    // try to create note
    try {
      // get current uid
      String uid = _auth.currentUser!.uid;

      // use this uid to get the user's profile
      UserProfile? user = await getUserFromFirebase(uid);

      // create a new note
      Note newNote = Note(
        id: '', // auto generate
        uid: uid,
        name: user!.name,
        username: user.username,
        note: note,
        timestamp: Timestamp.now(),
      );

      // convert note obj -> map
      Map<String, dynamic> newNoteMap = newNote.toMap();

      // add to firebase
      await _db.collection("Notes").add(newNoteMap);
    }

    // catch any errors
    catch (e) {
      print(e);
    }
  }

  // Get all notes from Firebase
  Future<List<Note>> getAllNotesFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          // go to collection -> Notes
          .collection("Notes")
          // chronological order
          .orderBy('timestamp', descending: true)
          // get this data
          .get();

      // return as a list of notes
      return snapshot.docs.map((doc) => Note.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  /*

  POST MESSAGE
  
  */

  // Post a message
  Future<void> postMessageInFirebase(String message) async {
    // try to post message
    try {
      // get current uid
      String uid = _auth.currentUser!.uid;

      // use this uid to get the user's profile
      UserProfile? user = await getUserFromFirebase(uid);

      // create a new post
      Post newPost = Post(
          id: '', // auto generate
          uid: uid,
          name: user!.name,
          username: user.username,
          message: message,
          timestamp: Timestamp.now(),
          likeCount: 0,
          likedBy: []);

      // convert post object -> map
      Map<String, dynamic> newPostMap = newPost.toMap();

      // add to firebase
      await _db.collection("Posts").add(newPostMap);
    }

    // catch any errors
    catch (e) {
      print(e);
    }
  }

  // Delete a post
  Future<void> deletePostFromFirebase(String postId) async {
    try {
      await _db.collection("Posts").doc(postId).delete();
    } catch (e) {
      print(e);
    }
  }

  // Get all posts from Firebase
  Future<List<Post>> getAllPostsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          //  go to collection -> Posts
          .collection("Posts")
          // chronological order
          .orderBy('timestamp', descending: true)
          // get this data
          .get();

      // return as a list of posts
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }
  // Get individual post

  /*

  LIKES
  
  */

  /*

  COMMENTS
  
  */

  // Add a comment to a post
  Future<void> addCommentInFirebase(String postId, message) async {
    try {
      // get current user
      String uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);

      // create a new comment
      Comment newComment = Comment(
          id: '', // auto generated by firestore
          postId: postId,
          uid: uid,
          name: user!.name,
          username: user.username,
          message: message,
          timestamp: Timestamp.now());

      // convert comment to map
      Map<String, dynamic> newCommentMap = newComment.toMap();

      // to store in firebase
      await _db.collection("Comments").add(newCommentMap);
    } catch (e) {
      print(e);
    }
  }

  // Delete a comment from a post
  Future<void> deleteCommentInFirebase(String commentId) async {
    try {
      await _db.collection("Comments").doc(commentId).delete();
    } catch (e) {
      print(e);
    }
  }

  // Fetch comments for a post
  Future<List<Comment>> getCommentsFromFirebase(String postId) async {
    try {
      // get comments from firebase
      QuerySnapshot snapshot = await _db
          .collection("Comments")
          .where("postId", isEqualTo: postId)
          .get();

      // return as a list of comments
      return snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
  /*

  ACC STUFF
  
  */

  /*

  FOLLOW
  
  */

  /*

  SEARCH
  
  */

  /*
  SHEDULE MARKS
  
  */

// save event in Firestore
  Future<void> saveEvent(
      String date, Map<String, dynamic> event, String uid) async {
    //String uid = _auth.currentUser!.uid;
    try {
      // get uni id doc
      final docRef =
          _db.collection('Events').doc(date).collection('events').doc();
      final eventWithId = event;
      event['id'] = docRef.id; // add id event
      event['uid'] = uid;

      await docRef.set(eventWithId);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getEvents(String date, String uid) async {
    try {
      final querySnapshot = await _db
          .collection('Events')
          .doc(date)
          .collection('events')
          .where('uid', isEqualTo: uid)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // add id doc
        return data;
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // delete event by ID
  Future<void> deleteEvent(String date, String eventId) async {
    try {
      await _db
          .collection('Events')
          .doc(date)
          .collection('events')
          .doc(eventId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
