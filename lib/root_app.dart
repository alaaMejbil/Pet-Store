import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/auth_provider.dart';
import 'package:untitled15/providers/cart_provider.dart';
import 'package:untitled15/providers/order_provider.dart';
import 'package:untitled15/providers/pet_provider.dart';
import 'package:untitled15/providers/product_provider.dart';
import 'package:untitled15/providers/root_app_provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/screens/All%20products%20Screen/all_product_screen.dart';
import 'package:untitled15/screens/Auth%20Screen/login_screen.dart';
import 'package:untitled15/screens/My%20Order%20Screen/my_order_screen.dart';
import 'package:untitled15/screens/cart%20screen/cart_screen.dart';
import 'package:untitled15/screens/main%20screen/main_screen.dart';
import 'package:untitled15/screens/my%20favoarite%20items/my_favoraite_screen.dart';
import 'package:untitled15/services/cashe_helper.dart';

import 'components/cart_icon_with_notification.dart';
import 'screens/Add New Pet/add_new_pet_screen.dart';
import 'theme/my_colors.dart';

class RootApp extends StatefulWidget {
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int selectedCategory = 0;
  //int selectedBottomAppBar = 0;

  List bottomBarItems = [
    {
      'icon': 'assets/icons/pet.svg',
      'page': Container(
        child: MainScreen(),
      ),
      'appBarTitle': 'Pets Store',
    },
    {
      'icon': 'assets/icons/home.svg',
      'page': AllProductScreen(),
      'appBarTitle': 'All Pets',
    },
    {
      'icon': 'assets/icons/plus.svg',
      'page': AddNewPetScreen(),
      'appBarTitle': 'Add New Pet',
    },
    {
      'icon': 'assets/icons/heart.svg',
      'page': MyFavoriteScreen(),
      'appBarTitle': 'My Favorite Pets',
    },
    {
      'icon': 'assets/icons/order-icon.svg',
      'page': MyOrderScreen(),
      'appBarTitle': 'My Orders',
    },
  ];

  @override
  void initState() {
    // Provider.of<PetProvider>(context, listen: false).fetchAllPets();
    // Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
    // Provider.of<UserAddressProvider>(context, listen: false).getUserAddresses();
    // Provider.of<OrderProvider>(context, listen: false).fetchMyOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<RootAppProvider>(context);
    int selectedBottomAppBar = provider.selectedIndex;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: MyColors.appBgColor,
      appBar: getAppBar(bottomBarItems[selectedBottomAppBar]['appBarTitle']),
      bottomNavigationBar: getBottomNavigationBar(),
      drawer: buildDrawer(),
      body: RefreshIndicator(onRefresh: _refreshAppData, child: getTabBody()),
    );
  }

  Drawer buildDrawer() {
    var authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Alaa Mejbil'),
            accountEmail: Text('aa@gmail.com'),
            decoration: BoxDecoration(color: MyColors.primaryColor),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.account_circle_outlined,
                size: 60,
                color: MyColors.primaryColor,
              ),
              backgroundColor: Colors.white70,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: MyColors.primaryColor,
            ),
            title: Text('Log Out'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              authProvider.logout();
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info,
              color: MyColors.primaryColor,
            ),
            title: Text('About us'),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget getBottomNavigationBar() {
    var provider = Provider.of<RootAppProvider>(context);
    int selectedBottomAppBar = provider.selectedIndex;
    return Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          bottomBarItems.length,
          (index) => TabBarItem(
            iconUrl: bottomBarItems[index]['icon'],
            onTap: () {
              // setState(() {
              //   selectedBottomAppBar = index;
              // });

              Provider.of<RootAppProvider>(context, listen: false)
                  .changeSelectedTab(index);
            },
            isSelected: selectedBottomAppBar == index,
          ),
        ),
      ),
    );
  }

  Widget getTabBody() {
    int selectedBottomAppBar =
        Provider.of<RootAppProvider>(context).selectedIndex;
    return IndexedStack(
      index: selectedBottomAppBar,
      children: List.generate(
          bottomBarItems.length, (index) => bottomBarItems[index]['page']),
    );
  }

  Future<void> _refreshAppData() async {
    await Provider.of<PetProvider>(context, listen: false).fetchAllPets();
    Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
    Provider.of<UserAddressProvider>(context, listen: false).getUserAddresses();
    Provider.of<OrderProvider>(context, listen: false).fetchMyOrders();
  }
}

AppBar getAppBar(String title) {
  return AppBar(
    backgroundColor: MyColors.primaryColor,
    elevation: 0,
    centerTitle: true,
    // leading: const Icon(Icons.menu),
    title: Text(
      title,
      style: TextStyle(
        // color: MyColors.secondaryColor!,
        fontSize: 35,
        letterSpacing: 3,
        fontFamily: "signatra",
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: [
      Consumer<CartProvider>(
        builder: (context, cart, _) => CartWithNotification(
          count: cart.cartItemsLength,
          onPress: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
        ),
      ),
    ],
  );
}

class TabBarItem extends StatelessWidget {
  final bool isSelected;
  final GestureTapCallback onTap;
  final String iconUrl;

  const TabBarItem(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.iconUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(13, 2, 13, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 1,
            ),
            SvgPicture.asset(
              iconUrl,
              width: 25,
              height: 25,
              color: isSelected
                  ? MyColors.secondaryColor
                  : Colors.grey.withOpacity(0.4),
            ),
            Container(
              width: 28,
              height: 4,
              decoration: BoxDecoration(
                color:
                    isSelected ? MyColors.secondaryColor : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
