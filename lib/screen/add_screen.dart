import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textMobileController = TextEditingController();
  final TextEditingController _textEmailController = TextEditingController();

  bool _validateNameEmpty = false;
  bool _validateMobileEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.indigoAccent,
          ),
        ),
        title: const Center(
            child: Text(
          "Add Contact",
          style: TextStyle(fontSize: 20),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Name",
                errorText: (_validateNameEmpty) ? "Name can't be null" : null,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _textMobileController,
              decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Mobile",
                  errorText: (_validateMobileEmpty) ? "Mobile can't be null" : null,
                  prefixIcon: const Icon(Icons.phone)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _textEmailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _validateNameEmpty = _textNameController.text.isEmpty;
                  _validateMobileEmpty = _textMobileController.text.isEmpty;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent),
              child: const Text("Add Contact"),
            )
          ],
        ),
      ),
    );
  }
}
