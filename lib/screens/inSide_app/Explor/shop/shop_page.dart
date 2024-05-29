import 'dart:developer';

import 'package:adalato_app/models/shop_model.dart';
import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final CollectionReference _shopitemsCollectionRef =
  FirebaseFirestore.instance.collection('shop_items');
  TextEditingController _searchController = TextEditingController();
  List<ShopItemModel> shopItems = [];

  // [
  //   {'name': 'Product 1', 'price': '\$10'},
  //   {'name': 'Product 2', 'price': '\$20'},
  //   {'name': 'Product 3', 'price': '\$30'},
  //   {'name': 'Product 4', 'price': '\$40'},
  //   {'name': 'Product 5', 'price': '\$50'},
  // ];

  List<ShopItemModel> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = shopItems;
    _searchController.addListener(_filterItems);
    fetchShopTitles();
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = shopItems.where((item) {
        return item.itemName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Add filter functionality
              Navigator.pushNamed(context, AppRoutes.shopFilter);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shopItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.shopItem);
                  },
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                    // Image.network('image_url') would be here
                  ),
                  title: Text(shopItems[index].itemName),
                  subtitle: Text(shopItems[index].price.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> fetchShopTitles() async {
    log(
        "fetchTitles >>>>>>>>>>>>>fetchShopTitles>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${shopItems
            .length}");

    try {
      QuerySnapshot querySnapshot = await _shopitemsCollectionRef.get();

      setState(() {
        shopItems = querySnapshot.docs
            .map((doc) => ShopItemModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>fetchShopTitles>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${shopItems
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>fetchShopTitles>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }
}
