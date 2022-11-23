import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/order_provider.dart';

import '../../../theme/my_colors.dart';

class OrderPopMenuButton extends StatelessWidget {
  final String orderId;

  const OrderPopMenuButton({Key? key, required this.orderId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 12, 3, 0),
      child: PopupMenuButton(
        child: Icon(
          Icons.more_vert,
          color: MyColors.primaryColor,
        ),
        itemBuilder: (_) {
          return <PopupMenuItem>[
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline_sharp,
                    size: 20,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Delete',
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              value: 'delete',
            ),
          ];
        },
        onSelected: (val) {
          if (val == 'delete') {
            Provider.of<OrderProvider>(context, listen: false)
                .deleteOrder(context, orderId);
          }
        },
      ),
    );
  }
}
