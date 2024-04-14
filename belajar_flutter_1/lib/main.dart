import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dart Basic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterGanjil = 1;
  int _counterGenap = 0;
  int _counter = 1;
  String myNRP = '3122510644';

  void _incrementCounter() {
  setState(() {
    if (_counterGanjil > 17) {
      _counterGanjil = 1;
      _counterGenap = 0;
      _counter = 1; // Set _counter kembali ke 1 untuk menghindari out of range saat mengambil substring
    } else {
      _counterGanjil += 2;
      _counterGenap += 2;
      _counter++;
    }

    // Jika _counter mencapai panjang myNRP, kembalikan ke 0
    if (_counter > myNRP.length) {
      _counter = 0;
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bilangan Ganjil',
            ),
            Text(
              '$_counterGanjil',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Text(
              'Bilangan Genap',
            ),
            Text(
              '$_counterGenap',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Text(
              'NRP Nico Ariest Putra',
            ),
            Text(
              myNRP.substring(0, _counter),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _counter,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(index + 1, (int i) {
                        return Text(
                          '0',
                          style: Theme.of(context).textTheme.headline6,
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}