import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guardian_eye/Dashboard/ContactScreens/phonebook_view.dart';

class SafeHome extends StatefulWidget {
  const SafeHome({Key? key}) : super(key: key);

  @override
  _SafeHomeState createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  bool getHomeSafeActivated = false;
  List<String> numbers = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkGetHomeActivated();
  }

  Future<void> checkGetHomeActivated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getHomeSafeActivated = prefs.getBool("getHomeSafe") ?? false;
    });
    if (getHomeSafeActivated) {
      startPeriodicMsg();
    }
  }

  Future<void> changeStateOfHomeSafe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getHomeSafeActivated = value;
      prefs.setBool("getHomeSafe", value);
    });
    if (value) {
      Fluttertoast.showToast(msg: "Service Activated in Background!");
      startPeriodicMsg();
    } else {
      Fluttertoast.showToast(msg: "Service Disabled!");
      timer?.cancel();
    }
  }

  void startPeriodicMsg() {
    timer =
        Timer.periodic(Duration(minutes: 15), (Timer t) => sendPeriodicMsg());
  }

  Future<void> sendPeriodicMsg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> numbers = prefs.getStringList("numbers") ?? [];
    Location location = Location();
    try {
      LocationData myLocation = await location.getLocation();
      if (numbers.isEmpty) {
        Fluttertoast.showToast(
          msg: 'No Contacts Found!',
          backgroundColor: Colors.red,
        );
        return;
      }
      String link =
          "I am on my way, track me here\nhttp://maps.google.com/?q=${myLocation.latitude},${myLocation.longitude}";
      for (String number in numbers) {
        sendSMS(number.split("***")[1], link);
      }
    } on PlatformException catch (e) {
      String error = e.code == 'PERMISSION_DENIED'
          ? 'Please grant permission'
          : 'Permission denied- please enable it from app settings';
      Fluttertoast.showToast(msg: error, backgroundColor: Colors.red);
    }
  }

  void sendSMS(String number, String msgText) {
    // This is where you should integrate SMS sending functionality
    // Replace with actual implementation if needed
    Fluttertoast.showToast(
      msg: 'Sending Alert to $number...',
      backgroundColor: Colors.blue,
    );
    // Add SMS sending logic here
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: InkWell(
        onTap: () {
          showModelSafeHome(getHomeSafeActivated);
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        title: Text("Get Home Safe"),
                        subtitle: Text("Share Location Periodically"),
                      ),
                      Visibility(
                        visible: getHomeSafeActivated,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              SpinKitDoubleBounce(
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Currently Running...",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/liv.png",
                    height: 140,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showModelSafeHome(bool processRunning) async {
    int selectedContact = -1;
    bool getHomeActivated = processRunning;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider(indent: 20, endIndent: 20)),
                        Text("Get Home Safe"),
                        Expanded(child: Divider(indent: 20, endIndent: 20)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFF5F4F6),
                    ),
                    child: SwitchListTile(
                      secondary: Lottie.asset("assets/routes.json"),
                      value: getHomeActivated,
                      onChanged: (val) async {
                        if (val && selectedContact == -1) {
                          Fluttertoast.showToast(
                            msg: "Please select one contact!",
                          );
                          return;
                        }
                        setModalState(() {
                          getHomeActivated = val;
                        });
                        if (getHomeActivated) {
                          changeStateOfHomeSafe(true);
                        } else {
                          changeStateOfHomeSafe(false);
                        }
                      },
                      subtitle: Text(
                        "Your location will be shared with one of your contacts every 15 minutes",
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: getSOSNumbers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) {
                              return Divider(indent: 20, endIndent: 20);
                            },
                            itemBuilder: (context, index) {
                              String contactData = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  setModalState(() {
                                    selectedContact = index;
                                  });
                                },
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/user.png"),
                                ),
                                title: Text(contactData.split("***")[0]),
                                subtitle: Text(contactData.split("***")[1]),
                                trailing: selectedContact == index
                                    ? Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : null,
                              );
                            },
                          );
                        } else {
                          return ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneBook(),
                                ),
                              );
                            },
                            title: Text("No contact found!"),
                            subtitle: Text("Please add at least one contact"),
                            trailing: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.grey),
                          );
                        }
                      },
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

  Future<List<String>> getSOSNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("numbers") ?? [];
  }
}
