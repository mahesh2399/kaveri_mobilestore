import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController? shippingController = TextEditingController(text: '0');

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

  String? selectedDiscount;
  String? taxValue;
  String? selectStatus;

  String selectedCellText = 'Cash';
  int grandTootal = 0;
  int grandToootal = 0;

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
//shiping charges controller
  TextEditingController shipingChargesController = TextEditingController();
//shiping charges controller
  TextEditingController discountController = TextEditingController();
  //cart details

  CartModel cartData = CartModel(
    discountType: null,
    shipmentCharges: 0,
    productsList: [],
    subTotal: 0,
    tax: 0,
    grandTotal: 0,
    discount: 0,
  );
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
              discountController.text =
                  cartData.discount == 0.0 ? '' : cartData.discount.toString();
              selectedDiscount = cartData.discountType;
              shipingChargesController.text =
                  cartData.shipmentCharges.round() == 0
                      ? ''
                      : cartData.shipmentCharges.round().toString();
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
                          return KTextformField(
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
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(
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
                                    'Name',
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
                              flex: 1,
                              child: Container(
                                color: const Color.fromARGB(255, 46, 128, 49),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Unit',
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
                                    'Total',
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductsInCartWidget(
                                    products: cartData.productsList[index],
                                    index: index,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'SubTotal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartData.subTotal.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //TODO tax commented
                              // Padding(
                              //   padding: const EdgeInsets.all(10),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text(
                              //         'Tax',
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //       // Text(
                              //       //   cartData.tax.toString(),
                              //       //   style: const TextStyle(
                              //       //     fontWeight: FontWeight.bold,
                              //       //   ),
                              //       // ),
                              //       Container(
                              //         height: 40,
                              //         width: 100,
                              //         padding: const EdgeInsets.all(8.0),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(5),
                              //           border: Border.all(
                              //             color: const Color.fromARGB(
                              //                 255, 46, 128, 49),
                              //           ), // Border color
                              //         ),
                              //         child: DropdownButton<String>(
                              //           hint: const Text('Select'),
                              //           underline: const Text(''),
                              //           value: taxValue,
                              //           onChanged: (String? newValue) {
                              //             setState(() {
                              //               taxValue = newValue!;
                              //             });
                              //           },
                              //           items: <String>['VAT 0%', 'VAT 5%']
                              //               .map<DropdownMenuItem<String>>(
                              //                   (String value) {
                              //             return DropdownMenuItem<String>(
                              //               value: value,
                              //               child: Text(value),
                              //             );
                              //           }).toList(),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Shipping Charges',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: KTextformField(
                                        labelText: '0.0',
                                        validator: null,
                                        controller: shipingChargesController,
                                        keyboardType: TextInputType.number,
                                        isLabelNameVisible: false,
                                        inputFormate: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          context.read<CartBloc>().add(
                                              CartAddShipingChargesEvent(
                                                  shipingCharge: value));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: KDropDownButton(
                                        isLabelNameVisible: true,
                                        items: <String>[
                                          'Fixed',
                                          'Percent %'
                                        ] //Do not change the spelling of letter in this because we have used this in bloc for calculation as of now
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        selectedItem: selectedDiscount,
                                        validator: null,
                                        labelText: 'Select Discount',
                                        disabled: false,
                                        isSearchVisible: false,
                                        textEditingController:
                                            discountController,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedDiscount = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: KTextformField(
                                          labelText: 'Enter Value',
                                          validator: null,
                                          controller: discountController,
                                          isLabelNameVisible: true,
                                          onChanged: (val) {},
                                          keyboardType: TextInputType.number),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        flex: 2,
                                        child: CustomButton(
                                            text: 'Apply',
                                            onTap: () {
                                              // String val = discountController
                                              //     .text;
                                              // try {
                                              //   double parsedValue =
                                              //       double.parse(val);
                                              //   setState(() {
                                              //     grandToootal =
                                              //         parsedValue.toInt();
                                              //   });
                                              // } catch (e) {
                                              //   print('Invalid number: $val');
                                              //   setState(() {
                                              //     grandToootal =
                                              //         0; // Set to a default value
                                              //   });
                                              // }
                                              // String value = val.trim();
                                              if (selectedDiscount != null) {
                                                if (discountController.text
                                                        .trim() !=
                                                    '') {
                                                  if (selectedDiscount ==
                                                      'Percent %') {
                                                    if (grandToootal <= 100) {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            CartAddDiscountEvent(
                                                              discountPrice:
                                                                  discountController
                                                                      .text
                                                                      .toString()
                                                                      .trim(),
                                                              disCountType:
                                                                  selectedDiscount!,
                                                            ),
                                                          );
                                                    } else {
                                                      discountController
                                                          .clear();

                                                      showsuccesstop(
                                                          context: context,
                                                          text:
                                                              'Please enter persentage from 0 to 100',
                                                          icon: const Icon(
                                                            CupertinoIcons
                                                                .drop_triangle,
                                                            color: Colors.red,
                                                          ));
                                                    }
                                                  } else if (selectedDiscount ==
                                                      'Fixed') {
                                                    if (grandTootal <=
                                                        cartData.subTotal) {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            CartAddDiscountEvent(
                                                              discountPrice:
                                                                  discountController
                                                                      .text
                                                                      .toString()
                                                                      .trim(),
                                                              disCountType:
                                                                  selectedDiscount!,
                                                            ),
                                                          );
                                                    } else {
                                                      discountController
                                                          .clear();
                                                      showsuccesstop(
                                                          context: context,
                                                          text:
                                                              'Please enter price below ${cartData.grandTotal}',
                                                          icon: const Icon(
                                                            CupertinoIcons
                                                                .drop_triangle,
                                                            color: Colors.red,
                                                          ));
                                                    }
                                                  }
                                                } else {
                                                  context.read<CartBloc>().add(
                                                        CartAddDiscountEvent(
                                                          discountPrice:
                                                              0.0.toString(),
                                                          disCountType:
                                                              selectedDiscount!,
                                                        ),
                                                      );
                                                }
                                              } else {
                                                showsuccesstop(
                                                    context: context,
                                                    text:
                                                        'Please select discount type',
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .drop_triangle,
                                                      color: Colors.red,
                                                    ));
                                              }
                                            },
                                            bgcolor: Colors.green))
                                  ],
                                ),
                              ),
                              const Padding(
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
                                      "0.0",
                                      // "${grandTootal != 0 ? cartData.grandTotal + int.parse(shippingController!.text) : cartData.grandTotal}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Discount',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "0.0",
                                      // "${grandTootal != 0 ? cartData.grandTotal + int.parse(shippingController!.text) : cartData.grandTotal}",
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
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // "${grandTootal != 0 ? cartData.grandTotal + int.parse(shippingController!.text) : cartData.grandTotal}",
                                      '${cartData.grandTotal}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: KDropDownButton(
                                    isLabelNameVisible: false,
                                    items: <String>[
                                      'Order Placed',
                                      'Delivered'
                                    ] //Do not change the spelling of letter in this because we have used this in bloc for calculation as of now
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    selectedItem: selectStatus,
                                    validator: null,
                                    labelText: 'Select Status',
                                    disabled: false,
                                    isSearchVisible: false,
                                    textEditingController: discountController,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectStatus = newValue!;
                                      });
                                    },
                                  ),
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
                                      child: InkWell(
                                        onTap: () {
                                          
                                        },
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
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();

        return StatefulBuilder(builder: (context, setState) {
          return BottomSheetHalf(
              child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: formKey,
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
                          final isvalidform = formKey.currentState!.validate();
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
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: decreaseQuantity,
              icon: Icon(
                Icons.remove,
                size: ScreenUtil().setWidth(9),
              ),
            ),
          ),
          Expanded(
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
          Expanded(
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
