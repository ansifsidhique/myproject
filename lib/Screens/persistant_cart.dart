import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/widgets/network_image_widget.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class PersistantCart extends StatefulWidget {
  const PersistantCart({super.key});

  @override
  State<PersistantCart> createState() => _PersistantCartState();
}

class _PersistantCartState extends State<PersistantCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Expanded(
                  child: PersistentShoppingCart().showCartItems(
                      cartTileWidget: ({required data}) => Card(
                            child: Row(
                              children: [
                                NetWorkImageWidget(
                                  imageUrl: data.productId,
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(
                                        data.productName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      Text(data.productDescription.toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(children: [
                                        Text(r"$ " + data.unitPrice.toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              PersistentShoppingCart()
                                                  .removeFromCart(
                                                      data.productId);
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ])
                                    ])),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          PersistentShoppingCart()
                                              .incrementCartItemQuantity(
                                                  data.productId);
                                        },
                                        icon: const Icon(Icons.add)),
                                    Text(data.quantity.toString()),
                                    IconButton(
                                        onPressed: () {
                                          PersistentShoppingCart()
                                              .decrementCartItemQuantity(
                                                  data.productId);
                                        },
                                        icon: const Icon(Icons.remove)),
                                  ],
                                )
                              ],
                            ),
                          ),
                      showEmptyCartMsgWidget: const Text("Cart is Empty")),
                ),
                PersistentShoppingCart().showTotalAmountWidget(
                    cartTotalAmountWidgetBuilder: (totalAmount){
                      return Visibility(
                          visible: totalAmount==0.0 ? false:true ,
                          child: Text(totalAmount.toString()));
                    })
              ]))),
    );
  }
}
