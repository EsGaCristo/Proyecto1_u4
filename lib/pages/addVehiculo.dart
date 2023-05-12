import 'package:dam_u4_proyecto1/modelos/vehiculo.dart';
import 'package:dam_u4_proyecto1/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddVehiculo extends StatefulWidget {
  const AddVehiculo({Key? key}) : super(key: key);

  @override
  State<AddVehiculo> createState() => _AddVehiculoState();
}

class _AddVehiculoState extends State<AddVehiculo> {
  var _selectedFuelType;

  var _selectedType;

  final departamentoController = TextEditingController();
  final SERIEController = TextEditingController();
  final placaController = TextEditingController();
  final responsableController = TextEditingController();
  final tanqueController = TextEditingController();
  final tipoController = TextEditingController();
  final trabajadorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Auto nuevo"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            //margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
              value: _selectedFuelType,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    'Seleccionar tipo de combustible',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                DropdownMenuItem(
                  child: Text('Magna'),
                  value: 'Magna',
                ),
                DropdownMenuItem(
                  child: Text('Premium'),
                  value: 'Premium',
                ),
                DropdownMenuItem(
                  child: Text('Diesel'),
                  value: 'Diesel',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFuelType = value;
                });
              },
              isExpanded: true,
              underline: SizedBox(),
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: departamentoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Departamento"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: SERIEController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "SERIE"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: placaController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "PLACA"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: responsableController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Responsable"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: tanqueController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Tanque"),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
              padding: EdgeInsets.all(5),
              value: _selectedType,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    'Seleccionar tipo de vehículo',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                DropdownMenuItem(
                  child: Text('Camion'),
                  value: 'Camion',
                ),
                DropdownMenuItem(
                  child: Text('Camioneta'),
                  value: 'Camioneta',
                ),
                DropdownMenuItem(
                  child: Text('SUV'),
                  value: 'SUV',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              isExpanded: true,
              underline: SizedBox(),
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: trabajadorController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Trabajador"),
          ),
          SizedBox(
            height: 10,
          ),
          FilledButton(
              onPressed: () async {
                Vehiculo veh = Vehiculo(
                    combustible: _selectedFuelType.toString(),
                    departamento: departamentoController.text,
                    serie: SERIEController.text,
                    placa: placaController.text,
                    responsable: responsableController.text,
                    tanque: double.parse(tanqueController.text),
                    tipo: _selectedType.toString(),
                    trabajador: trabajadorController.text);
                await addVehiculo(veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE INSERTO CON EXITO"))),
                        }
                    });
                departamentoController.clear();
                departamentoController.clear();
                SERIEController.clear();
                placaController.clear();
                responsableController.clear();
                tanqueController.clear();
                trabajadorController.clear();
                Navigator.pop(context);
              },
              child: Text("Guardar"))
        ],
      ),
    );
  }
}
