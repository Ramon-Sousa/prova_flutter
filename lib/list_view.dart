import 'package:flutter/material.dart';
import 'agricolas.dart';
import 'database_helper.dart';
import 'agricolas_screen.dart';

class ListViewAgricolas extends StatefulWidget {
  @override
  _ListViewAgricolasState createState() => new _ListViewAgricolasState();
}

class _ListViewAgricolasState extends State<ListViewAgricolas> {
  List<Agricola> agricolas = new List();

  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getAgriculass().then((agricolas) {
      setState(() {
        agricolas.forEach((agricola) {
          agricolas.add(Agricola.fromMap(agricola));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventário',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Produtos'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: agricolas.length,
              padding: const EdgeInsets.all(15.0),

              itemBuilder: (context, position) {
                return Column(
                  children: [

                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${agricolas[position].tipo}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text(
                            '${agricolas[position].tipo} ${agricolas[position].marca} ${agricolas[position].quantidade} ${agricolas[position].preco}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        IconButton(
                            icon: const Icon(Icons.delete_forever),
                            color: Colors.red,
                            onPressed: () => _deleteAgricola(
                                context, agricolas[position], position)),
                      ]),
                      onTap: () => _navigateToAgricola(context, agricolas[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.account_tree_outlined),
          onPressed: () => _createNewAgricola(context),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  void _deleteAgricola(
      BuildContext context, Agricola agricola, int position) async {
    db.deleteAgriculas(agricola.id).then((agricola) {
      setState(() {
        agricolas.removeAt(position);
      });
    });
  }

  void _navigateToAgricola(BuildContext context, Agricola agricola) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgricolasScreen(agricola)),
    );
    if (result == 'update') {
      db.getAgriculass().then((agricola) {
        setState(() {
          agricolas.clear();
          agricola.forEach((agricola) {
            agricolas.add(Agricola.fromMap(agricola));
          });
        });
      });
    }
  }

  void _createNewAgricola(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  AgricolasScreen(Agricola('', '', '', ''))),
    );

    if (result == 'save') {
      db.getAgriculass().then((agricola) {
        setState(() {
          agricolas.clear();
          agricola.forEach((agricola) {
            agricolas.add(Agricola.fromMap(agricola));
          });
        });
      });
    }
  }
}