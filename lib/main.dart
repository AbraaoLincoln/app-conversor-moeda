import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
    ));

Future<Map> getResource() async {
  //http.Response res = await http.get("url");
  return json.decode('{"price": 1.0}');
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realTextControlle = TextEditingController();
  final dolarTextControlle = TextEditingController();
  final euroTextControlle = TextEditingController();
  late double dollar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor de Moeda"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando...",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dollar = snapshot.data!["price"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        TextField(
                            controller: realTextControlle,
                            onChanged: _limaparCampos,
                            decoration: InputDecoration(
                                labelText: "Reais",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "R\$"),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25)),
                        Divider(),
                        TextField(
                            controller: dolarTextControlle,
                            onChanged: _limaparCampos,
                            decoration: InputDecoration(
                                labelText: "Dolares",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "US\$"),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25)),
                        Divider(),
                        TextField(
                            controller: euroTextControlle,
                            onChanged: _limaparCampos,
                            decoration: InputDecoration(
                                labelText: "Euros",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "EU\$"),
                            style: TextStyle(color: Colors.amber, fontSize: 25))
                      ],
                    ),
                  );
                }
            }
          },
          future: getResource()),
    );
  }

  void _limaparCampos(String value) {
    if (value.isEmpty) {
      realTextControlle.text = "";
      dolarTextControlle.text = "";
      euroTextControlle.text = "";
    }
  }
}
