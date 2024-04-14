import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  final String itemName; 
  final Widget widgetD;
  final String price;
  const ItemsList({super.key, required this.itemName, required this.widgetD, required this.price});

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
            child: Container(
              width: 65,
              child: Text(itemName,overflow: TextOverflow.ellipsis,),),
          ),
          SizedBox(width: widthh*0.01,),
          SizedBox(
            width: widthh*0.198,
            child: widgetD),
            SizedBox(width: widthh*0.04,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(price),
          ),
            SizedBox(width: widthh*0.11,),
      
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: GestureDetector(
              onTap: (){},
              child: const Icon(Icons.delete),),
          )
      
        ],
      ),
    );
  }
}