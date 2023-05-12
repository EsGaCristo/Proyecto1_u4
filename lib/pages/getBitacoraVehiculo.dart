import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class GetBitacoraVehiculo extends StatefulWidget {
  const GetBitacoraVehiculo({Key? key}) : super(key: key);

  @override
  State<GetBitacoraVehiculo> createState() => _GetBitacoraVehiculoState();
}

class _GetBitacoraVehiculoState extends State<GetBitacoraVehiculo> {
  @override
  Widget build(BuildContext context) {
    final String argument = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bitacoras "),
      ),
      body: FutureBuilder(
          future: getBitacoraVehiculos(argument),
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
                                          context, '/updateBitacora',
                                          arguments: {
                                            'arg1': snapshot.data?[index],
                                            'arg2': argument,
                                          });
                                      setState(() {});
                                    },
                                    child: Text("ACTUALIZAR")),
                              ],
                            );
                          });

                    },
                    child: ExpansionTile(
                      title: Text(snapshot.data?[index]['fecha']),
                      subtitle: Text(snapshot.data?[index]['fechaverificacion']),
                      trailing: Text(snapshot.data?[index]['recursos']),
                      leading: Text(snapshot.data?[index]['verifico']),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Evento: " + snapshot.data?[index]['evento']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  //return Text(snapshot.data?[index]['placa']);
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
          await Navigator.pushNamed(context, '/addBitacora',arguments: argument);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
