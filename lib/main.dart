import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/my_bloc_observer.dart';
import 'features/item_list/presentation/pages/item_list_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevPace Flutter Test Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ItemListScreen(),
    );
  }
}
