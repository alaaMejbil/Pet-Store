import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/root_app.dart';
import 'package:untitled15/theme/my_colors.dart';
import '../../providers/order_provider.dart';
import '../../providers/pet_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/user_address_provider.dart';
import 'Animation/fade_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  Future<Timer> startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    await Provider.of<PetProvider>(context, listen: false).fetchAllPets();
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAllProducts();
    await Provider.of<UserAddressProvider>(context, listen: false)
        .getUserAddresses();
    await Provider.of<OrderProvider>(context, listen: false).fetchMyOrders();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RootApp()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(
        parent: animationController!, curve: Curves.easeInOutSine);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: MyColors.primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              MyColors.primaryColor!,
              Colors.indigo,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pet.svg',
                        color: Colors.white,
                        width: animation!.value * 55,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pet.svg',
                        color: Colors.white,
                        width: animation!.value * 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SvgPicture.asset(
                //   'assets/icons/pet-border.svg',
                //   width: 25,
                //   color: Colors.white,
                //
                //   //width: animation!.value * 50,
                // ),
                const SizedBox(
                  width: 3,
                ),
                FadeAnimation(
                  3,
                  Text(
                    'Pet Store',
                    style: TextStyle(
                        color: MyColors.secondaryColor!,
                        fontSize: 45,
                        letterSpacing: 3,
                        fontFamily: "signatra",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            FadeAnimation(
                3.5,
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
