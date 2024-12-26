import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:tugas_uas/models/book.dart';

class BookData extends ChangeNotifier {
  List<Book> _bookItems = [];

  List<Book> get bookItems => _bookItems;

  Future<void> fetchBooks() async {
    final database = FirebaseDatabase.instance.ref('books'); // Correct reference
    final DatabaseEvent event = await database.once(); // Await the call

    // Access the snapshot from the DatabaseEvent
    final DataSnapshot booksSnapshot = event.snapshot;

    if (booksSnapshot.exists) {
      // Check if the snapshot value is a Map
      if (booksSnapshot.value is Map) {
        final books = booksSnapshot.value as Map<dynamic, dynamic>;
        final List<Book> bookList = [];

        books.forEach((bookId, bookData) {
          bookList.add(Book.fromJson(bookData, bookId));
        });

        _bookItems = bookList; // Update the book items
      } 
      // Handle the case where the snapshot value is a List
      else if (booksSnapshot.value is List) {
        final List<Book> bookList = [];
        final List<dynamic> items = booksSnapshot.value as List<dynamic>;

        for (var item in items) {
          // Assuming each item in the list is a Map and has an ID
          // You may need to adjust this based on your actual data structure
          if (item is Map) {
            bookList.add(Book.fromJson(item, 'generated_id')); // Replace 'generated_id' with actual ID logic
          }
        }
        _bookItems = bookList; // Update the book items
      } else {
        print('Kesalahan terjadi pada ${booksSnapshot.value.runtimeType}');
      }
      
      notifyListeners(); // Notify listeners about the change
    } else {
      print('Buku Masih Kosong !!!');
      _bookItems = []; // Optionally set to an empty list
      notifyListeners(); // Notify listeners even if no books are found
    }
  }
}