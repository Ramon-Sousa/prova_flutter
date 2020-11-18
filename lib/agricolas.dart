class Agricola {
  int _id;
  String _tipo;
  String _marca;
  String _quantidade;
  String _preco;

  Agricola(this._tipo, this._marca, this._quantidade, this._preco);

  Agricola.map(dynamic obj) {
    this._id = obj['id'];
    this._tipo = obj['tipo'];
    this._marca = obj['marca'];
    this._quantidade = obj['quantidade'];
    this._preco = obj['preco'];
  }

  int get id => _id;
  String get tipo => _tipo;
  String get marca => _marca;
  String get quantidade => _quantidade;
  String get preco => _preco;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['tipo'] = _tipo;
    map['marca'] = _marca;
    map['quantidade'] = _quantidade;
    map['preco'] = _preco;
    return map;
  }

  Agricola.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._tipo = map['tipo'];
    this._marca = map['marca'];
    this._quantidade = map['quantidade'];
    this._preco = map['preco'];
  }
}