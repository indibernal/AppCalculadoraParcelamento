import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _produtoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _parcelasController = TextEditingController();
  final TextEditingController _jurosController = TextEditingController();
  String _resultado = '';

  void _calcular() {
    String produto = _produtoController.text;
    double valor = double.parse(_valorController.text);
    int parcelas = int.parse(_parcelasController.text);
    double juros = double.parse(_jurosController.text);

    double valorParcela = valor / parcelas;
    double valorJuros = 0;
    double valorFinal = valor;

    _resultado = 'Produto: $produto\n';
    _resultado += 'Valor original do produto: R\$${valor.toStringAsFixed(2)}\n';
    _resultado += 'Parcelamento em $parcelas vezes\n';

    for (int i = 1; i <= parcelas; i++) {
      valorJuros = valorParcela * juros / 100;
      valorParcela += valorJuros;
      valorFinal += valorJuros;
      _resultado +=
      'Parcela $i: R\$${valorParcela.toStringAsFixed(2)} (Juros: R\$${valorJuros
          .toStringAsFixed(2)})\n';
    }
      _resultado += 'Valor final a ser pago: R\$${valorFinal.toStringAsFixed(2)}.';

      setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calculate_outlined,
                color: Colors.green,
                size: 30,
              ),
              Text('Calculadora de Parcelamento',
                style: TextStyle(color: Colors.black87),),
            ],
          ),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _produtoController,
              decoration: InputDecoration(labelText: 'Nome do produto'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor do produto'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _parcelasController,
              decoration: InputDecoration(labelText: 'Quantidade de parcelas'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jurosController,
              decoration: InputDecoration(labelText: 'Juros ao mês (em %)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: _calcular, child: Text('Calcular'),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
