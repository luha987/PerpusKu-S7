import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Anggota extends StatefulWidget {
  const Anggota({super.key});

  @override
  State<Anggota> createState() => _AnggotaState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('users').get();
  return querySnapshot;
}
void processData(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  for (var doc in querySnapshot.docs) {
    print(doc.data());
  }
}

class _AnggotaState extends State<Anggota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Anggota",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: getCollectionData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data()!;
                return ListTile(
                  leading: const Icon(Icons.person_outline), 
                  title: Text(
                    data["username"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  // subtitle: Text(data["password"]),
                );
              },
            );
          } else {
            return const Text("Tidak ada data");
          }
        },
      ),
    );
  }
}