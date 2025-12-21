import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 252, 185),
      ),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
}
