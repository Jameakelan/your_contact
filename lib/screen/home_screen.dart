import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_friends/components/contact_item.dart';
import 'package:your_friends/db_helper/database_helper.dart';
import 'package:your_friends/model/contact_model.dart';
import 'package:your_friends/screen/add_screen.dart';
import 'package:your_friends/screen/contact_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _helper = DatabaseHelper();

  List<ContactModel> contactsModel = [];

  late Future<List<ContactModel>> dataContacts;

  void deleteContact(int id) async {
    int effectRow = await _helper.delete(id);

    if (effectRow > 0) {
      refreshContact();
    }
  }

  Future<void> refreshContact() async {
    setState(() {
      dataContacts = getContactsList();
    });
  }

  Future<List<ContactModel>> getContactsList() async {
    return await _helper.getContacts();
  }

  @override
  void initState() {
    super.initState();
    refreshContact();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Contacts",
                      style: TextStyle(fontSize: 25),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        bool? isBack = await Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                                builder: (context) => const AddScreen()));

                        if (isBack != null) {
                          refreshContact();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: dataContacts,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ContactModel>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Got an Error");
                      }

                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 8, right: 8, bottom: 4),
                              child: ContactItem(
                                title:
                                    snapshot.data?[index].name ?? "ไม่พบข้อมูล",
                                onPressed: () async {
                                  var contactModel = snapshot.data![index];

                                  bool? isBack = await Navigator.push(
                                    context,
                                    MaterialPageRoute<bool>(
                                      builder: (context) => ContactDetailScreen(
                                        contactModel: contactModel,
                                      ),
                                    ),
                                  );

                                  if (isBack != null) {
                                    refreshContact();
                                  }
                                },
                                onDelete: () {
                                  int? id = snapshot.data?[index].id;

                                  if (id != null) {
                                    deleteContact(id);
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }

                      return const Text("Loading data...");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
