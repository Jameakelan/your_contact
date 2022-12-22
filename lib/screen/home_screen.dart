import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_friends/components/contact_item.dart';
import 'package:your_friends/db_helper/database_helper.dart';
import 'package:your_friends/model/contact_model.dart';
import 'package:your_friends/screen/add_screen.dart';
import 'package:your_friends/screen/contact_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _helper = DatabaseHelper();

  List<ContactModel> contactsModel = [];

  void deleteContact(int id) async {

    int effectRow = await _helper.delete(id);

    if(effectRow > 0) {
      refreshContact();
    }
  }

  void refreshContact() async {
    contactsModel = await _helper.getContacts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshContact();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                  child: ListView.builder(
                    itemCount: contactsModel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 8, right: 8, bottom: 4),
                        child: ContactItem(
                          title: contactsModel[index].name ?? "ไม่พบข้อมูล",
                          onPressed: () async {
                            var contactModel = contactsModel[index];
                           bool? isBack = await Navigator.push(
                              context,
                              MaterialPageRoute<bool>(
                                builder: (context) => ContactDetail(
                                  contactModel: contactModel,
                                ),
                              ),
                            );

                            if (isBack != null) {
                              refreshContact();
                            }
                          },
                          onDelete: () {
                            int? id = contactsModel[index].id;

                            print("id: ${id}");

                            if (id != null) {
                              deleteContact(id);
                            }
                          },
                        ),
                      );
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
