import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_note_app/app/models/note.dart';
import 'package:super_note_app/core/constants/color_constants.dart';

class NotesGridItem extends StatelessWidget {
  final Random random = Random();
  final Note note;
  final VoidCallback onGridItemTap;
  final VoidCallback onGridItemLongPress;

  NotesGridItem(
      {super.key,
      required this.note,
      required this.onGridItemTap,
      required this.onGridItemLongPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.list[random.nextInt(AppColors.list.length)],
      child: InkWell(
        onTap: onGridItemTap,
        enableFeedback: true,
        onLongPress: onGridItemLongPress,
        splashColor: AppColors.white,
        child: LayoutBuilder(builder: (context, innerConstraints) {
          return Padding(
            padding: EdgeInsets.all(innerConstraints.maxHeight * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      note.title ?? '',
                      maxLines: 4,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: innerConstraints.maxHeight * 0.115,
                              ),
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(note.time!),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: innerConstraints.maxHeight * 0.08,
                      ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
