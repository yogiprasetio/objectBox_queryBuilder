import 'dart:developer';

import 'package:crud_object_box/entities/objectbox.dart';
import 'package:crud_object_box/entities/truck.dart';
import 'package:flutter/material.dart';

import 'objectbox.g.dart';

late Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  store = (await ObjectBox.create()).store;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Object-Box Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final Box<Truck> truckBox = store.box<Truck>();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController kata = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        SafeArea(
          child: Container(
            color: Colors.white,
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: kata,
                  decoration: const InputDecoration(hintText: "Masukkan.."),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  List<String> text = kata.text.split("-");
                  if (text.length == 3) {
                    widget.truckBox.put(Truck(
                        typeName: text[0], noKa: text[1], noSin: text[2]));
                  }
                },
                child: const Text(
                  'Create',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  for (var element in widget.truckBox.getAll()) {
                    log("${element.truckId} => ${element.typeName} || noKa : ${element.noKa} || noSin: ${element.noSin}.");
                  }
                },
                child: const Text(
                  'Read',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  List<String> text = kata.text.split("-");
                  if (text.length == 4) {
                    int id = int.tryParse(text[0]) ?? 0;
                    if (id > 0) {
                      widget.truckBox.put(Truck(
                          truckId: id,
                          typeName: text[1],
                          noKa: text[2],
                          noSin: text[3]));
                    }
                  }
                },
                child: const Text(
                  'Update',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  int id = int.tryParse(kata.text) ?? 0;
                  if (id > 0) {
                    log(widget.truckBox.remove(id).toString());
                  }
                },
                child: const Text(
                  'Delete',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  QueryBuilder<Truck> inggridients = widget.truckBox.query(
                      Truck_.typeName.startsWith("l") |
                          Truck_.noKa.equals(kata.text));
                  Query<Truck> query = inggridients.build();
                  log("Berikut adalah hasil opencarian Truck dengan 'NOKA' yang mirip dengan kata kunci: $kata.\n");
                  for (var elements in query.find()) {
                    log("NOKA: ${elements.noSin}|${elements.truckId}|${elements.typeName}|${elements.noSin}");
                  }
                },
                child: const Text(
                  'Run Query',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
