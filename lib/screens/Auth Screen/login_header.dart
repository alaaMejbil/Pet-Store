import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled15/theme/my_colors.dart';

import 'Animation/fade_animation.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeAnimation(
          0.5,
          SizedBox(
            width: double.infinity,
            height: 380,
            child: Opacity(
              opacity: 0.7,
              child: ClipPath(
                clipper: WaveClipper(), //set our custom wave clipper
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyColors.secondaryColor!,
                        MyColors.primaryColor!,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  height: 200,
                ),
              ),
            ),

            //Image.asset('assets/images/background.png'),
          ),
        ),
        FadeAnimation(
          1,
          SizedBox(
            width: MediaQuery.of(context).size.width + 20,
            height: 350,
            child: Opacity(
              opacity: 0.65,
              child: ClipPath(
                clipper: WaveClipper(), //set our custom wave clipper
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyColors.primaryColor!,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  height: 200,
                ),
              ),
            ),
            // Image.asset(
            //   'assets/images/background-2.png',
            //   fit: BoxFit.values[2],
            // ),
          ),
        ),
        Positioned(
          top: 140,
          right: 30,
          child: FadeAnimation(
              1.3,
              SvgPicture.asset(
                'assets/icons/pet.svg',
                color: Colors.white70,
                width: 40,
              )),
        ),
        Positioned(
          top: 170,
          right: 60,
          child: FadeAnimation(
              1.4,
              SvgPicture.asset(
                'assets/icons/pet.svg',
                color: Colors.white70,
                width: 40,
              )),
        ),
        Positioned(
          bottom: 85,
          left: 77,
          child: FadeAnimation(
              1.1,
              SvgPicture.asset(
                'assets/icons/cat.svg',
                color: Colors.white70,
                width: 80,
              )),
        ),
        Positioned(
          bottom: 50,
          left: 12,
          child: FadeAnimation(
              1.2,
              SvgPicture.asset(
                'assets/icons/dog.svg',
                color: Colors.white70,
                width: 80,
              )),
        ),
        Positioned(
          top: 90,
          left: 20,
          child: FadeAnimation(
              1,
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/pet.svg',
                    color: MyColors.secondaryColor,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pet Store',
                    style: TextStyle(
                      color: MyColors.secondaryColor!,
                      fontSize: 38,
                      letterSpacing: 3,
                      fontFamily: "signatra",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

//Costom CLipper class with Path
class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
