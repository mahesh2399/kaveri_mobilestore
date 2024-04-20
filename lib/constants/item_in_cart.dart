// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/common/widgets/message_util.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/products/product_model/product_model.dart';

class ItemsList extends StatelessWidget {
  final String itemName;
  final Widget widgetD;
  final String price;
  const ItemsList(
      {super.key,
      required this.itemName,
      required this.widgetD,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final widthh = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              width: 65,
              child: Text(
                itemName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: widthh * 0.01,
          ),
          SizedBox(width: widthh * 0.198, child: widgetD),
          SizedBox(
            width: widthh * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(price),
          ),
          SizedBox(
            width: widthh * 0.11,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }
}

class ProductsInCartWidget extends StatelessWidget {
  const ProductsInCartWidget({
    Key? key,
    required this.products,
    required this.index,
  }) : super(key: key);
  final ProductsForCart products;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                products.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              products.unit,
              textAlign: TextAlign.center,
            ),
          )),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        log('isTappe');
                        context.read<CartBloc>().add(
                              CartMinusQuantityEvent(
                                addProduct: products,
                                index: index,
                              ),
                            );
                      },
                      child: Icon(
                        Icons.remove,
                        size: 13.r,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    products.wantedQuantity.toString(),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (products.availableQuantity >
                            products.wantedQuantity) {
                          context.read<CartBloc>().add(
                                CartPlusQuantityEvent(
                                  addProduct: products,
                                  index: index,
                                ),
                              );
                        } else {
                          showsuccesstop(
                              context: context,
                              text: 'Product quantity limit reached');
                        }
                      },
                      child: Icon(
                        Icons.add,
                        size: 13.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),

          // Expanded(
          //   child: IconButton(
          //       onPressed: () {
          //         context.read<CartBloc>().add(RemoveFromCartEvent(products));
          //       },
          //       icon: const Icon(
          //         CupertinoIcons.delete_simple,
          //         color: Colors.green,
          //       )),
          // ),
          Expanded(
            child: Text(
              '${products.price}  ر.ع.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Text(
              '${products.discount}  ر.ع.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 2,
          ),

          Expanded(
            child: Text(
              '${products.price * products.wantedQuantity}  ر.ع.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
