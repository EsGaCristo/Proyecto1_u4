import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1/modelos/bitacora.dart';
import 'package:dam_u4_proyecto1/modelos/vehiculo.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/*** Obtencion de vehiculos ***/

Future<List> getVehiculo() async {
  List vehiculos = [];
  try{
    CollectionReference collectionReferenceVehiculo = db.collection('vehiculo');
    QuerySnapshot queryVehiculo = await collectionReferenceVehiculo.get();
    queryVehiculo.docs.forEach((document) {
      Map<String, dynamic>? vehiculoData =
      document.data() as Map<String, dynamic>?;
      vehiculoData?['id'] = document.id; // agregar el ID al mapa de datos
      vehiculos.add(vehiculoData);
    });
  }catch(e){

  }
  await Future.delayed(const Duration(seconds: 1));
  return vehiculos;
}//Fin del retorno de vehiculos

/*** Agregar Vehiculos ***/
Future<int> addVehiculo(Vehiculo vehiculo) async {
  try {
    await db.collection("vehiculo").add(vehiculo.toMap());
    return 1; // se realizó la inserción exitosamente
  } catch (e) {
    print('Error al agregar vehículo: $e');
    return -1; // ocurrió un error al insertar
  }
}
/*** Actualizar vahiculos ***/

Future<int> updateVehiculo(String uid,Vehiculo vehiculo) async {
  try {
    await db.collection("vehiculo").doc(uid).set(vehiculo.toMap());
    return 1;
  } catch (e) {
    print('Error al agregar vehículo: $e');
    return -1; // ocurrió un error al insertar
  }
}
/*** Eliminar Vehiculos ***/
Future<int> deleteVehiculo(String uid) async {
  try {
    await db.collection("vehiculo").doc(uid).delete();
    return 1; // se eliminó el vehículo exitosamente
  } catch (e) {
    print('Error al eliminar vehículo: $e');
    return -1; // ocurrió un error al eliminar
  }
}

/*** Obtencion de bitacoras ***/
Future<List> getBitacoraVehiculos(String uid) async {
  List bitacoras = [];
  DocumentSnapshot vehiculoBitacoraSnapshot = await db.collection('vehiculo').doc(uid).get();
  Map<String,dynamic>? vehiculoBitacora = vehiculoBitacoraSnapshot.data() as Map<String,dynamic>?;
  if(vehiculoBitacora != null && vehiculoBitacora.containsKey('Bitacora')){
    bitacoras = List<Map<String,dynamic>>.from(vehiculoBitacora['Bitacora']);
  }
  await Future.delayed(const Duration(seconds: 1));
  return bitacoras;
}
/*** Agregar Bitacoras ***/
Future<int> addBitacora(String uid,Bitacora bitacora) async {
  try {
    await db.collection("vehiculo").doc(uid).update({
      'Bitacora':FieldValue.arrayUnion([bitacora.toMap()]),
    });
    return 1; // se realizó la inserción exitosamente
  } catch (e) {
    print('Error al agregar bitacora: $e');
    return -1; // ocurrió un error al insertar
  }
}

/*** Actualizar vahiculos ***/

Future<int> updateBitacora(String uid,Bitacora bitacora) async {
  try {
    await db.collection('vehiculo').doc(uid).set({
      'Bitacora':FieldValue.arrayRemove([
        bitacora.toMap()
      ].cast<Map<String,dynamic>>())
    });
    await db.collection("vehiculo").doc(uid).set({
      'Bitacora':FieldValue.arrayUnion([bitacora.toMap()])
    });
    return 1;
  } catch (e) {
    print('Error al agregar vehículo: $e');
    return -1; // ocurrió un error al insertar
  }
}
