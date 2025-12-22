import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 97, 255, 18),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 0, 28, 23),
  brightness: Brightness.dark,
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.onSecondary,
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
}
