import 'package:flutter/material.dart';
import 'agricolas.dart';
import 'database_helper.dart';

class AgricolasScreen extends StatefulWidget {
  final Agricola agricolas;
  AgricolasScreen(this.agricolas);
  @override
  State<StatefulWidget> createState() => new _AgricolasScreenState();
}

class _AgricolasScreenState extends State<AgricolasScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _tipoController;
  TextEditingController _marcaController;
  TextEditingController _quantidadeController;
  TextEditingController _precoController;
  @override
  void initState() {
    super.initState();
    _tipoController = new TextEditingController(text: widget.agricolas.tipo);
    _marcaController = new TextEditingController(text: widget.agricolas.marca);
    _quantidadeController = new TextEditingController(text: widget.agricolas.quantidade);
    _precoController = new TextEditingController(text: widget.agricolas.preco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  (widget.agricolas.id != null)
            ? Text('Alterar produto')
            : Text('Adicionar produto Agricola'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(16.0),
                child:
                Image.asset(
                    'images/agricolas.png',
                    height: 100,
                    fit: BoxFit.fill,
                    width: 200
                )
            ),
            // Padding(padding: new EdgeInsets.all(8.0)),
            textFormField(_tipoController,'Tipo'),
            Padding(padding: new EdgeInsets.all(5.0)),
            textFormField(_marcaController,'Marca'),
            Padding(padding: new EdgeInsets.all(5.0)),
            textFormField(_quantidadeController, 'Quantidade'),
            Padding(padding: new EdgeInsets.all(5.0)),
            textFormField(_precoController, 'Preço'),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.agricolas.id != null)
                  ? Text('Alterar')
                  : Text('Cadastrar'),
              onPressed: () {
                if (widget.agricolas.id != null) {
                  db
                      .updateAgriculas(Agricola.fromMap({
                    'id': widget.agricolas.id,
                    'tipo': _tipoController.text,
                    'marca': _marcaController.text,
                    'quantidade': _quantidadeController.text,
                    'preco': _precoController.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .insertAgriculas(Agricola(
                      _tipoController.text,
                      _marcaController.text,
                      _quantidadeController.text,
                      _precoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  textFormField(TextEditingController tec, String label) {
    var padding = Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        controller: tec,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            hintText: label,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
    return padding;
  }
}