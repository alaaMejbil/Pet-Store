import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/theme/my_colors.dart';

import '../../../Model/address_model.dart';

class MyPaymentScreen extends StatefulWidget {
  const MyPaymentScreen({Key? key}) : super(key: key);

  @override
  _MyPaymentScreenState createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {
  final _paymentMethodData = [
    {
      'type': 'Credit Card',
      'id': '*** *** *89',
      'icon': 'assets/icons/credit-card-icon.svg',
    },
    {
      'type': 'Bank Account',
      'id': 'Ending 852',
      'icon': 'assets/icons/online-banking.svg',
    },
    {
      'type': 'PayPal',
      'id': 'alaa@gmail.com',
      'icon': 'assets/icons/paypal-icon.svg',
    },
  ];

  int _currentPaymentMethode = 0;
  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<UserAddressProvider>(context);
    return Column(
      children: List.generate(
          _paymentMethodData.length,
          (index) => Card(
                child: RadioListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  title: Text(_paymentMethodData[index]['type']!),
                  subtitle: Text(_paymentMethodData[index]['id']!),
                  activeColor: Colors.red.withOpacity(0.8),
                  secondary: Container(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      _paymentMethodData[index]['icon']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onChanged: (value) {
                    print(value);
                    setState(() => _currentPaymentMethode = index);
                  },
                  value: index,
                  groupValue: _currentPaymentMethode,
                ),
              )),
    );
  }
}
