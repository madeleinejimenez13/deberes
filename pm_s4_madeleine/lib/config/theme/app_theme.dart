import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color.fromARGB(255, 140, 245, 224), 
      const List <Color> _colorTheme = [
        _customColor,
        Colors.green,
        Colors.orange,
        Colors.pink,
        Colors.white24
      ];
      
      class AppTheme{
        final int selectedColor;
      }

      ThemeData theme(){
        return ThemeData(
          useMaterial3: true,
          colorScheme: _colorThemes [selectedColor],
          brightness: Brightness.light
        )
      }
    );

  }
}