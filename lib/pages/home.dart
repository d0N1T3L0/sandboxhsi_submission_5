import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandboxhsi_sesi_5/models/siswa_model.dart';
import 'package:sandboxhsi_sesi_5/pages/form_tambah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> siswaList = [];
  List<SiswaModel> siswaList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // pakai try catch load data json
    try {
      // load data awal dari json
      final dataSiswa = await rootBundle.loadString('assets/siswa.json');

      // decode Json to Dynamic
      final items = List.from(jsonDecode(dataSiswa));
      // final data = jsonDecode(dataSiswa);
      setState(() {
        // menampilkan data siswa dari model
        siswaList = items.map((e) => SiswaModel.fromJson(e)).toList();

        // menampilkan data siswa json
        // siswaList = List.from(data);
      });
    } catch(e) {
      // show error load data dalam snackbar
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memuat data siswa: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _tambahSiswa(String nama, int umur) {
    setState(() {
      // tambah data 
      // siswaList.add(nama);

      // tambah data dg model
      siswaList.add(SiswaModel(name: nama, age: umur));
    });
  }

  // menampilan form tambah data siswa
  void _bukaFormTambah() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormTambahSiswa(onSubmit: _tambahSiswa),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Siswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      
      // menampilkan data siswa
      body: ListView.builder(
        itemCount: siswaList.length,
        itemBuilder: (context, index) {
          final data = siswaList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            // data dari List
            // title: Text(data),

            // data dari Model
            title: Text(
              '${data.name} (${data.age} th)', 
              // style: TextStyle(backgroundColor: Colors.amberAccent),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}
