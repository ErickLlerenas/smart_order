import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_order/providers/app_provider.dart';
import '../../helpers/database.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Database db = Database();
  String phone = "";
  bool isUser = false;
  Map userData = {};
  bool isSwitched = false;
  String mode = "";

  @override
  void initState() {
    phone = Provider.of<AppProvider>(context, listen: false).phone;
    isUser = Provider.of<AppProvider>(context, listen: false).isUser;

    super.initState();
    db.initiliase();
    db.getUserData(isUser, phone).then((data) {
      print(data);
      setState(() {
        if (isUser) {
          mode = "Vendedor";
        }
        userData = data;
      });
    });
    db.initiliase();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(width / 10),
              child: Center(
                child: userData['image'] != null
                    ? CircleAvatar(
                        radius: width / 2.5,
                        backgroundImage: NetworkImage(userData['image']),
                        backgroundColor: Colors.transparent,
                      )
                    : Container(),
              ),
            ),
            Text(userData['name'] ?? "",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                textAlign: TextAlign.center),
            SizedBox(height: 15),
            Text(isUser ? "Usuario" : "Vendedor",
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w300,
                    fontSize: 22),
                textAlign: TextAlign.center),
            Container(
              padding: const EdgeInsets.all(20),
              child: BottomAppBar(
                color: Colors.transparent,
                child: ElevatedButton(
                    onPressed: () async {
                      await db.setLocation(
                        id: phone,
                      );
                    },
                    child: const Text(
                      "Establecer ubicacion actual",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ),
            Text("Cambiar de modo, ahora estas en modo $mode"),
            Container(
              child: Switch(
                value: isUser,
                onChanged: (value) {
                  setState(() {
                    isUser = value;
                    if (isUser) {
                      mode = "Cliente";
                    } else {
                      mode = "Vendedor";
                    }
                    Provider.of<AppProvider>(context, listen: false)
                        .changeUserUI();
                  });
                },
                activeTrackColor: Colors.yellow,
                activeColor: Colors.orangeAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
