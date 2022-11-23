import 'package:flutter/material.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../components/custom_image.dart';

/*
 * for slider home page
 */
class CustomSliderWidget extends StatefulWidget {
  // final List<String> items;
  final List items;

  CustomSliderWidget({required this.items});

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  int activeIndex = 0;
  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          margin: EdgeInsets.only(bottom: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setActiveDot(index);
              },
              enableInfiniteScroll: false,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              // autoPlay: true,
              viewportFraction: 1.0,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            items: widget.items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return CustomImage(
                    item,
                    radius: 12,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                  );
                },
              );
            }).toList(),
          ),
        ),
        if (widget.items.length > 1)
          Positioned(
            bottom: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(widget.items.length, (idx) {
                  return activeIndex == idx ? ActiveDot() : InactiveDot();
                })),
          )
      ],
    );
  }
}

class ActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          //borderRadius: BorderRadius.circular(5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          //color: Colors.grey,
          //borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: MyColors.primaryColor!,
            width: 1.5,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
