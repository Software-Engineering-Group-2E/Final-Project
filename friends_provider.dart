import 'package:flutter/material.dart';
import '../models/friend_model.dart';

class FriendsProvider with ChangeNotifier {
  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  void addFriend(Friend friend) {
    _friends.add(friend);
    notifyListeners();
  }

  void removeFriend(String id) {
    _friends.removeWhere((friend) => friend.id == id);
    notifyListeners();
  }
}
