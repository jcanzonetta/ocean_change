class Observation {
  String name;
  List<Map<String, String>>? species;

  Observation({required this.name, this.species});

  factory Observation.fromFirestore(Map document) {
    List<Map<String, String>> speciesList = [];

    if (document['species'] != null) {
      for (final singleSpecies in document['species']) {
        final String name = singleSpecies['name'];
        final String imageUrl = singleSpecies['image_url'];
        speciesList.add({name: name, imageUrl: imageUrl});
      }
    }

    return Observation(name: document['name'], species: speciesList);
  }
}
