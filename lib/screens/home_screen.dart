import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/models/data_book.dart';
import 'package:tugas_uas/screens/book_details_screen.dart';
import 'package:tugas_uas/screens/note_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchBooksFuture;

  @override
  void initState() {
    super.initState();
    final bookData = Provider.of<BookData>(context, listen: false);
    _fetchBooksFuture = bookData.fetchBooks(); // Fetch books once during initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft, // Mengatur agar teks berada di tengah
          child: const Text(
            'Daftar Buku',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => Anggota()));
            },
            icon: const Icon(Icons.supervisor_account_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchBooksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Consumer<BookData>(
                builder: (context, bookData, child) {
                  return ListView.builder( 
                    itemCount: bookData.bookItems.length,
                    itemBuilder: (context, index) {
                      final book = bookData.bookItems[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: Image.network(
                          book.img,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          book.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.indigo[900]
                          ),
                        ), // Display book title instead of id
                        subtitle: Text(
                          'Penulis : ${book.penulis} \nKategori : ${book.categorie}'
                        ),

                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookDetailsScreen(book: book),
                            ),
                          );
                        },
                        textColor: Colors.blueGrey,
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}