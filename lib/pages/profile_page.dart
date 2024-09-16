import 'package:flutter/material.dart';
import 'package:netbrains/components/my_bio_box.dart';
import 'package:netbrains/components/my_input_alert_box.dart';
import 'package:netbrains/components/my_post_tile.dart';
import 'package:netbrains/helper/navigate_pages.dart';
import 'package:netbrains/models/user.dart';
import 'package:netbrains/services/auth/auth_service.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';

class ProfilePage extends StatefulWidget {
  // user id
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  // user info
  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();

  // text controller for bio
  final bioTextController = TextEditingController();

  // loading
  bool _isLoading = true;

  // on startup
  @override
  void initState() {
    super.initState();

    // load user info
    loadUser();
  }

  Future<void> loadUser() async {
    // get the user profle info
    user = await databaseProvider.userProfile(widget.uid);

    // finished loading
    setState(() {
      _isLoading = false;
    });
  }

  // show edit bio box
  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
          textController: bioTextController,
          hintText: "Изменить статус",
          onPressed: saveBio,
          onPressedText: "Сохранить"),
    );
  }

  Future<void> saveBio() async {
    // start loading
    setState(() {
      _isLoading = true;
    });

    // update bio
    await databaseProvider.updateBio(bioTextController.text);

    // reload user
    await loadUser();

    // done loading
    setState(() {
      _isLoading = false;
    });
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // get user posts
    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);

    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      // App Bar
      appBar: AppBar(
        title: Text(_isLoading ? '' : user!.name),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      // Body
      body: ListView(
        children: [
          // username handle
          Center(
            child: Text(
              _isLoading ? '' : '@${user!.username}',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // profile picture
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.all(25),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // profile stats
          // follow button
          // edit bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Статус",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: _showEditBioBox,
                  child: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // bio box
          MyBioBox(text: _isLoading ? '...' : user!.bio),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: Text(
              "Posts",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),

          // list of posts from user
          allUserPosts.isEmpty
              ?

              // user post is empty
              const Center(
                  child: Text("Ещё нет записей.."),
                )
              :
              // user post is NOT empty
              ListView.builder(
                  itemCount: allUserPosts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // get individual posts
                    final post = allUserPosts[index];

                    // post tile UI
                    return MyPostTile(
                      post: post,
                      onUserTap: () {},
                      onPostTap: () => goPostPage(context, post),
                    );
                  })
        ],
      ),
    );
  }
}
