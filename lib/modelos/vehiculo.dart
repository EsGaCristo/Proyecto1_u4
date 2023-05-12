class Vehiculo{
  String combustible;
  String departamento;
  String serie;
  String placa;
  String responsable;
  double tanque;
  String tipo;
  String trabajador;


  Vehiculo({
    required this.combustible,
    required this.departamento,
    required this.serie,
    required this.placa,
    required this.responsable,
    required this.tanque,
    required this.tipo,
    required this.trabajador
  });


  Map<String ,dynamic> toMap(){
    return{
      'combustible':combustible,
      'depto': departamento,
      'numeroserie': serie,
      'placa': placa,
      'resguardadopor': responsable,
      'tanque' : tanque,
      'tipo':tipo,
      'trabajador': trabajador
    };
  }
}