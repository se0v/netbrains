import 'package:flutter/material.dart';
import 'package:netbrains/pages/profile_page.dart';

import '../models/post.dart';
import '../pages/post_page.dart';

// go to user page
void goUserPage(BuildContext context, String uid) {
  // navigate to the page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(uid: uid),
      ));
}

// go to post page
void goPostPage(BuildContext context, Post post) {
  // navigate to post page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(
          post: post,
        ),
      ));
}
