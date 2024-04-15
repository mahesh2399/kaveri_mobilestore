import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/cart/screen/cart_widget.dart';
import 'package:kaveri/common/card_product/card.dart';
import 'package:kaveri/common/header.dart';
import 'package:kaveri/common/widgets/bottom_sheet_widget.dart';
import 'package:kaveri/common/widgets/custom_button.dart';
import 'package:kaveri/common/widgets/message_util.dart';
import 'package:kaveri/common/widgets/text_field_widget.dart';
import 'package:kaveri/cart/data/cart_utils_service.dart';
import 'package:kaveri/constants/item_in_cart.dart';
import 'package:kaveri/products/product_model/product_model.dart';
import 'package:string_validator/string_validator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> isSelected = [false, false, false];
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  String? dropdownValue;

  String selectedCellText = 'Cash';

  Widget buildCell(String text) {
    bool isSelected = selectedCellText == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCellText = text;
        });
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 75.w,
          height: 27,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            color: isSelected ? Colors.green : Colors.transparent,
            // borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

//scaffold key
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//user detail list
  List<UserDetailModel> userDataList = [];
//selected user
  UserDetailModel? selectedUser;
//created user data for new customer
  UserDetailModel? createdUserData;
//textediting controller for search user
  TextEditingController searchUserController = TextEditingController();
  //selected int for the existing, new and guest customer
  int selectedCustomerType = 2;

  //cart details
  CartModel cartData =
      CartModel(productsList: [], subTotal: 0, tax: 0, grandTotal: 0);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, cartState) {
          switch (cartState.runtimeType) {
            case CartUserSearchLoadedState:
              userDataList =
                  (cartState as CartUserSearchLoadedState).userDataList;
              break;
            case CartUserCreatedState:
              createdUserData = (cartState as CartUserCreatedState).userData;
              break;
            case CartLoaded:
              cartData = (cartState as CartLoaded).cartData;
              break;
            default:
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildContainer(
                            index: 0,
                            icon: CupertinoIcons.person_2_fill,
                            title1: 'Existing \nCustomer'),
                        buildContainer(
                            index: 1,
                            icon: CupertinoIcons.person_solid,
                            title1: 'New \nCustomer'),
                        buildContainer(
                            index: 2,
                            icon: CupertinoIcons.person_circle_fill,
                            title1: 'Guest \nCustomer'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Builder(
                      builder: (context) {
                        if (selectedCustomerType == 0) {
                          return Column(
                            children: [
                              KTextformField(
                                isLabelNameVisible: false,
                                labelText: 'Enter mobile number or name',
                                validator: null,
                                enabled: selectedUser == null,
                                controller: searchUserController,
                                keyboardType: TextInputType.name,
                                prefixIcon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                onChanged: (val) {
                                  String value = val.trim();
                                  if (value != '') {
                                    context
                                        .read<CartBloc>()
                                        .add(CartSearchUserEvent(
                                          searchQuery: value,
                                        ));
                                  } else {
                                    setState(() {
                                      userDataList.clear();
                                    });
                                  }
                                },
                              ),
                              Visibility(
                                visible: userDataList.isNotEmpty &&
                                    searchUserController.text.isNotEmpty,
                                child: SizedBox(
                                  height: 300.h,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userDataList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // showBottomSheetForUser(
                                          //     context: context,
                                          //     userDetail: userDataList[index]);
                                          setState(() {
                                            selectedUser = userDataList[index];
                                            userDataList.clear();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Name: ${userDataList[index].name}"),
                                              Text(
                                                  "Mobile: ${userDataList[index].mobileNumber}"),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selectedUser != null,
                                child: ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text(
                                    selectedUser?.name ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle:
                                      Text(selectedUser?.mobileNumber ?? ''),
                                  trailing: IconButton(
                                      iconSize: 17.r,
                                      onPressed: () {
                                        setState(() {
                                          selectedUser = null;
                                          searchUserController.clear();
                                        });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              )
                            ],
                          );
                        } else if (selectedCustomerType == 1) {
                          return Column(
                            children: [
                              Visibility(
                                visible: createdUserData == null,
                                child: CustomButton(
                                    text: 'Create New User',
                                    onTap: () {
                                      showBottomSheetForCreateUser(
                                          context: context);
                                    },
                                    bgcolor: createdUserData == null
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 161, 255, 164)),
                              ),
                              ShowUserWithVisibilityWidget(
                                createdUserData: createdUserData,
                                onDeletePressed: () {
                                  setState(() {
                                    createdUserData = null;
                                  });
                                },
                              )
                            ],
                          );
                        } else if (selectedCustomerType == 2) {
                          return const Text('guest');
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: const Color.fromARGB(255, 46, 128, 49),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Item',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                color: const Color.fromARGB(255, 46, 128, 49),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                color: const Color.fromARGB(255, 46, 128, 49),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Price',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                color: const Color.fromARGB(255, 46, 128, 49),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Action',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: const Color.fromARGB(255, 172, 228, 174),
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: cartData.productsList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ProductsInCartWidget(
                                    products: cartData.productsList[index],
                                    index: index,
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SubTotal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartData.subTotal.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartData.tax.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Shipping Charges',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      height: 40,
                                      // padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 46, 128, 49),
                                        ), // Border color
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: TextFormField(
                                          initialValue: '0',
                                          // '200rs',
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(5),
                                            hintStyle: TextStyle(fontSize: 12),
                                            border: InputBorder.none,
                                          ),

                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartData.grandTotal.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 46, 128, 49),
                                          ), // Border color
                                        ),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter value',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 46, 128, 49),
                                          ), // Border color
                                        ),
                                        child: DropdownButton<String>(
                                          underline: Text(''),
                                          value: dropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                          items: <String>['Fixed', 'Percent %']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 46, 128, 49),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    'Cash',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 46, 128, 49),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: const Text(
                                          'Complete Order',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // void showBottomSheetForUser({
  //   required BuildContext context,
  //   required UserDetailModel userDetail,
  // }) {
  //   TextEditingController addressController = TextEditingController();
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         return BottomSheetHalf(
  //             child: SingleChildScrollView(
  //           child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  //               child: Column(
  //                 children: [
  //                   KTextformField(
  //                     labelText: 'Name',
  //                     validator: null,
  //                     controller: TextEditingController(text: userDetail.name),
  //                     keyboardType: TextInputType.none,
  //                     enabled: false,
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   KTextformField(
  //                     labelText: 'Phone',
  //                     validator: null,
  //                     controller:
  //                         TextEditingController(text: userDetail.mobileNumber),
  //                     keyboardType: TextInputType.none,
  //                     enabled: false,
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   KTextformField(
  //                     labelText: 'Address',
  //                     validator: null,
  //                     maxline: 3,
  //                     controller: addressController,
  //                     keyboardType: TextInputType.streetAddress,
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                 ],
  //               )),
  //         ));
  //       });
  //     },
  //   );
  // }

  void showBottomSheetForCreateUser({
    required BuildContext context,
  }) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController mobileNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

        return StatefulBuilder(builder: (context, setState) {
          return BottomSheetHalf(
              child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      KTextformField(
                        labelText: 'Name',
                        validator: (value) {
                          String? val = value?.trim();
                          if (val != null && val.isEmpty) {
                            return 'Please enter name';
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      KTextformField(
                        labelText: 'Email ID',
                        validator: (val) => val == null || val.isEmpty
                            ? "Please enter your email"
                            : !isEmail(val)
                                ? "Please enter a valid email"
                                : null,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      KTextformField(
                        labelText: 'Mobile Number',
                        validator: (val) {
                          if (val == null || val.isEmpty || val.length != 8) {
                            return "Please enter a 10 digit  mobile number";
                          }
                          return null;
                        },
                        inputFormate: [
                          LengthLimitingTextInputFormatter(8),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        prefixIcon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('+968'),
                          ],
                        ),
                        controller: mobileNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      KTextformField(
                        labelText: 'Address',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter address";
                          }
                          return null;
                        },
                        maxline: 3,
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: 'Create',
                        onTap: () {
                          final isvalidform = _formKey.currentState!.validate();
                          if (isvalidform) {
                            //TODO call bloc for creating the user
                            context.read<CartBloc>().add(CartCreateNewUserEvent(
                                uerName: nameController.text.trim(),
                                mobileNumber:
                                    mobileNumberController.text.trim(),
                                emailId: emailController.text.trim(),
                                address: addressController.text.trim()));
                            Navigator.of(context).pop();
                          } else {
                            showsuccesstop(
                                context: context,
                                text: 'Please fill all the mandetry fields',
                                icon: const Icon(CupertinoIcons.drop_triangle),
                                iconColor: Colors.red);
                          }
                        },
                        bgcolor: Colors.green,
                      ),
                    ],
                  ),
                )),
          ));
        });
      },
    );
  }

  Widget buildContainer({
    required int index,
    required IconData icon,
    required String title1,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCustomerType = index;
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      child: CustomCard(
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        color: isSelected[index] ? Colors.green : Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8.0)),
        ),
        child: SizedBox(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(65),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    color: isSelected[index]
                        ? Colors.white
                        : const Color.fromRGBO(15, 117, 0, 1),
                    size: ScreenUtil().setWidth(20),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(2)),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      title1,
                      style: TextStyle(
                        color: isSelected[index]
                            ? Colors.white
                            : const Color.fromRGBO(15, 117, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableCell(List<String> columnData) {
    return TableRow(
      children: columnData.map((text) {
        return TableCell(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(color: Colors.white),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  //  buildTableRow(List<dynamic> rowData) {
  //   return TableRow(
  //     children: rowData.map((cellData) {
  //       return TableCell(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: cellData is String ? Text(cellData) : cellData,
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildQuantityRow() {
    return Container(
      height: ScreenUtil().setHeight(25),
      width: 18.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: decreaseQuantity,
              icon: Icon(
                Icons.remove,
                size: ScreenUtil().setWidth(9),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              // Aligns the quantity text in the center
              child: Text(
                '$quantity',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(9),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: increaseQuantity,
              icon: Icon(
                Icons.add,
                size: ScreenUtil().setWidth(9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget belowContainerr(
      int index, IconData icon, String title1, String title2) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      child: CustomCard(
        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        color: isSelected[index] ? Colors.green : Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8.0)),
        ),
        child: SizedBox(
          height: ScreenUtil().setHeight(8), // Adjusted height
          width: ScreenUtil().setWidth(5), // Adjusted width
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected[index]
                      ? Colors.white
                      : const Color.fromRGBO(15, 117, 0, 1),
                  size: ScreenUtil().setWidth(20),
                ),
                SizedBox(height: ScreenUtil().setHeight(2)),
                Text(
                  title1,
                  style: TextStyle(
                    color: isSelected[index]
                        ? Colors.white
                        : const Color.fromRGBO(15, 117, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp, // Adjusted font size
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(1)),
                Text(
                  title2,
                  style: TextStyle(
                    color: isSelected[index]
                        ? Colors.white
                        : const Color.fromRGBO(15, 117, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp, // Adjusted font size
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
