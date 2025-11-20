import 'package:flutter/material.dart';

void main() {
  runApp(MyShopMini());
}

class MyShopMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop Mini',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        cardColor: Colors.white12,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

//
// ────────────────────────────────────────────────────────────
//   HOME SCREEN
// ────────────────────────────────────────────────────────────
//
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.fastfood, "label": "Makanan"},
    {"icon": Icons.local_drink, "label": "Minuman"},
    {"icon": Icons.devices, "label": "Elektronik"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop Mini"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Pilih Kategori",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            //
            // Category Buttons
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductListScreen(selectedCategory: cat["label"]),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(cat["icon"], size: 40, color: Colors.amber),
                        const SizedBox(height: 10),
                        Text(cat["label"]),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ────────────────────────────────────────────────────────────
//   PRODUCT LIST SCREEN
// ────────────────────────────────────────────────────────────
//
class ProductListScreen extends StatelessWidget {
  final String selectedCategory;

  ProductListScreen({required this.selectedCategory});

  final List<Map<String, dynamic>> products = List.generate(
    6,
    (index) => {
      "name": "Produk ${index + 1}",
      "price": 10000 + (index * 5000),
      "icon": Icons.shopping_bag,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            var product = products[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(product["icon"], size: 50, color: Colors.amber),
                    const SizedBox(height: 10),
                    Text(product["name"],
                        style: const TextStyle(fontSize: 16)),
                    Text("Rp ${product["price"]}",
                        style: const TextStyle(color: Colors.greenAccent)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//
// ────────────────────────────────────────────────────────────
//   PRODUCT DETAIL SCREEN
// ────────────────────────────────────────────────────────────
//
class ProductDetailScreen extends StatelessWidget {
  final Map product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product["name"]),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(product["icon"], size: 120, color: Colors.amber),
            const SizedBox(height: 20),
            Text(
              product["name"],
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 10),
            Text(
              "Rp ${product["price"]}",
              style:
                  const TextStyle(fontSize: 22, color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
