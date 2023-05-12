import 'package:dam_u4_proyecto1/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Programa extends StatefulWidget {
  const Programa({Key? key}) : super(key: key);

  @override
  State<Programa> createState() => _ProgramaState();
}

class _ProgramaState extends State<Programa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autos Ittepic"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
          future: getVehiculo(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text("ATENCION"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Navigator.pushNamed(
                                          context, '/update',
                                          arguments: snapshot.data?[index]);
                                      setState(() {});
                                    },
                                    child: Text("ACTUALIZAR")),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Navigator.pushNamed(
                                          context, '/bitacora',
                                          arguments: snapshot.data?[index]
                                              ['id']);
                                      setState(() {});
                                    },
                                    child: Text("BITACORAS")),
                                TextButton(
                                    onPressed: () {
                                      //print(snapshot.data?[index]['id']);
                                      deleteVehiculo(snapshot.data![index]['id'].toString())
                                          .then((value) => {
                                                if (value > 0){
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Se elimino exitosamente")))
                                                  }
                                              });
                                      setState(() {

                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("ELIMINAR")),
                              ],
                            );
                          });
                    },
                    child: ExpansionTile(
                      title: Text(snapshot.data?[index]['placa']),
                      subtitle: Text(snapshot.data?[index]['trabajador']),
                      trailing: Text(snapshot.data?[index]['tipo']),
                      leading: Text(snapshot.data?[index]['combustible']),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Departamento: " +
                                  snapshot.data?[index]['depto']),
                              Text("Numero de serie: " +
                                  snapshot.data?[index]['numeroserie']),
                              Text("Resguardado por: " +
                                  snapshot.data?[index]['resguardadopor']),
                              Text("Capacidad del tanque" +
                                  snapshot.data![index]['tanque'].toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  return Text(snapshot.data?[index]['placa']);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
