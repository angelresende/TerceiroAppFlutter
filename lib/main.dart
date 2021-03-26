import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC',
      home: TelaPrincipal(),

      //Tema do App
      theme: ThemeData(
          primaryColor: Colors.indigo[400],
          backgroundColor: Colors.grey[100],
          fontFamily: 'New Tegomin',
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontStyle: FontStyle.normal),
              headline2: TextStyle(fontSize: 18, color: Colors.indigo[400])))));
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Atributos para armazenar os valores digitados pelo usuário
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();

  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC',
              style: Theme.of(context).textTheme.headline1),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  formKey.currentState.reset();
                  txtPeso.text = "";
                  txtAltura.text = "";
                  FocusScope.of(context).unfocus();
                });
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(children: [
              Icon(Icons.people,
                  size: 120, color: Theme.of(context).primaryColor),
              campoTexto('Peso', txtPeso),
              campoTexto('Altura', txtAltura),
              botao('Calcular'),
            ]),
          ),
        ));
  }

  //
  // Campo de texto para entrada de dados
  //
  Widget campoTexto(rotulo, variavel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: variavel,
        style: TextStyle(fontSize: 24),

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: Theme.of(context).textTheme.headline2,
          hintText: 'Entre com o valor',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        //Validar a entrada de dados
        validator: (value) {
          if (double.tryParse(value) == null) {
            return 'Entre com um valor numérico!';
          } else {
            return null;
          }
        },
      ),
    );
  }

  //
  // Botão
  //
  Widget botao(rotulo) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        child: Text(rotulo, style: TextStyle(fontSize: 18)),
        onPressed: () {
          if (formKey.currentState.validate()) {
            /*O método setState é utilizado todas as vezes que é
            necessário alterar o estado do App*/
            setState(() {
              double peso = double.parse(txtPeso.text);
              double altura = double.parse(txtAltura.text);
              double imc = peso / pow(altura, 2);
              caixaDialogo('O valor do IMC é ${imc.toStringAsFixed(2)}');
            });
          }
        },
      ),
    );
  }

  //
  // Caixa de diálogo
  //
  caixaDialogo(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resultado'),
            content: Text(msg),
            actions: [
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
