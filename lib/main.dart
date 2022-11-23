import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/auth_provider.dart';
import 'package:untitled15/providers/cart_provider.dart';
import 'package:untitled15/providers/order_provider.dart';
import 'package:untitled15/providers/pet_provider.dart';
import 'package:untitled15/providers/product_provider.dart';
import 'package:untitled15/providers/root_app_provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/root_app.dart';
import 'package:untitled15/screens/Auth%20Screen/login_screen.dart';
import 'package:untitled15/screens/Splash%20screen/splash_screen.dart';
import 'package:untitled15/screens/cart%20screen/cart_screen.dart';
import 'package:untitled15/screens/main%20screen/main_screen.dart';
import 'package:untitled15/services/cashe_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CasheHelper.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: RootAppProvider()),
        ChangeNotifierProxyProvider<AuthProvider, PetProvider>(
            create: (_) => PetProvider(),
            update: (ctx, value, previousProducts) => previousProducts!
              ..getData(value.token, value.userId, previousProducts.allPets)),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
            create: (_) => ProductProvider(),
            update: (ctx, value, previousProducts) => previousProducts!
              ..getData(
                  value.token, value.userId, previousProducts.allProducts)),
        ChangeNotifierProxyProvider<AuthProvider, UserAddressProvider>(
            create: (_) => UserAddressProvider(),
            update: (ctx, value, previousAddress) => previousAddress!
              ..getData(
                  value.token, value.userId, previousAddress.userAddresses)),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
            create: (_) => OrderProvider(),
            update: (ctx, value, previousOrders) => previousOrders!
              ..getData(value.token, value.userId, previousOrders.myOrders)),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Consumer<AuthProvider>(
      builder: (ctx, value, _) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: CartScreen(),
        home: value.isAuth
            ? SplashScreen()
            : FutureBuilder(
                future: value.tryAutoLogin(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return LoginScreen();
                  }
                }),
      ),
    );
  }
}
