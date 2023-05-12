import 'package:dam_u4_proyecto1/modelos/bitacora.dart';
import 'package:dam_u4_proyecto1/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class AddBitacora extends StatefulWidget {
  const AddBitacora({Key? key}) : super(key: key);

  @override
  State<AddBitacora> createState() => _AddBitacoraState();
}

class _AddBitacoraState extends State<AddBitacora> {


  final eventoController = TextEditingController();
  final fechaController = TextEditingController();
  final fechaVerificacionController = TextEditingController();
  final recursosController = TextEditingController();
  final verificoController = TextEditingController();
  final idbitacoraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String argument = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Bitacora"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: idbitacoraController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Id bitacora"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: eventoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Evento"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fechaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Fecha",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // Quita el foco del teclado
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                fechaController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
              }
            },
            readOnly: true, // Evita que el usuario escriba la fecha manualmente
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fechaVerificacionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Fecha de Verificacion",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // Quita el foco del teclado
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                fechaVerificacionController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
              }
            },
            readOnly: true, // Evita que el usuario escriba la fecha manualmente
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: recursosController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Recursos"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: verificoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Verifico"),
          ),

          FilledButton(
              onPressed: () async {
                 Bitacora veh =Bitacora(
                     idbitacora: idbitacoraController.text,
                     evento: eventoController.text,
                     fecha: fechaController.text,
                     fechaverificacion:fechaVerificacionController.text,
                     recursos: recursosController.text,
                     verifico: verificoController.text
                 );
                await addBitacora(argument,veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE INSERTO CON EXITO"))),
                        }
                    });
                idbitacoraController.clear();
                eventoController.clear();
                fechaController.clear();
                fechaVerificacionController.clear();
                recursosController.clear();
                verificoController.clear();
                Navigator.pop(context);
              },
              child: Text("Guardar"))
        ],
      ),
    );
  }
}
