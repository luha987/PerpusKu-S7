import 'package:flutter/material.dart';
import 'package:tugas_uas/models/book.dart'; // Ensure you import your Book model

class BookDetailsScreen extends StatelessWidget {
  final Book book; // Add a field to hold the book object

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key); // Update the constructor

  static const routeName = '/book-details-screen';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(book.judul), centerTitle: true);
    final scale = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Image.network(
              book.img,
              fit: BoxFit.cover,
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.5,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(-4, -4), blurRadius: 4),
                  BoxShadow(color: Colors.grey.withOpacity(0.6), offset: const Offset(4, 4), blurRadius: 4),
                ],
              ),
              child: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.judul,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.indigo[900]
                          ),
                          textScaleFactor: 0.7,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Deskripsi Buku \n----------------------------------------------------------------',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w800, 
                      color: Colors.black),
                    textScaleFactor: 0.7,
                  ),
                  Text(
                    'Penulis : ${book.penulis}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.black87),
                    textScaleFactor: 0.7,
                  ),
                  Text(
                    'Halaman : ${book.jmlHal}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.black87),
                    textScaleFactor: 0.7,
                  ),
                  Text(
                    'Kategori  : ${book.categorie}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.black87),
                    textScaleFactor: 0.7,
                  ),
                  Text(
                    'Penerbit  : ${book.penerbit}\n',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.black87),
                    textScaleFactor: 0.7,
                  ),
                  Text(
                    'Abstrak : \n${book.description}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600,
                      color: Colors.black87
                    ),
                    textScaleFactor: 0.8,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height < 550 ? 15 : 30),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        // Add your onPressed functionality here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Berhasil Meminjam Buku Berjudul ${book.judul}')),
                        );
                      },
                      child: const Text(
                        'Pinjam',
                        style: TextStyle(
                          fontSize: 20, 
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}