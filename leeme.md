# Demo Widget DropdownButtonFormFiel
Contenido.
- 1 Resumen
- 2 Librerías necesarias
- 3 Creación del modelo
- 4 Consumir datos desde la API RESTful
- 5 Construir el DropdownButtonFormField
- 6 Capturas
- 7 Link descarga desde github
- 8 Referencias bibliográficas
### 1. Resumen
**DropdownButtonFormField** se trata de un widget DropdownButton (cuadro combinado) para ser utilizado en un formulario. 
El presente documento muestra el funcionamiento en Flutter del widget DropdownButtonFormField, a partir de datos obtenidos desde un servicio RESTFul API. Primero se ha construido el modelo en base a los datos proporcionados por el servicio RESTful, luego con la ayuda del paquete http se creó la función adecuada para consumir estos datos. A continuación, se construyó el DropdownButton en un formulario. Finalmente los datos se validan y al seleccionar un elemento del dropdownButtonFormField, se muestra en el scaffold (usando el snackbar) el id del dato seleccionado.

### 2. Librearías necesarias!
  En el archivo pubspec.yaml agregue la referencia al paqute http
dependencies:  
    http: ^0.12.0+2

### 3. Creación del modelo:
  Para crear el modelo de manera automática, se utilizó el servicio siguiente: (el mismo que permite generar el modelo a partir de datos en formato JSON)
  >https://app.quicktype.io/
 
 Detalle del formato JSON utilizado:
  ~~~
   {
        "idJugador": 1,
        "cedulaIdentidad": "0802223444",
        "idEquipo": 20,
        "apellidos": "POSLIGUA",
        "nombres": "KLEBER",
        "fotografiaURL": "image_picker4850307657518738767.JPG",
        "sexo": "Masculino",
        "fechaNacimiento": "2020-12-02T00:00:00.000Z",
        "correo": "kleberp@gmail.com",
        "nombreInstitucion": "PUCESE",
        "categoriaDeportiva": "FUTBOL MASTER 40 AÑOS"
    } 
   ~~~ 
```sh
Estos datos pueden ser consumidos (para efectos de prueba), con Postman, desde la siguiente dirección: http://gestionafutbol.com:3000/futbol/jugador
```
- Nombre del modelo: lib/models/jugador_models.dart

### 4 Consumir datos desde la API RESTful
Los datos han sido consumidos con http:
- Nombre de archivo: lib/providers/jugador_provider.dart
- Método creado:

~~~
//obtiene el listado de los todos los jugadores
Future<List<JugadorModel>> getJugadores() async {
    final url  = '$API/jugador';
    final resp = await http.get(url, headers: headers);
    final decodedData = json.decode(resp.body);
    final List<JugadorModel> lista = new List();
    if ( decodedData == null ) return [];
    for(var item in decodedData){
      lista.add(JugadorModel.fromJson(item));
    }
    return lista;
  }
~~~
- Este método recupera un listado de jugadores de fútbol.

### 5 Construir el DropdownButtonFormField
Hay que considerar 2 pasos: primero llenar el DropDownMenuItem y luego estos datos, configurar el DropDownButtonFormField:
a) En un Widget **DropdownMenuItem** se carga la lista de jugadores, llamando al método creado en la clase del paso anterior. La variable **_jugadores** recibirá los items del tipo DropdownMenuItem.
~~~
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
~~~
 
 b) Ahora, ya se pueden configurar el **DropdownButtonField** pasándole a la propiedad **items** el valor de la variable **_jugadores**. Otro propiedad importante es **onSaved**, que se ejecuta una vez que el formulario ha sido validado correctamente. Los formularios incluyen la propiedad **validators** para las operaciones de validación. Se ha utilizado **setState** para almacenar el dato seleccionado en el dropdown, y por consiguiente actualizarlo. La propiedad **value** nos permite establecer un valor por defecto cuando se muestra el DropdownButtonFormField; pero se puede prescindir de este valor.
 
 ~~~
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
 ~~~
 
 ### 6. Capturas
 - **Datos en formato JSON**

![Formato JSON](https://i.ibb.co/yS3XmN9/formato-Json.png)


 - **Modelo generado automáticamente**
 ![Modelo generado](https://i.ibb.co/8sfgPtB/img-model.jpg)


 - **Interfaz de usuario**
 ![Interfaz de usuario](https://i.ibb.co/nsnFYYS/ui05.jpg)



- **DropdownButtonFormField desplegado**
![Cuadro combinado desplegado](https://i.ibb.co/H4D1ywN/ui06.jpg)


### 7. Referencias bibliográficas:
~~~
https://github.com/kleberposligua/DropdownButtonFormField_demo.git
~~~

### 8. Referencias bibliográficas:
- https://www.youtube.com/watch?v=DvvnhRo0kHQ
- https://api.flutter.dev/flutter/material/DropdownButtonFormField/DropdownButtonFormField.html
- https://www.youtube.com/watch?v=0QCv9Bkut1Q


