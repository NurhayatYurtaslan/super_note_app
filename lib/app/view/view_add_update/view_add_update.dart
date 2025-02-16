// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_note_app/app/models/note.dart';
import 'package:super_note_app/bloc/notes_bloc/notes_bloc.dart';
import 'package:super_note_app/core/widgets/action_button_widget.dart';
import 'package:super_note_app/core/widgets/action_icon_widget.dart';
import 'package:super_note_app/core/widgets/desc_text_widget.dart';
import 'package:super_note_app/core/widgets/text_filed_widget.dart';


class AddUpdateNoteScreen extends StatefulWidget {
  final Note? note;

  const AddUpdateNoteScreen({super.key, this.note});

  @override
  State<AddUpdateNoteScreen> createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  late Size _size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Note _note;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.text = widget.note?.title ?? '';
    _descriptionController.text = widget.note?.description ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
      actions: [
        buildActionButton(context, text: "Save", onTap: onTapSave),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TitleTextField(
              size: _size,
              controller: _titleController,
            ),
            Expanded(
              child: DescriptionTextField(
                size: _size,
                controller: _descriptionController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapSave() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (widget.note != null) {
        updateNote();
        Navigator.pop(context, _note);
      } else {
        insertNote(context);
        Navigator.pop(context);
      }
    }
  }

  void updateNote() {
    _note = widget.note!.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<NoteBloc>().add(UpdateNoteEvent(_note));
  }

  void insertNote(BuildContext context) {
    context.read<NoteBloc>().add(
          CreateNoteEvent(
            Note(
              title: _titleController.text,
              description: _descriptionController.text,
              time: DateTime.now(),
            ),
          ),
        );
  }
}
