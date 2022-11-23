import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:untitled15/components/custom_image.dart';

class productCardItem extends StatelessWidget {
  const productCardItem(
      {Key? key,
      required this.imgUrl,
      this.width = 350,
      this.height = 400,
      this.radius = 40,
      this.onTap,
      this.onFavoriteTap})
      : super(key: key);
  final String imgUrl;
  final double width;
  final double height;
  final double radius;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CustomImage(
                imgUrl,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(radius), bottom: Radius.zero),
                isShadow: false,
                width: width,
                height: height,
              ),
            ),
            Positioned(
              bottom: 0,
              child: GlassContainer(
                borderRadius: BorderRadius.circular(25),
                blur: 10,
                opacity: 0.15,
                child: Container(
                    width: width,
                    //height: 110,
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87.withOpacity(0.12),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(
                                child: Text(
                              'Light Sky Qatar',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )),
                            //SvgPicture.asset('assets/svg/star.svg'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '16000 \$',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SvgPicture.asset(
                            //   'assets/svg/love.svg',
                            //   color: Colors.white,
                            // ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Row(
                              children: [
                                Text(
                                  '20',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white.withOpacity(0.8),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        ),
      ],
    );
  }
}
