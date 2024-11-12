import 'dart:core';

import 'package:flutter/material.dart';
import 'package:netbrains/services/database/database_service.dart';

import '../../models/comment.dart';
import '../../models/note.dart';
import '../../models/post.dart';
import '../../models/user.dart';

class DatabaseProvider extends ChangeNotifier {
  // get db & auth service
  final _db = DatabaseService();

  // USER PROFILE
  // get user profile given uid
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  // update user bio
  Future<void> updateBio(String bio) => _db.updateUserBioInFirebase(bio);

  /*

  NOTES

  */

  // local list of notes
  List<Note> _allNotes = [];

  // get notes
  List<Note> get allNotes => _allNotes;

  // note create
  Future<void> createNote(String note) async {
    // note create in firebase
    await _db.createNoteInFirebase(note);

    // reload data from firebase
    await loadAllNotes();
  }

  // fetch all notes
  Future<void> loadAllNotes() async {
    // get all notes from firebase
    final allNotes = await _db.getAllNotesFromFirebase();

    // update local data
    _allNotes = allNotes;

    // update UI
    notifyListeners();
  }

  // filter and returns notes given uid
  List<Note> filterUserNotes(String uid) {
    return _allNotes.where((note) => note.uid == uid).toList();
  }

  /*

  POSTS

  */

  // local list of posts
  List<Post> _allPosts = [];

  // get posts
  List<Post> get allPosts => _allPosts;

  // post message
  Future<void> postMessage(String message) async {
    // post message in firebase
    await _db.postMessageInFirebase(message);

    // reload data from firebase
    await loadAllPosts();
  }

  // fetch all posts
  Future<void> loadAllPosts() async {
    // get all posts from firebase
    final allPosts = await _db.getAllPostsFromFirebase();

    // update local data
    _allPosts = allPosts;

    // update UI
    notifyListeners();
  }

  // filter and return posts given uid
  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  // delete post
  Future<void> deletePost(String postId) async {
    // delete from firebase
    await _db.deletePostFromFirebase(postId);

    // reload data from firebase
    await loadAllPosts();
  }

  /*

  COMMENTS

  {
  
  postId1: [ comment1, comment2, .. ],
  postId2: [ comment1, comment2, .. ],
  postId3: [ comment1, comment2, .. ],
  
  }

  */

  // local list of comments
  final Map<String, List<Comment>> _comments = {};

  // get comments locally
  List<Comment> getComments(String postId) => _comments[postId] ?? [];

  // fetch comments from database for a post
  Future<void> loadComments(String postId) async {
    // get all comments for this post
    final allComments = await _db.getCommentsFromFirebase(postId);

    // update local data
    _comments[postId] = allComments;

    // update UI
    notifyListeners();
  }

  // add a comment
  Future<void> addComment(String postId, message) async {
    // add comment in firebase
    await _db.addCommentInFirebase(postId, message);
    // reload comments
    await loadComments(postId);
  }

  // delete a comment
  Future<void> deleteComment(String commentId, postId) async {
    // delete comment in firebase
    await _db.deleteCommentInFirebase(commentId);

    // reload comments
    await loadComments(postId);
  }
}
