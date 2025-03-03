// lib/friends_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Correct import
import 'providers/friends_provider.dart';
import 'models/friendmodel.dart';

class FriendsListPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final friendsProvider = Provider.of<FriendsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: friendsProvider.friends.length,
              itemBuilder: (context, index) {
                final friend = friendsProvider.friends[index];
                return ListTile(
                  title: Text(friend.name),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      friendsProvider.removeFriend(friend.id);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Add Friend'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      friendsProvider.addFriend(Friend(
                        name: _controller.text,
                        id: DateTime.now().toString(),
                      ));
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
