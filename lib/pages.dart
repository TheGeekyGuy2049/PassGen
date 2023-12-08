import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redirect_icon/redirect_icon.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:clipboard/clipboard.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  int passwordLength = 8;
  bool includeNumbers = true;
  bool includeUpperCaseLetters = true;
  bool includeSymbols = true;
  String generatedPassword = '';
  List<String> savedPasswords = [];

  String generateRandomPassword() {
    String charset =
        "abcdefghijklmnopqrstuvwxyz";

    if (includeNumbers) {
      charset += "0123456789";
    }

    if (includeUpperCaseLetters) {
      charset += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    }

    if (includeSymbols) {
      charset += "!@#%^&*()_-+=";
    }

    Random random = Random();

    List<String> passwordList =
    List.generate(passwordLength, (index) => charset[random.nextInt(charset.length)]);

    return passwordList.join();
  }

  void savePassword() {
    if (generatedPassword.isNotEmpty) {
      setState(() {
        savedPasswords.add(generatedPassword);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          HapticFeedback.heavyImpact();
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
          'Password Length: $passwordLength',
            style: const TextStyle(fontSize: 16.0),
          ),
          Slider(
            value: passwordLength.toDouble(),
            min: 4,
            max: 40,
            divisions: 16,
            onChanged: (double value) {
              HapticFeedback.heavyImpact();
              setState(() {
                passwordLength = value.toInt();
              });
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Include Numbers:'),
              Switch(
                value: includeNumbers,
                onChanged: (bool value) {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    includeNumbers = value;
                  });
                },
              ),
              const Text('Include Upper Case Letters:'),
              Switch(
                value: includeUpperCaseLetters,
                onChanged: (bool value) {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    includeUpperCaseLetters = value;
                  });
                },
              ),
              const Text('Include Symbols:'),
              Switch(
                value: includeSymbols,
                onChanged: (bool value) {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    includeSymbols = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String password = generateRandomPassword();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Generated Password'),
                    content: Text(password),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () {
                          FlutterClipboard.copy(password);
                        },
                        child: const Text('Copy'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Generate Password'),
          ),
          ],
        ),
        ),
        Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      Fluttertoast.showToast(
                          msg: 'Mr. Robot is hacking your smartphone right now.'
                      );
                    });
                  },
                  child: const CircleAvatar(
                    backgroundImage: ExactAssetImage('assets/myPhoto.jpg'),
                    radius: 80,
                  ),
                ),
              ),
              const Text(
                'Abd El Rahman Mohamed',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              ),
              const Text(
                'Flutter Developer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const Text(
                'Follow me on:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RedirectSocialIcon(
                      url: "https://www.facebook.com/AbdElRahamnMohamed2000/",
                      icon: FontAwesomeIcons.facebook,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.black
                  ),
                  RedirectSocialIcon(
                      url: "https://twitter.com/Abdelrahman5T",
                      icon: FontAwesomeIcons.xTwitter,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.black
                  ),
                  RedirectSocialIcon(
                      url: "https://www.instagram.com/abd_el_rahman.mohammed.3152/",
                      icon: FontAwesomeIcons.instagram,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.black
                  ),
                ],
              ),
            ],
          ),
        ),
      ]
      [currentPageIndex],
    );
  }
}