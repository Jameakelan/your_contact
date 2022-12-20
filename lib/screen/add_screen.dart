import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mobile",
                  prefixIcon: Icon(Icons.phone)),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
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
