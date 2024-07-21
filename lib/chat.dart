import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:jobapp/controller/ChatNotfier.dart';
import 'package:jobapp/message.dart';
import 'package:jobapp/model/response/getChat.dart';

import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: Consumer<Chatnotfier>(
        builder: (context, chatnotifier, child) {
          chatnotifier.getChats();
          chatnotifier.getPrefs();

          print(chatnotifier.userId);
          return FutureBuilder<List<Getchat>>(
            future: chatnotifier.chatsList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
                return Text("Error: ${snapshot.error}");
              } else {
                var chats = snapshot.data;

                return ListView.builder(
                  itemCount: chats!.length,
                  itemBuilder: (context, index) {
                    var chat = chats[index];
                    var user = chat.users
                        .firstWhere((user) => user.id != chatnotifier.userId);
                  
                    return GestureDetector(
                      onTap: () {
  // Pass the correct user ID to the Message widget
  Get.to(() => Message(
    id: chat.id,
    username: user.username,
    profile: user.profile,
    user: [chat.users[0].id, chat.users[1].id],
  ));
},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(user.profile),
                          ),
                          title: Text(user.username),
                          subtitle: Text(chat.latestMessage.content),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(chatnotifier
                                  .msgTime(chat.updatedAt.toString())),


Icon(
                                chat.chatname == chatnotifier.userId
                                    ? Icons.arrow_forward_outlined
                                    : Icons.arrow_back_outlined,
                              ),




                              
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
