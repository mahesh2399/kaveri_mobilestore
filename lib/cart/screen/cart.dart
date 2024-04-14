import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/common/card_product/card.dart';
import 'package:kaveri/common/header.dart';
import 'package:kaveri/constants/item_in_cart.dart';
import 'package:kaveri/products/product_model/product_model.dart';

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

  String dropdownValue = 'One';

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
          margin: EdgeInsets.all(8),
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

  CartModel cartData = CartModel(
      productsList: [], userId: '', subTotal: 0, tax: 0, grandTotal: 0);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(45),
                        child: CustomCard(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            title: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Mobile Number',
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
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
                      : Color.fromRGBO(15, 117, 0, 1),
                  size: ScreenUtil().setWidth(20),
                ),
                SizedBox(height: ScreenUtil().setHeight(2)),
                Text(
                  title1,
                  style: TextStyle(
                    color: isSelected[index]
                        ? Colors.white
                        : Color.fromRGBO(15, 117, 0, 1),
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
                        : Color.fromRGBO(15, 117, 0, 1),
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
