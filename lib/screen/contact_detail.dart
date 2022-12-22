import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:your_friends/db_helper/database_helper.dart';
import 'package:your_friends/model/contact_model.dart';
import 'package:your_friends/screen/edit_screen.dart';

class ContactDetail extends StatefulWidget {

  ContactModel contactModel;

  ContactDetail({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  late int _isFavorite;

  final DatabaseHelper _helper = DatabaseHelper();

  void updateFavorite(ContactModel model) {
    int? id = model.id;

    if (id != null) {
      _helper.updateFavorite(id, _isFavorite);
    }
  }

  void refreshContactDetail() async {
    var id = widget.contactModel.id;
    if (id != null) {
      var contact = await _helper.getContactById(id);
      if (contact != null) {
        setState(() {
          widget.contactModel = contact;
        });
      }
    }
  }

  void launchCallsIntent(String mobileNo) async {
    var url = Uri.parse("tel:$mobileNo");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchSMSIntent(String mobileNo) async {
    var url = Uri.parse('sms:$mobileNo');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.contactModel.favorite;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.indigoAccent,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              bool? isBack = await Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                      builder: (context) => EditScreen(
                            contact: widget.contactModel,
                          )));

              if (isBack != null) {
                refreshContactDetail();
              }

              // if (contactModel != null) {
              //   widget.contactModel = contactModel;
              // }
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.indigoAccent),
            ),
          )
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.contactModel.name,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              // Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.message),
                          onPressed: () async {
                            launchSMSIntent(widget.contactModel.mobileNo);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.call),
                          onPressed: () async {
                            launchCallsIntent(widget.contactModel.mobileNo);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color:
                                (_isFavorite == 1) ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            _isFavorite = (_isFavorite == 0) ? 1 : 0;
                            updateFavorite(widget.contactModel);
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Divider(thickness: 2,),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("mobile"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.contactModel.mobileNo,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("e-mail"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.contactModel.email,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
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
