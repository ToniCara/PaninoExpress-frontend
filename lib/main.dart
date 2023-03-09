import 'package:flutter/material.dart';
import 'package:paninoexpress/flutter_advanced_drawer.dart';
import 'package:paninoexpress/pages/CarrelloPage.dart';
import 'package:paninoexpress/pages/RicaricaPage.dart';
import 'package:paninoexpress/pages/homePage.dart';
import 'package:paninoexpress/pages/login.dart';
import 'package:paninoexpress/pages/order.dart';

void main() {
  runApp(const PaninoExpress());
}

class PaninoExpress extends StatelessWidget {
  const PaninoExpress({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    String username = "Guest";
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 145, 72, 12),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 10.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(66, 0, 0, 0),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'images/login.jpg',
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        ),
                  'Ciao $username!'
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Il tuo saldo attuale:'),
              ),
              ListTile(
                onTap: () {
                
                    Navigator.of(context)
                    .push( PageRouteBuilder(

                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => RicaricaPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                        
                        return SlideTransition(position: animation.drive(tween),child: child,
                        );
                      },



                    )

                    );
                },
                leading: const Icon(Icons.wallet_outlined),
                title: const Text('Ricarica Saldo'),
              ),
              ListTile(
                onTap: () {
                
                    Navigator.of(context)
                    .push( PageRouteBuilder(

                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                        
                        return SlideTransition(position: animation.drive(tween),child: child,
                        );
                      },



                    )

                    );
                },
                leading: const Icon(Icons.account_circle_outlined),
                title: const Text('Profilo'),
              ),
              ListTile(
                onTap: () {

                  Navigator.of(context)
                    .push( PageRouteBuilder(

                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => CarrelloPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                        
                        return SlideTransition(position: animation.drive(tween),child: child,
                        );
                      },



                    )

                    );



                },
                leading: const Icon(Icons.shopping_cart_outlined),
                title: const Text('Carrello'),
              ),
              ListTile(
                onTap: () {

                  Navigator.of(context)
                    .push( PageRouteBuilder(

                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => OrdinePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                        
                        return SlideTransition(position: animation.drive(tween),child: child,
                        );
                      },



                    )

                    );



                },
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text('Ultimo ordine'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.info_outline),
                title:const  Text('AboutUs'),
              ),
              const Spacer(),
              
              ListTile(
                onTap: () {},
                
                leading: const Icon(Icons.logout),
                title:const  Text('Log Out'),
                 tileColor: Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder( 
                    side: const BorderSide(width: 4),
                    borderRadius: BorderRadius.circular(20),
                    
                ),
              ),
              
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
              
            ],
          ),
        ),
      ),
      child: Scaffold(
        body: HomePage(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Image.asset(
                "images/appbarlogo.png",
                fit: BoxFit.fill,
          ),
          actions:[ 
            IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          ]
         ),
        ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}