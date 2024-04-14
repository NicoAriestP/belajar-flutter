import 'package:belajar_flutter_4/database/note_database.dart';
import 'package:belajar_flutter_4/pages/add_edit_note_page.dart';
import 'package:belajar_flutter_4/pages/note_detail_page.dart';
import 'package:belajar_flutter_4/widgets/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter_4/models/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> _notes;
  var _isLoading = false;

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });
    _notes = await NoteDatabase.instance.getAllNotes();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // final note = Note(
          //     isImportant: false,
          //     number: 1,
          //     title: 'Testing',
          //     description: 'Desc testing',
          //     createdTime: DateTime.now());
          // await NoteDatabase.instance.create(note);
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEditNotePage()));
          _refreshNotes();
        },
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _notes.isEmpty
              ? Text('Notes Kosong')
              : MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: _notes.length,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return GestureDetector(
                        onTap: () async {
                         await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoteDetailPage(id: note.id!)));
                         _refreshNotes();
                        },
                        child: NoteCardWidget(note: note, index: index));
                  }),
    );
  }
}
