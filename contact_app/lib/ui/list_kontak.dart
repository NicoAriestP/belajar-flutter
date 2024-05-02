import 'package:flutter/material.dart';
import 'package:contact_app/helpers/db_helper.dart';
import 'package:contact_app/models/kontak.dart';
import 'package:contact_app/ui/form_kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);

  @override
  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    // Menjalankan fungsi getAllKontak() ketika aplikasi pertama kali dijalankan
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Contacts", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Color.fromRGBO(38, 38, 38, 1),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Color.fromRGBO(38, 38, 38, 1),
        child: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 23,
                  child: const Icon(
                    Icons.person,
                    size: 46,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(38, 38, 38, 1),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${kontak.name}',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${kontak.mobileNo}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _openFormEdit(kontak);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(kontak, index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }



  // Method untuk menampilkan dialog konfirmasi sebelum menghapus kontak
  Future<void> _showDeleteConfirmationDialog(Kontak kontak, int position) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Apakah Anda yakin ingin menghapus kontak ${kontak.name}?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteKontak(kontak, position);
                Navigator.of(context).pop();
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }


  // Mengambil semua data kontak dari database
  Future<void> _getAllKontak() async {
    // list menampung data dari database
    var list = await db.getAllKontak();

    // Ada perubahan State
    setState(() {
      // hapus data pada listKontak
      listKontak.clear();

      // lakukan perulangan pada variabel list
      list!.forEach((kontak) {
        // masukkan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  // Menghapus data kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    // hapus data kontak dari database
    await db.deleteKontak(kontak.id!);

    // Ada perubahan State
    setState(() {
      // hapus data kontak dari listKontak
      listKontak.removeAt(position);
    });
  }

  // Membuka halaman tambah kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormKontak(),
      ),
    );
    if (result == "save") {
      _getAllKontak();
    }
  }

  // Membuka halaman edit kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormKontak(
          kontak: kontak,
        ),
      ),
    );
    if (result == "update") {
      _getAllKontak();
    }
  }
}
