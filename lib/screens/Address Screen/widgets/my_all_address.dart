import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/user_address_provider.dart';
import 'package:untitled15/theme/my_colors.dart';

import '../../../Model/address_model.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  //int _currentAddressValue = 0;

  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<UserAddressProvider>(context);
    return Column(
      children: List.generate(
          addressProvider.userAddresses.length,
          (index) => Card(
                child: RadioListTile(
                  title: Text(addressProvider.userAddresses[index].city!),
                  subtitle: Text(addressProvider.userAddresses[index].address!),
                  onChanged: (value) {
                    print(value);
                    addressProvider.currentUserAddress = index;
                    addressProvider.notifyListeners();
                    //setState(() => _currentAddressValue = index);
                  },
                  activeColor: MyColors.secondaryColor,
                  value: index,
                  groupValue: addressProvider.currentUserAddress,
                ),
              )),
    );
  }
}
