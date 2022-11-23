import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/components/custom_image.dart';
import 'package:untitled15/providers/cart_provider.dart';
import 'package:untitled15/providers/order_provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'package:untitled15/theme/my_style.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var addressProvider = Provider.of<UserAddressProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: orderProvider.isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Shipping Address',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              addressProvider
                  .userAddresses[addressProvider.currentUserAddress].address!,
              style: TextStyle(color: Colors.grey.withOpacity(0.8)),
            ),
            const Divider(
              height: 20,
            ),
            const Text(
              'Payment Method',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/paypal-icon.svg',
                fit: BoxFit.cover,
                width: 35,
              ),
              title: const Text('Paypal'),
              subtitle: const Text('*** *** **89'),
            ),
            const Divider(
              height: 20,
            ),
            const Text(
              'Order Details',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
                itemCount: cartProvider.cartItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final cartItem =
                      cartProvider.cartItems.values.toList()[index];
                  return Card(
                    elevation: 0.3,
                    child: ListTile(
                      leading: CustomImage(
                        cartItem.imgUrl,
                        radius: 6,
                      ),
                      title: Text(
                        cartItem.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('\$${cartItem.price.toString()}'),
                      trailing: Text(
                        'x${cartItem.quantity.toInt()}',
                        style: TextStyle(color: MyColors.secondaryColor),
                      ),
                    ),
                  );
                }),
            const Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sub Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${cartProvider.totalAmount}',
                  style: TextStyle(
                      color: MyColors.secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
