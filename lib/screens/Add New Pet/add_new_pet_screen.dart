import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled15/Model/PetModel.dart';
import 'package:untitled15/providers/pet_provider.dart';
import 'package:untitled15/providers/root_app_provider.dart';
import 'package:untitled15/root_app.dart';
import 'package:untitled15/screens/Add%20New%20Pet/widgets/add_new_photo_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:untitled15/screens/Add%20New%20Pet/widgets/custom_text_field.dart';
import '../../components/my_button.dart';
import '../../theme/my_colors.dart';
import 'package:intl/intl.dart';

class AddNewPetScreen extends StatefulWidget {
  @override
  State<AddNewPetScreen> createState() => _AddNewPetScreenState();
}

class _AddNewPetScreenState extends State<AddNewPetScreen> {
  List<String> petsType = [
    'Dog',
    'Cat',
    'Parrot',
    'Rabbit',
    'Fish',
    'Turtle',
    'Other'
  ];

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final petNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final weightController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedPetsType;
  String? selectedGenderValue;
  DateTime? selectedDateOfBirth;

  void clearAllTextField(BuildContext ctx) {
    petNameController.clear();
    phoneNumberController.clear();
    weightController.clear();
    priceController.clear();
    descriptionController.clear();
    selectedGenderValue = '';
    selectedDateOfBirth = null;
    selectedPetsType = 'Dog';
    Provider.of<PetProvider>(context, listen: false).clearAllImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PetProvider>(context);
    List<XFile> images = provider.images;
    return ModalProgressHUD(
      inAsyncCall: provider.isLoadingAddScreen,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              CustomTextField(
                hintText: 'Pet Name',
                controller: petNameController,
              ),
              buildDropDown(),
              buildDatePiker(context),
              getGenderRadioButtons(),
              buildDescriptionTextField(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildWeightTextField(),
                  const SizedBox(
                    width: 20,
                  ),
                  buildPriceTextField(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(Icons.phone),
                controller: phoneNumberController,
              ),
              const SizedBox(
                height: 20,
              ),
              const AddPhotoButton(),
              if (images.isNotEmpty)
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    //crossAxisSpacing: 2,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.7,
                    children: List.generate(images.length, (index) {
                      //Asset asset = images[index].path;
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            child: Image.file(
                              File(images[index].path),
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                child: const Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () async {
                  PetModel newPet = PetModel(
                    creatorBy: 'TCzdxLTnvyXKbLzLAGLRQlgGPen1',
                    /****/
                    price: priceController.text,
                    ownerName: 'Alaa',
                    /****/
                    ownerPhone: int.parse(phoneNumberController.text),
                    age: '2 year',
                    /****/
                    sex: selectedGenderValue,
                    petName: petNameController.text,
                    description: descriptionController.text,
                    isFavorite: false,
                    weight: weightController.text,
                    imageUrl: "",
                    album: [],
                    petType: selectedPetsType,
                  );
                  await Provider.of<PetProvider>(context, listen: false)
                      .addNewPet(newPet);
                  Provider.of<RootAppProvider>(context, listen: false)
                      .changeSelectedTab(0);
                  clearAllTextField(context);
                },
                bgColor: MyColors.primaryColor!,
                title: 'Save',
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
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
*
*
*
*
*
*
*
*
 */
  GestureDetector buildDatePiker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        datePicker(context).then((value) {
          setState(() {
            selectedDateOfBirth = value;
          });
        });
      },
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDateOfBirth == null
                  ? 'Date Of Birth'
                  : DateFormat.yMd().format(selectedDateOfBirth!),
              style: TextStyle(
                color: selectedDateOfBirth == null
                    ? Colors.grey.withOpacity(0.6)
                    : Colors.black,
                fontSize: 14,
              ),
            ),
            const Icon(
              Icons.date_range,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }

  Container buildDropDown() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 20),
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
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        isExpanded: true,
        hint: Text(
          'Select Your Pet Type',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey.withOpacity(0.8),
        ),
        iconSize: 30,
        buttonHeight: 60,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: petsType
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select gender.';
          }
        },
        value: selectedPetsType,
        onChanged: (value) {
          //Do something when changing the item if you want.
          selectedPetsType = value.toString();
          print(selectedPetsType);
        },
        onSaved: (value) {},
      ),
    );
  }

  Future<DateTime?> datePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
  }

  Row getGenderRadioButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(top: 20),
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
            child: RadioListTile(
              groupValue: selectedGenderValue,
              title: Text(genderItems[0]),
              value: genderItems[0],
              activeColor: MyColors.secondaryColor,
              onChanged: (Object? value) {
                setState(() {
                  selectedGenderValue = value as String?;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            //width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(top: 20),
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
            child: RadioListTile(
              groupValue: selectedGenderValue,
              title: Text(genderItems[1]),
              value: genderItems[1],
              activeColor: MyColors.secondaryColor,
              onChanged: (Object? value) {
                setState(() {
                  selectedGenderValue = value as String?;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Expanded buildPriceTextField() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: 'Price',
              keyboardType: TextInputType.number,
              controller: priceController,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            '\$',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: MyColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Expanded buildWeightTextField() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: 'Weight',
              keyboardType: TextInputType.number,
              controller: weightController,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Kg',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Container buildDescriptionTextField() {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 5),
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
        controller: descriptionController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Description',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.primaryColor,
      ),
    );
  }
}
