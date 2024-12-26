class Book {
  final String id;
  final String judul;
  final String description;
  final String penulis;
  final double jmlHal;
  final String categorie;
  final String penerbit;
  final String img;

  // Constructor
  Book({
    required this.id,
    required this.judul,
    required this.description,
    required this.penulis,
    required this.jmlHal,
    required this.categorie,
    required this.penerbit,
    required this.img,
  });

  // Factory method to create a Book instance from JSON
  factory Book.fromJson(Map<dynamic, dynamic> json, String id) {
    // Ensure that the required fields are present and handle potential null values
    return Book(
      id: id,
      judul: json['judul'] ?? 'Unknown Title', // Default value if null
      description: json['description'] ?? 'No Description', // Default value if null
      penulis: json['penulis'] ?? 'Unknown Author', // Default value if null
      jmlHal: (json['jmlHal'] is num) ? json['jmlHal'].toDouble() : 0.0, // Default to 0.0 if not a number
      categorie: json['categorie'] ?? 'Uncategorized', // Default value if null
      penerbit: json['penerbit'] ?? 'Unknown Publisher', // Default value if null
      img: json['img'] ?? '', // Default to empty string if null
    );
  }
}
