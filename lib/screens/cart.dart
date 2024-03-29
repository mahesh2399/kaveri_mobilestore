import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/common/card_product/card.dart';
import 'package:kaveri/common/header.dart';

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

  List<List<String>> tableRows = [
    ['Item 1', 'Quantity', '10rs'],
    ['Item 2', 'Quantity', '20rs'],
    // Add more rows as needed
  ];
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
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
                        0, Icons.verified_user, 'Existing', 'customer'),
                    buildContainer(1, Icons.shopping_cart, 'Shopping', 'cart'),
                    buildContainer(2, Icons.favorite, 'Favorite', 'item'),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Container(
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
//button goes heare 
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Container(
                            color: Colors.green,
                            width: double.infinity,
                            child: Table(
                              defaultColumnWidth: const IntrinsicColumnWidth(),
                              children: [
                                _buildTableCell(
                                    ['Item', 'Qty', 'Price', 'Action']),
                              ],
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(255, 206, 255, 208),
                            height: ScreenUtil().setHeight(400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Table(
                                  defaultColumnWidth:
                                      const IntrinsicColumnWidth(),
                                  children: [
                                    buildTableRow([
                                      'Item',
                                      buildQuantityRow(),
                                      '10rs',
                                      const Icon(Icons.delete_outline,
                                          size: 20, color: Colors.green),
                                    ]),
                                    buildTableRow([
                                      'Item',
                                      buildQuantityRow(),
                                      '10rs',
                                      const Icon(Icons.delete_outline,
                                          size: 20, color: Colors.green),
                                    ]),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SubTotal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '100rs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tax',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '100rs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Shipping Charge',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.green), // Border color
                                        ),
                                        child: const Text(
                                          '200rs',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Additional Discount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Container(
                                      //   // padding: EdgeInsets.all(8.0),
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.green), // Border color
                                      //   ),
                                      //   child: Text(
                                      //     '',
                                      //     style: TextStyle(fontWeight: FontWeight.bold),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.green), // Border color
                                        ),
                                        child: const Text(
                                          '200',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.green,
                                              ),
                                            ),
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Enter value',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.green,
                                                width: 2,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              value: dropdownValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'One',
                                                'Two',
                                                'Three',
                                                'Four'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child:
                                Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        buildCell('Cash'),
                                        buildCell('Card'),
                                        buildCell('COD'),
                                      ],
                                    ),
                                  ),
                                  // ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 250.w,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              // borderRadius:
                                              //     BorderRadius.circular(8),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Complete Order',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget buildContainer(
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
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        color: isSelected[index] ? Colors.green : Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8.0)),
        ),
        child: Container(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(65),
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
                    fontSize: 12.sp,
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
                    fontSize: 12.sp,
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

  TableRow buildTableRow(List<dynamic> rowData) {
    return TableRow(
      children: rowData.map((cellData) {
        return TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cellData is String ? Text(cellData) : cellData,
          ),
        );
      }).toList(),
    );
  }

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
        child: Container(
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
