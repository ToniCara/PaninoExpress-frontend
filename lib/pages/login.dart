import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paninoexpress/main.dart';
import 'package:paninoexpress/pages/homePage.dart';
import 'package:paninoexpress/pages/menuPage.dart';
import 'package:paninoexpress/pages/splashpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var token = '';
  GoogleSignInAccount? _currentUser;
  String photoUrl = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '218796606716-eg6uigl00714gc7rc1lsqhoj2g43padl.apps.googleusercontent.com',
    scopes: ['email', 'profile', 'openid'],
  );

  void load() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('token')!;
    });
  }

  void signIn() async {
    setState(() async {
      if (_currentUser == null) {
        await _googleSignIn.signIn();
        suca();
      }
    });
  }

  void suca() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => PaninoExpress(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); //Initial page position
        const end = Offset.zero; //last page position
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        setState(() async {
          GoogleSignInAuthentication data = await _currentUser!.authentication;
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          await _prefs.setString('token', data.accessToken as String);
          token = data.accessToken as String;
          print(_currentUser!.photoUrl!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.phone_iphone_rounded,
                size: 100,
              ),
              const SizedBox(height: 50),
              Text(
                'BENTORNATO!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Accedi ora per ordinare',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 13),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: InkWell(
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                            color: const Color.fromARGB(255, 74, 72, 72)),
                      ),
                      child: const Center(
                        child: Text(
                          'ACCEDI',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                    ),
                    onTap: () {
                      signIn();

                      // Navigator.of(context)
                      // .push( PageRouteBuilder(

                      //   transitionDuration: const Duration(milliseconds: 600),
                      //   reverseTransitionDuration: const Duration(milliseconds: 600),
                      //   pageBuilder: (context, animation, secondaryAnimation) => MenuPage(),
                      //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      //     const begin = Offset(1.0, 0.0); //Initial page position
                      //     const end = Offset.zero; //last page position
                      //     const curve = Curves.easeInOut;
                      //     var tween = Tween(begin: begin, end: end)
                      //                 .chain(CurveTween(curve: curve));

                      //     return SlideTransition(position: animation.drive(tween),child: child,
                      //     );
                    },
                  )),
              const SizedBox(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'Non sei ancora iscritto? ',
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(PageRouteBuilder(
              //           transitionDuration: const Duration(milliseconds: 600),
              //           reverseTransitionDuration:
              //               const Duration(milliseconds: 600),
              //           pageBuilder: (context, animation, secondaryAnimation) =>
              //               const MyRegister(),
              //           transitionsBuilder:
              //               (context, animation, secondaryAnimation, child) {
              //             const begin =
              //                 Offset(1.0, 0.0); //Initial page position
              //             const end = Offset.zero; //last page position
              //             const curve = Curves.easeInOut;
              //             var tween = Tween(begin: begin, end: end)
              //                 .chain(CurveTween(curve: curve));

              //             return SlideTransition(
              //               position: animation.drive(tween),
              //               child: child,
              //             );
              //           },
              //         ));
              //       },
              //       child: const Text('Registrati ora',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Color.fromARGB(255, 19, 35, 138),
              //               fontSize: 18)),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
