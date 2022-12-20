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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddScreen()));
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
                    future: _helper.getContacts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ContactModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {


                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 8, right: 8, bottom: 4),
                              child: ContactItem(
                                title: snapshot.data?[index].name ?? "ไม่พบข้อมูล",
                                onPressed: () {
                                  // var contactModel = ContactModel(
                                  //     name: "SUT",
                                  //     mobileNo: "0938573643",
                                  //     email: 'example@gmail.com',
                                  //     isFavorite: 0);

                                  if (snapshot.data != null) {
                                    var contactModel = snapshot.data![index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ContactDetail(
                                          contactModel: contactModel,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                onDelete: () {},
                              ),
                            );
                          },
                        );
                      }

                      return Container();
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
