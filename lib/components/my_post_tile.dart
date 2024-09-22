/*

POST TILE

--------------------------------------------------------------------------------

To use this widget, u need:

- the post

- a function for onPostTap ( go to the individual post to see it's comments )

- a function for onPostTap ( go to user's profile page )

*/
import 'package:flutter/material.dart';
import 'package:netbrains/components/my_input_alert_box.dart';
import 'package:netbrains/services/auth/auth_service.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';

class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const MyPostTile(
      {super.key,
      required this.post,
      required this.onUserTap,
      required this.onPostTap});

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  // providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // on startup
  @override
  void initState() {
    super.initState();

    // load comments for this post
    _loadComments();
  }

  /*

  COMMENTS

  */

  // comment text controller
  final _commentController = TextEditingController();

  // open comment box -> user wants to type new comment
  void _openNewCommentBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
        textController: _commentController,
        hintText: "Комментарий",
        onPressed: () async {
          // add post in db
          await _addComment();
        },
        onPressedText: "Ввод",
      ),
    );
  }

  // user tapped post to add comment
  Future<void> _addComment() async {
    // does nothing if theres nothing in the textfield
    if (_commentController.text.trim().isEmpty) return;

    // attempt to post comment
    try {
      await databaseProvider.addComment(
          widget.post.id, _commentController.text.trim());
    } catch (e) {
      print(e);
    }
  }

  // load comments
  Future<void> _loadComments() async {
    await databaseProvider.loadComments(widget.post.id);
  }

  // show options for post
  void _showOptions() {
    // check if this post is owned by the user or not
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;

    // show options
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                // THIS POST BELONGS TO USER
                if (isOwnPost)

                  // delete message button
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Удалить"),
                    onTap: () async {
                      // pop option box
                      Navigator.pop(context);

                      // handle delete action
                      await databaseProvider.deletePost(widget.post.id);
                    },
                  )

                // THIS POST DOES NOT BELONG TO USER
                else
                  ...[],
                // cancel button
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Отмена"),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // listen to comment count
    int commentCount = listeningProvider.getComments(widget.post.id).length;

    // Container
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        // Padding outside
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

        // Padding inside
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          // Color of post tile
          color: Theme.of(context).colorScheme.secondary,
          // Curve corners
          borderRadius: BorderRadius.circular(8),
        ),
        // Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section: profile pic / name / username
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
                  // profile pic
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Text(
                          widget.post.name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        // username handle
                        Text(
                          '@${widget.post.username}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ]),

                  const Spacer(),

                  // buttons -> more options: delete
                  GestureDetector(
                    onTap: _showOptions,
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // message
            SelectableText(
              widget.post.message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),

            const SizedBox(
              height: 20,
            ),

            // COMMENT SECTIONS
            Row(
              children: [
                // comment button
                GestureDetector(
                  onTap: _openNewCommentBox,
                  child: Icon(Icons.comment,
                      color: Theme.of(context).colorScheme.primary),
                ),

                const SizedBox(
                  width: 5,
                ),

                // comment count
                Text(
                  commentCount != 0 ? commentCount.toString() : '',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
