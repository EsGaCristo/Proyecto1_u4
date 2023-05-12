import 'package:dam_u4_proyecto1/modelos/bitacora.dart';
import 'package:dam_u4_proyecto1/modelos/vehiculo.dart';
import 'package:dam_u4_proyecto1/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateBitacora extends StatefulWidget {
  const UpdateBitacora({Key? key}) : super(key: key);

  @override
  State<UpdateBitacora> createState() => _UpdateBitacoraState();
}

class _UpdateBitacoraState extends State<UpdateBitacora> {
  final fechaVerificacionController = TextEditingController();
  final verificoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final arg1 = arguments['arg1'];
    final arg2 = arguments['arg2'];


    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Bitacora"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: fechaVerificacionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Fecha de Verificacion",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              FocusScope.of(context)
                  .requestFocus(FocusNode()); // Quita el foco del teclado
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                fechaVerificacionController.text =
                    DateFormat('dd/MM/yyyy').format(selectedDate);
              }
            },
            readOnly: true, // Evita que el usuario escriba la fecha manualmente
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: verificoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Verifico"),
          ),
          SizedBox(
            height: 10,
          ),
          FilledButton(
              //actualizar
              onPressed: () async {
                Bitacora veh = Bitacora(
                    idbitacora: arg1['idbitacora'].toString(),
                    evento: arg1['evento'],
                    fecha: arg1['fecha'],
                    fechaverificacion: fechaVerificacionController.text,
                    recursos: arg1['recursos'],
                    verifico: verificoController.text
                );

                await updateBitacora(arg2,veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE ACTUALIZO CON EXITO"))),
                        }
                    });

                Navigator.pop(context);
              },
              child: Text("Actualizar"))
        ],
      ),
    );
  }
}
