import 'package:data_encryptor/encryptor_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encryption App',
      home: EncryptionPage(),
    );
  }
}

class EncryptionPage extends StatefulWidget {
  const EncryptionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EncryptionPageState createState() => _EncryptionPageState();
}

class _EncryptionPageState extends State<EncryptionPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController encryptedTextController = TextEditingController();
  TextEditingController decryptKeyController = TextEditingController();

  String encryptedText = '';
  String decryptedText = '';

  void encryptText() {
    final text = textController.text;
    final key = keyController.text;

    if (text.isEmpty || key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both text and key!")),
      );
      return;
    }

    setState(() {
      encryptedText = EncryptionMethod.encrypt(text, key);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Encrypted!"), duration: Duration(seconds: 2)),
    );
  }

  void decryptText() {
    final encrypted = encryptedTextController.text;
    final key = decryptKeyController.text;

    if (encrypted.isEmpty || key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both encrypted text and key!")),
      );
      return;
    }

    setState(() {
      decryptedText = EncryptionMethod.decrypt(encrypted, key);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Decrypted!"), duration: Duration(seconds: 2)),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard!"), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Encryption & Decryption")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text to Encrypt
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: "Enter text to encrypt"),
              ),
              SizedBox(height: 10),
              // Key for Encryption
              TextField(
                controller: keyController,
                decoration: InputDecoration(labelText: "Enter secret key"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: encryptText,
                child: Text("Encrypt"),
              ),
              SizedBox(height: 10),
              if (encryptedText.isNotEmpty) ...[
                SelectableText("Encrypted: $encryptedText", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => copyToClipboard(encryptedText),
                  child: Text("Copy Encrypted Text"),
                ),
              ],
              Divider(),
              // Text to Decrypt
              TextField(
                controller: encryptedTextController,
                decoration: InputDecoration(labelText: "Enter encrypted text"),
              ),
              SizedBox(height: 10),
              // Key for Decryption
              TextField(
                controller: decryptKeyController,
                decoration: InputDecoration(labelText: "Enter secret key"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: decryptText,
                child: Text("Decrypt"),
              ),
              SizedBox(height: 10),
              if (decryptedText.isNotEmpty) ...[
                SelectableText("Decrypted: $decryptedText", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => copyToClipboard(decryptedText),
                  child: Text("Copy Decrypted Text"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}