import 'package:flutter/material.dart';
import 'package:super_note_app/core/constants/color_constants.dart';

Widget buildDialogActionButton(String text, Color color, VoidCallback onTap) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: color, // Background color
    ),
    child: Text(text,
        style: const TextStyle(
          color: AppColors.white,
        )),
  );
}
