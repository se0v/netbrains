import 'package:flutter/material.dart';
import 'package:netbrains/components/my_input_alert_box.dart';
import 'package:netbrains/components/my_post_tile.dart';
import 'package:netbrains/helper/navigate_pages.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // text controllers
  final _messageController = TextEditingController();

  // on startup
  @override
  void initState() {
    super.initState();

    // let's load all the posts!
    loadAllPosts();
  }

  // load all posts
  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  // show post message dialog box
  void _openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
          textController: _messageController,
          hintText: "Что скажете?",
          onPressed: () async {
            // post in db
            await postMessage(_messageController.text);
          },
          onPressedText: "Ввод"),
    );
  }

  // user wants to post message
  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),

      // App Bar
      appBar: AppBar(
        title: const Text("Ф О Р У М"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        child: const Icon(Icons.add),
      ),

      // Body: list of all posts
      body: _buildPostList(listeningProvider.allPosts),
    );
  }

  // build list UI given a list of posts
  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ?

        // post list is empty
        const Center(
            child: Text("Ничего"),
          )
        :
        // post list is NOT empty
        ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              // get each individual post
              final post = posts[index];

              // return Post Tile UI
              return MyPostTile(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }
}
