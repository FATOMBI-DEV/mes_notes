class Note {
  int? id;
  String titre;
  String contenu;
  String dateCreation;
  String dateModification;
  int userId;

  Note({
    this.id,
    required this.titre,
    required this.contenu,
    required this.dateCreation,
    required this.dateModification,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'contenu': contenu,
      'dateCreation': dateCreation,
      'dateModification': dateModification,
      'userId': userId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      titre: map['titre'],
      contenu: map['contenu'],
      dateCreation: map['dateCreation'],
      dateModification: map['dateModification'],
      userId: map['userId'],
    );
  }
}