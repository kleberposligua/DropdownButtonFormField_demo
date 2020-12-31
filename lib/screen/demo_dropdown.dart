import 'package:dropdownbuttonformfield/providers/jugador_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DemoDropDown extends StatefulWidget {
  @override
  _DemoDropDownState createState() => _DemoDropDownState();
}

class _DemoDropDownState extends State<DemoDropDown> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _guardando = false;

  var _jugadores = List<DropdownMenuItem>();
  int _jugadorSeleccionado;

  _getJugadores() async {
    var _jugadorProvider = JugadorProvider(); 

    //recupare la lista de jugadores
    var listaJugadores = await _jugadorProvider.getJugadores(); 
    
    //Se recorre la lista de jugadores para crear cada DropdownMenuItem
    listaJugadores.forEach((element) {
      setState(() {
        //la variable _jugadores es una lista de DropdownMenuItem
        _jugadores.add(DropdownMenuItem(
          //dato que se mostrará en el DropDownMenuItem
          child: Text('${element.apellidos.toUpperCase()} ${element.nombres.toUpperCase()}'),
          
          //valor que se utilizará cuando se seleccione una opción del DropDownMenuItem
          value: element.idJugador,
        ));
      });
    });
  }



  @override
  void initState() {
    super.initState();
    _guardando=false;
    _getJugadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: Padding(
                padding: EdgeInsets.only(top: 42),
                child: Text("Jugadores de Fútbol"),
              ),
        )
        
        ),
      body:  Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text("Seleccione un jugador"),
                _crearDropDownJugadores(),
                _crearBotonGuardar(),
              ],
            ),
          ),
    )
    );
  }


 Widget _crearDropDownJugadores() {
    return DropdownButtonFormField(
      //value: 16,  //id del jugador que quiero que aparezca por defecto
      //este valor se puede comentar, para que inicialmente no se mueste ningún dato en la dropdown
      items: _jugadores,
      onSaved: (value) => _jugadorSeleccionado = value,
      validator: (value) {
        if (value == null) return "Debe seleccionar un jugador";
        return null;
      },
      onChanged: (newVal) {
        setState(() {
          _jugadorSeleccionado = newVal;
          print(_jugadorSeleccionado);
        });
      },
    );
  }


  //button guardar
  Widget _crearBotonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }



  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    //agregar aquí código para guardar en registro

    
    mostrarSnackbar('Registro guardado id Jugador: $_jugadorSeleccionado' );
    setState(() {_guardando = false; });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

}