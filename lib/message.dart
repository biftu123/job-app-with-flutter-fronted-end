import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:jobapp/controller/ChatNotfier.dart';
import 'package:jobapp/messageTextField.dart';
import 'package:jobapp/model/request/requstForSendMessege.dart';
import 'package:jobapp/model/response/RecivedMessage.dart';
import 'package:jobapp/service/helper/MessageHelper.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Message extends StatefulWidget {
  const Message({
    Key? key,
    required this.id,
    required this.username,
    required this.profile,
    required this.user,
  }) : super(key: key);

  final String id;
  final String username;
  final String profile;
  final List<String> user;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late IO.Socket socket;
    List<RecivedMessage> messages = [];
  TextEditingController messagecontroller = TextEditingController();
  String reciver = '';
  final ScrollController _scrollController = ScrollController();
  late Future<List<RecivedMessage>> messageList;
  int offset = 1;
  @override
  void initState() {
    super.initState();
    // Retrieve the Chatnotfier instance using Provider.of and listen to changes
    Provider.of<Chatnotfier>(context, listen: false).getPrefs();
    getmessage(offset);
    connect();
    joinchat();
    handlenext();
  }

  void getmessage(int offset) async {
    messageList = MessageHelper.getMessage(widget.id, offset);
  }

  void handlenext() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
           if(messages.length == 12) {
            getmessage(offset++);
          setState(() {});
           }  
          
        }
      }
    });
  }

  void sendMessage(String chatId, String content, String receiver) {
    RequestForSendMessege model = RequestForSendMessege(
        chatId: chatId, content: content, receiver: receiver);
    MessageHelper.applychat(model).then((response) {
      var emmission = response[2];
      socket.emit('new messsage', emmission);
      sendstoptypingstatus(widget.id);
      setState(() {
        messagecontroller.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void connect() {
    var chatnotifier = Provider.of<Chatnotfier>(context, listen: false);
    socket = IO.io("http://192.168.100.4:3001", <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false
    });
    socket.emit("setup", chatnotifier.userId);
    socket.connect();
    socket.onConnect((_) {
      print('connected on front end');
    });
    socket.on("online_user", (userId) {
      chatnotifier.onlineuser
          .replaceRange(0, chatnotifier.onlineuser.length, userId);
    });
    socket.on("typing", (status) {
      chatnotifier.typingStatus = false;
    });
    socket.on("stoping", (status) {
      chatnotifier.typingStatus = true;
    });
    socket.on('new messsage', (newMessageRecieved) {
      sendstoptypingstatus(widget.id);
      RecivedMessage recivedMessage =
          RecivedMessage.fromJson(newMessageRecieved);
      if (recivedMessage.sender.id == chatnotifier.userId) {
        messages.insert(0, recivedMessage);
      }
    });
  }

  void sendtypingstatus(String status) {
    socket.emit("typing", status);
  }

  void sendstoptypingstatus(String status) {
    socket.emit("stop", status);
  }

  void joinchat() {
    socket.emit("join_chat", widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatnotfier>(
      builder: (context, chatnotifier, child) {
        reciver = widget.user.firstWhere((id) => id != chatnotifier.userId);
        return Scaffold(
          appBar: AppBar(
            title: !chatnotifier.onlineuser.contains(reciver)
                ? Text(widget.username)
                : Text("typing ..."),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.profile),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 25,
                      child: CircleAvatar(
                          radius: 5,
                          backgroundColor:
                              chatnotifier.onlineuser.contains(reciver)
                                  ? Color.fromARGB(255, 23, 255, 33)
                                  : Color.fromARGB(255, 227, 231, 233)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<RecivedMessage>>(
                  future: messageList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(child: Text('No messages'));
                    } else {
                      final messageList = snapshot.data!;
                      messages = messages + messageList;
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          RecivedMessage message = messages[index];
                          bool isCurrentUser =
                              message.sender.id == chatnotifier.userId;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Text(chatnotifier.msgTime(
                                    message.chat.updatedAt.toString())),
                                ChatBubble(
                                  
                                  clipper: ChatBubbleClipper10(
                                    type: isCurrentUser
                                        ? BubbleType.sendBubble
                                        : BubbleType.receiverBubble,
                                  ),
                                  alignment: isCurrentUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  backGroundColor: isCurrentUser
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: Text(
                                      message.content,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Messagetextfield(
                    message: messagecontroller,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        String msg = messagecontroller.text;
                        sendMessage(widget.id, msg, reciver);
                      },
                      child: Icon(Icons.send),
                    ),
                    onSubmitted: (_) {
                      String msg = messagecontroller.text;
                      sendMessage(widget.id, msg, reciver);
                    },
                    onChanged: (_) {
                      sendtypingstatus(widget.id);
                    },
                    onEditingComplete: () {
                      String msg = messagecontroller.text;
                      sendMessage(widget.id, msg, reciver);
                    },
                    onTapOutside: (PointerDownEvent) {
                      sendstoptypingstatus(widget.id);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
