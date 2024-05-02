import 'package:flutter/material.dart';
import 'package:contact_app/helpers/db_helper.dart';
import 'package:contact_app/models/kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);
    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);
    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);
    company = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Kontak'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white10, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TextField(
                controller: mobileNo,
                decoration: InputDecoration(
                  labelText: 'Mobile No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TextField(
                controller: company,
                decoration: InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blue.shade200; // Saat tombol ditekan
                  }
                  return Colors.blue; // Saat tidak ditekan
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                upsertKontak();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      (widget.kontak == null) ? Icons.add : Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      (widget.kontak == null) ? 'Add' : 'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      // update
      await db.updateKontak(Kontak(
        id: widget.kontak!.id,
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'update');
    } else {
      // insert
      await db.saveKontak(Kontak(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
