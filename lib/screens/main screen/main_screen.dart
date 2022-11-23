import 'package:animate_do/animate_do.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/PetModel.dart';
import 'package:untitled15/costants.dart';
import 'package:untitled15/providers/pet_provider.dart';
import 'package:untitled15/screens/Add%20New%20Pet/add_new_pet_screen.dart';
import 'package:untitled15/screens/main%20screen/widgets/category_item.dart';
import 'package:untitled15/screens/main%20screen/widgets/pet_item.dart';
import 'package:untitled15/screens/main%20screen/widgets/top_header.dart';

import '../../theme/my_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedCategory = 0;
  int selectedBottomAppBar = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<PetProvider>(context);
    return SingleChildScrollView(
      //physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(top: 0, child: TopHeader()),
                Positioned(
                  top: 200,
                  child: getCategories(size),
                ),
              ],
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: provider.isLoading
                ? const CustomCircularProgress()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        provider.getPetsByCategory(selectedCategory).length,
                    itemBuilder: (context, index) {
                      List<PetModel> categoryPets =
                          provider.getPetsByCategory(selectedCategory);
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 160 * index),
                          child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: FadeInDown(
                              child: PetItem(
                                pet: categoryPets[index],
                              ),
                            ),
                          ));
                    }),
          ),
        ],
      ),
    );
  }

  /*
  *
  *
  *
  *
  *
  *
  *
  *  Our Methode
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
   */

  SizedBox getCategories(Size size) {
    return SizedBox(
      height: 90,
      width: size.width,
      child: ListView.builder(
        itemCount: Constants.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryItem(
          data: Constants.categories[index],
          isSelected: selectedCategory == index,
          onTap: () {
            setState(() {
              selectedCategory = index;
            });
          },
        ),
      ),
    );
  }
}
