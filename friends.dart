import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/friends_provider.dart';
import 'friends_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FriendsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      home: FriendsListPage(),
    );
  }
}
