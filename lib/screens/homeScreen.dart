import 'package:flutter/material.dart';
import 'package:tea_trover_admins/global.dart';
import 'collectionEnter.dart'; // Import the new screen

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<Map<String, dynamic>> collectedDetails = [
    {"weight": "15kg", "customerName": "John Doe", "regNumber": "TR12345"},
    {"weight": "20kg", "customerName": "Jane Smith", "regNumber": "TR67890"},
    {"weight": "10kg", "customerName": "Alice Johnson", "regNumber": "TR11223"},
    {"weight": "18kg", "customerName": "Bob Williams", "regNumber": "TR33445"},
  ];

  List<Map<String, dynamic>> filteredDetails = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDetails = collectedDetails;
  }

  void searchCards(String query) {
    final filtered = collectedDetails.where((detail) {
      final customerName = detail['customerName'].toLowerCase();
      final regNumber = detail['regNumber'].toLowerCase();
      final index = collectedDetails.indexOf(detail).toString();
      return customerName.contains(query.toLowerCase()) ||
          regNumber.contains(query.toLowerCase()) ||
          index.contains(query);
    }).toList();

    setState(() {
      filteredDetails = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tea Trover Admin"),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hi, ${userModelCurrrentInfo?.name ?? "User Name"}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      userModelCurrrentInfo?.profilepic ?? "",
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: searchController,
                onChanged: searchCards,
                decoration: InputDecoration(
                  hintText: "Search by Name, Reg. No, or Index",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Driver Collection Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: filteredDetails.length,
                itemBuilder: (context, index) {
                  final detail = filteredDetails[index];
                  final cardIndex = collectedDetails.indexOf(detail);
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      leading: const Icon(Icons.scale, color: Colors.green, size: 40),
                      title: Text(
                        "Weight: ${detail['weight']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            "Customer: ${detail['customerName']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Register No: ${detail['regNumber']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Index: $cardIndex",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigate to the collectionEnter screen when the card is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionEnterScreen(detail: detail),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
