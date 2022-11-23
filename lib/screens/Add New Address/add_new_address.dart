import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/address_model.dart';
import 'package:untitled15/providers/user_address_provider.dart';

import '../../components/my_button.dart';
import '../../theme/my_colors.dart';
import '../../theme/my_style.dart';
import '../Add New Pet/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNewAddress extends StatelessWidget {
  final userNameController = TextEditingController();
  final cityController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<UserAddressProvider>(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: addressProvider.isLoading,
        color: MyColors.primaryColor!,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'User Name',
                  controller: userNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Phone Number',
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'City/District*',
                        controller: cityController,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Zip*',
                        controller: zipController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                buildAddressTextField(),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                  title: 'Save',
                  icon: Icons.add,
                  bgColor: MyColors.primaryColor!,
                  onTap: () async {
                    AddressModel newAddress = AddressModel(
                      address: addressController.text,
                      userName: userNameController.text,
                      phoneNumber: phoneNumberController.text,
                      city: cityController.text,
                      zip: int.parse(zipController.text),
                    );
                    await addressProvider
                        .addNewAddress(newAddress)
                        .then((value) => Navigator.pop(context));
                  },
                ),
              ],
            ),
          ),
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
        'New Address',
        style: MyStyle.mainTextStyle,
      ),
    );
  }

  Container buildAddressTextField() {
    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.textFieldColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: addressController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Address',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}
