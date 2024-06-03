import 'package:flutter/material.dart';
import 'package:hhe/api/stream_api.dart';
import 'package:hhe/config.dart';
import 'package:hhe/screen/channels_list_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future main() async {
  final client = StreamChatClient(Config.apiKey, logLevel: Level.SEVERE);

  await StreamApi.initUser(
    client,
    username: 'Emily',
    urlImage:
        'https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png',
    id: Config.idEmily,
    token: Config.tokenEmily,
  );

  // await StreamApi.initUser(
  //   client,
  //   username: 'Peter',
  //   urlImage:
  //       'https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg',
  //   id: Config.idPeter,
  //   token: Config.tokenPeter,
  // );

  // final channel = await StreamApi.createChannel(
  //   client,
  //   type: 'messaging',
  //   id: 'sample2',
  //   name: 'Family',
  //   image:
  //       'https://image.freepik.com/fotos-kostenlos/glueckliche-familie-in-einer-reihe-liegen_1098-1101.jpg',
  //   idMembers: [Config.idEmily, Config.idPeter],
  // );

  final channel = await StreamApi.watchChannel(
    client,
    type: 'messaging',
    id: 'sample',
  );

  runApp(MyApp(client: client, channel: channel));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  const MyApp({super.key, required this.client, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(
        title: 'Stream Chat',
        client: client,
        channel: channel,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final StreamChatClient client;
  final Channel channel;

  const MyHomePage(
      {super.key,
      required this.title,
      required this.client,
      required this.channel});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamChat(
        streamChatThemeData: StreamChatThemeData(
          otherMessageTheme: const StreamMessageThemeData(
            messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          ownMessageTheme: StreamMessageThemeData(
            messageTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            avatarTheme: StreamAvatarThemeData(
              constraints: const BoxConstraints(maxWidth: 80, maxHeight: 80),
              borderRadius: BorderRadius.circular(120),
            ),
          ),
        ),
        client: widget.client,
        child: const ChannelListPage(),
      ),
    );
  }
}
