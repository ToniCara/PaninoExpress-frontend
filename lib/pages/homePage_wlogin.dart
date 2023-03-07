import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paninoexpress/utils/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageWLogin extends StatefulWidget {
  const HomePageWLogin({super.key});

  @override
  State<HomePageWLogin> createState() => _HomePageWLoginState();
}

class _HomePageWLoginState extends State<HomePageWLogin> {

  var token = '';
  GoogleSignInAccount? _currentUser;
  String photoUrl = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '218796606716-eg6uigl00714gc7rc1lsqhoj2g43padl.apps.googleusercontent.com',
    scopes: ['email', 'profile','openid'],
  );

  void load()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('token')!;
    });
  }

  void signIn() async{
    setState(() async{
      if(_currentUser == null){
        await _googleSignIn.signIn();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if(_currentUser != null){
        setState(() async{
          GoogleSignInAuthentication data = await _currentUser!.authentication;
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          await _prefs.setString('token', data.accessToken as String);
          token = data.accessToken as String;
          print(_currentUser!.photoUrl!);
        });
        
      }
    });
    signIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(_currentUser!.photoUrl!.toString()),
            Text(token)
          ],
        ),
      ),
    );
  }
}
