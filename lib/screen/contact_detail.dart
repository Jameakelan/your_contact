import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:your_friends/model/contact_model.dart';

class ContactDetail extends StatefulWidget {
  final ContactModel contactModel;

  const ContactDetail({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.contactModel.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        actions: [
          TextButton(
            onPressed: () {},
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
                            String phoneNumber = '1234567890';
                            String message = 'Hello, this is a test message.';

                            String url = 'sms:$phoneNumber?body=$message';

                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not send SMS';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.call),
                          onPressed: () async {
                            String phoneNumber = '1234567890';

                            String url = 'tel:$phoneNumber';

                            if (await canLaunch(url)) {
                              await launch("tel://214324234");
                            } else {
                              throw 'Could not call phone';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: (_isFavorite) ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
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
