import 'package:flutter/material.dart';
import 'package:preferenciausuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciausuarioapp/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario = false;
  int _genero;
  String _nombre = 'Nahuel';

  TextEditingController _textController;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() { 
    super.initState();
    prefs.ultimaPagina = SettingsPage.routeName;
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController = new TextEditingController( text: prefs.nombre );
  }

  _setSelectedRadio( int valor ) {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  _setColorSecundario( bool valor) {
    prefs.colorSecundario = valor;
    _colorSecundario = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),),
          ),

          Divider(),

          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: _setColorSecundario
          ),

          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: ( value ) {
                prefs.nombre = value;
              },
            ),
          )
          
        ],
      )
    );
  }
}