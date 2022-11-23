import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/address_model.dart';
import 'package:untitled15/Model/cart_item.dart';
import 'package:untitled15/components/my_button.dart';
import 'package:untitled15/providers/cart_provider.dart';
import 'package:untitled15/providers/order_provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/root_app.dart';
import 'package:untitled15/screens/Add%20New%20Address/add_new_address.dart';
import 'package:untitled15/screens/payment%20screen/my_payment_screen.dart';

import '../../theme/my_colors.dart';
import '../../theme/my_style.dart';
import '../Address Screen/widgets/my_all_address.dart';
import '../confirmation screen/confirmation_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int currentStep = 0;
  //late AddressModel currentAddress;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    var userAddressProvider = Provider.of<UserAddressProvider>(context);
    List<CartModel> cartItemsList = cartProvider.cartItems.values.toList();
    return Scaffold(
      appBar: getAppBar(context),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: MyColors.primaryColor,
          ),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          controlsBuilder: (context, _) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                  child: const Text('Back'),
                ),
                TextButton(
                  onPressed: () {
                    if (isLastStep) {
                      // completed
                      orderProvider
                          .addNewOrder(
                              cartItemsList,
                              cartProvider.totalAmount,
                              userAddressProvider.destinationAddress.address!,
                              'paypal')
                          .then((value) {
                        if (value) {
                          // after add order : empty the Cart
                          cartProvider.clearAllItemsFromCart();
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => RootApp(),
                            ),
                            (route) => false,
                          );
                        } else {
                          //there are an error. Try again later
                        }
                      });
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  child: Text(isLastStep ? 'Confirm' : 'NEXT'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: MyColors.mainTextColor,
          ),
          splashRadius: 22,
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: MyColors.appBarColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Checkout',
        style: MyStyle.mainTextStyle,
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text('Address'),
          content: Column(
            children: [
              const MyAddress(),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                title: 'Add New Address',
                icon: Icons.add,
                bgColor: MyColors.secondaryColor!,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNewAddress()));
                },
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text('Payment'),
          content: Column(
            children: [
              const MyPaymentScreen(),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                title: 'Add New Card',
                icon: Icons.add,
                bgColor: MyColors.secondaryColor!,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNewAddress()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Confairmation'),
          content: const ConfirmationScreen(),
        ),
      ];
}
