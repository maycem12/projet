class Materiel {
  String id;
  String Nom;
  String Code_Etiquette;
  Materiel({this.id = '', required this.Nom, required this.Code_Etiquette});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Nom': Nom,
      'Code_Etiquette': Code_Etiquette,
    };
  }

  factory Materiel.fromJson(Map<String, dynamic> json) {
    return Materiel(
        id: json['id'],
        Nom: json['Nom'],
        Code_Etiquette: json['Code_Etiquette']);
  }
}
