import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/minuman.dart';

class KelolaMinumanScreen extends StatefulWidget {
  const KelolaMinumanScreen({super.key});

  @override
  State<KelolaMinumanScreen> createState() => _KelolaMinumanScreenState();
}

class _KelolaMinumanScreenState extends State<KelolaMinumanScreen> {
  List<Minuman> _minumanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMinuman();
  }

  Future<void> _fetchMinuman() async {
    setState(() => _isLoading = true);
    final data = await ApiService.getAllMinuman();
    setState(() {
      _minumanList = data;
      _isLoading = false;
    });
  }

  void _showEditDialog(Minuman minuman) {
    final TextEditingController namaCtrl = TextEditingController(text: minuman.nama);
    final TextEditingController hargaCtrl = TextEditingController(text: minuman.harga.toString());
    final TextEditingController deskripsiCtrl = TextEditingController(text: minuman.deskripsi);
    final TextEditingController jenisCtrl = TextEditingController(text: minuman.jenis);
    final TextEditingController gambarCtrl = TextEditingController(text: minuman.gambar);
    bool isSaving = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F2937),
            title: Text('Edit Minuman', style: GoogleFonts.poppins(color: Colors.white)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Nama Minuman', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: hargaCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Harga', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: deskripsiCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Deskripsi', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: jenisCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Jenis (Kopi/Non-Kopi)', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: gambarCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'URL Gambar', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSaving ? null : () => Navigator.pop(ctx),
                child: Text('Batal', style: GoogleFonts.poppins(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFBBF24)),
                onPressed: isSaving ? null : () async {
                  setDialogState(() => isSaving = true);
                  final harga = int.tryParse(hargaCtrl.text) ?? 0;
                  final res = await ApiService.updateMinuman(
                    minuman.id ?? 0,
                    namaCtrl.text,
                    harga,
                    deskripsiCtrl.text,
                    jenisCtrl.text,
                    gambarCtrl.text,
                  );
                  setDialogState(() => isSaving = false);
                  Navigator.pop(ctx);
                  if (res['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.green));
                    _fetchMinuman();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.red));
                  }
                },
                child: isSaving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                    : const Text('Update', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteDialog(Minuman minuman) {
    bool isDeleting = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F2937),
            title: Text('Hapus Minuman?', style: GoogleFonts.poppins(color: Colors.white)),
            content: Text('Yakin ingin menghapus ${minuman.nama}?', style: const TextStyle(color: Colors.grey)),
            actions: [
              TextButton(
                onPressed: isDeleting ? null : () => Navigator.pop(ctx),
                child: Text('Batal', style: GoogleFonts.poppins(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
                onPressed: isDeleting ? null : () async {
                  setDialogState(() => isDeleting = true);
                  final res = await ApiService.deleteMinuman(minuman.id ?? 0);
                  setDialogState(() => isDeleting = false);
                  Navigator.pop(ctx);
                  if (res['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.green));
                    _fetchMinuman();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.red));
                  }
                },
                child: isDeleting
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Hapus', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Kelola Minuman', style: GoogleFonts.poppins(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : _minumanList.isEmpty
              ? const Center(child: Text('Belum ada minuman', style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _minumanList.length,
                  itemBuilder: (context, index) {
                    final minuman = _minumanList[index];
                    return Card(
                      color: const Color(0xFF1F2937),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage: minuman.gambar.isNotEmpty
                              ? NetworkImage(minuman.gambar)
                              : null,
                          child: minuman.gambar.isEmpty
                              ? const Icon(Icons.local_cafe, color: Colors.white)
                              : null,
                        ),
                        title: Text(minuman.nama.isEmpty ? 'Tanpa Nama' : minuman.nama, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Rp ${minuman.harga}', style: const TextStyle(color: Colors.greenAccent)),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                onPressed: () => _showEditDialog(minuman),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => _showDeleteDialog(minuman),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
