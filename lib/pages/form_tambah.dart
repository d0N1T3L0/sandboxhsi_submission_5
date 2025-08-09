
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class FormTambahSiswa extends StatefulWidget {
  final Function(String, int) onSubmit;

  const FormTambahSiswa({super.key, required this.onSubmit});

  @override
  State<FormTambahSiswa> createState() => _FormTambahSiswaState();
}

class _FormTambahSiswaState extends State<FormTambahSiswa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  // final TextEditingController _umurController = TextEditingController();
  double umur=0;
  String? umurError; 

  // simpan data
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_namaController.text, umur.toInt());
      
      // Tampilkan pop-up berhasil simpan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 50), //icon centang
              SizedBox(width: 10),
              Text('Sukses'),
            ],
          ),
          content: const Text('Data siswa berhasil disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.pop(context); // kembali ke halaman utama
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Tambah Data Siswa', 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // kolom input nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama', //label field nama
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) { //validasi field nama wajib diisi
                    return 'Nama tidak boleh kosong';
                  }
                  if (value.trim().length < 3) { //validasi isian nama min 3 karakter
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), //jarak antar kolom
              // kolom input umur
              SpinBox(
                min: 0,
                max: 100,
                value: 0,
                decoration: const InputDecoration(
                  labelText: 'Umur',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    umur = value;
                  });
                }
                // => umur = value,
              ),
              if (umurError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 12),
                  child: Text(
                    umurError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 20), //jarak tombol dengan field
              ElevatedButton.icon(  //tombol simpan dengan icon
                //tanpa spinbox
                // onPressed: _submitForm, 
                
                // dengan spinbox
                onPressed: (){
                  setState(() {
                    umurError = (umur < 15) ? 'Umur minimal 15 tahun' : null;
                  });
                  if (_formKey.currentState!.validate() && umurError == null) {
                    _submitForm();
                  }
                },
                label: const Text('Simpan'), //text simpan
                icon: const Icon(Icons.save) //icon save
              )
            ],
          ),
        ),
      ),
    );
  }
}
