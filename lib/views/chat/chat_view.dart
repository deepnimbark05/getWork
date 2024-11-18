import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final List<Map<String, String>> chatUsers = [
    {
      'name': 'Ajay Ramani',
      'status': 'Active',
      'image': 'assets/images/slider3.webp', // Asset image path
    },
    {
      'name': 'Manshi Shah',
      'status': 'Active | 20:49 PM',
      'image': 'assets/images/slider2.jpeg',
    },
    {
      'name': 'Raj Patel',
      'status': 'Active 1 Week',
      'image': 'assets/images/slider1.jpeg',
    },
    {
      'name': 'Ajay Ramani',
      'status': 'Active',
      'image': 'assets/images/slider3.webp',
    },
    {
      'name': 'Manshi Shah',
      'status': 'Active | 20:49 PM',
      'image': 'assets/images/slider1.jpeg',
    },
    {
      'name': 'Raj Patel',
      'status': 'Active 1 Week',
      'image': 'assets/images/slider3.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: chatUsers.length,
        itemBuilder: (context, index) {
          return ChatUserTile(
            name: chatUsers[index]['name']!,
            status: chatUsers[index]['status']!,
            imageUrl: chatUsers[index]['image']!,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.white),
            label: '',
          ),
        ],
        currentIndex: 1, // Set this as per your logic
        onTap: (index) {
          // Handle navigation tap
        },
      ),
    );
  }
}

class ChatUserTile extends StatelessWidget {
  final String name;
  final String status;
  final String imageUrl;

  ChatUserTile({
    required this.name,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(imageUrl), // Use AssetImage here
            radius: 30,
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(status),
          onTap: () {
            // Handle tap on user
          },
        ),
      ),
    );
  }
}
