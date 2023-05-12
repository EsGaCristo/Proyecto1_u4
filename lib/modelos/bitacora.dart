class Bitacora {
  String idbitacora;
  String evento;

  String fecha;

  String fechaverificacion;
  String recursos;

  String verifico;

  Bitacora(
      {required this.idbitacora,
      required this.evento,
      required this.fecha,
      required this.fechaverificacion,
      required this.recursos,
      required this.verifico});

  Map<String, dynamic> toMap() {
    return {
      'idbitacora':idbitacora,
      'evento': evento,
      'fecha': fecha,
      'fechaverificacion': fechaverificacion,
      'recursos': recursos,
      'verifico': verifico,
    };
  }
}
