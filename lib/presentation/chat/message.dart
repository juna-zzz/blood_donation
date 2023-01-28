import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Message extends StatefulWidget {
  String email;
  Message({super.key, required this.email});
  @override
  _MessageState createState() => _MessageState(email: email);
}

class _MessageState extends State<Message> {
  String email;
  _MessageState({required this.email});

  final Stream<QuerySnapshot> _Messagetream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _Messagetream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();

            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onLongPress: () {
                      launchUrl(Uri.parse('mailto:$email'));
                    },
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.purple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          qs['email'],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                qs['message'],
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              "${d.hour}:${d.minute}",
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
