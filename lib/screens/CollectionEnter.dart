import 'package:flutter/material.dart';

class CollectionEnterScreen extends StatefulWidget {
  final Map<String, dynamic> detail;

  const CollectionEnterScreen({super.key, required this.detail});

  @override
  _CollectionEnterScreenState createState() => _CollectionEnterScreenState();
}

class _CollectionEnterScreenState extends State<CollectionEnterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController bagQuantityController = TextEditingController();
  TextEditingController cutoffWeightController = TextEditingController();

  // Fields to display and approve driver details
  TextEditingController netWeightController = TextEditingController();
  TextEditingController adminBagQuantityController = TextEditingController();
  TextEditingController adminCutoffWeightController = TextEditingController();

  bool isApproved = false; // To track whether admin approved the details
  bool isDriverDetailEditMode = false; // To track if the driver can edit details

  @override
  void initState() {
    super.initState();
    // Pre-fill weight from the driver's input
    weightController.text = widget.detail['weight'];
    bagQuantityController.text = widget.detail['bagQuantity'] ?? '';
    cutoffWeightController.text = widget.detail['cutoffWeight'] ?? '';
  }

  void approveDetails() {
    setState(() {
      isApproved = true; // Mark the details as approved
    });
  }

  void submitDetails() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, submit data
      String weight = weightController.text;
      String bagQuantity = adminBagQuantityController.text;
      String cutoffWeight = adminCutoffWeightController.text;

      // Normally, you'd send this data to a backend or update local state
      print("Admin Submitted: Weight: $weight, Bag Quantity: $bagQuantity, Cutoff Weight: $cutoffWeight");

      // After submission, navigate back to the Homescreen
      Navigator.pop(context);
    }
  }

  void toggleDriverEditMode() {
    setState(() {
      isDriverDetailEditMode = !isDriverDetailEditMode; // Toggle edit mode for driver details
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Collection Details"),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the driver's submitted details at the top
              Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Driver's Submitted Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Weight: ${widget.detail['weight']}", style: TextStyle(fontSize: 16)),
                      Text("Bag Quantity: ${widget.detail['bagQuantity'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
                      Text("Cutoff Weight: ${widget.detail['cutoffWeight'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: toggleDriverEditMode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(isDriverDetailEditMode ? "Save Driver Details" : "Edit Driver Details"),
                      ),
                    ],
                  ),
                ),
              ),
              if (isDriverDetailEditMode) ...[
                // Driver Input Section to modify their details
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: weightController,
                        decoration: const InputDecoration(labelText: "Weight (Driver Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter weight';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: bagQuantityController,
                        decoration: const InputDecoration(labelText: "Bag Quantity (Driver Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter bag quantity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cutoffWeightController,
                        decoration: const InputDecoration(labelText: "Cutoff Weight (Driver Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter cutoff weight';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              // Admin approves the details and adds their own input
              ElevatedButton(
                onPressed: approveDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(isApproved ? "Details Approved" : "Approve Driver Details"),
              ),
              if (isApproved) ...[
                // Admin Input Section appears after approval
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: netWeightController,
                        decoration: const InputDecoration(labelText: "Net Weight (Admin Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter net weight';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: adminBagQuantityController,
                        decoration: const InputDecoration(labelText: "Bag Quantity (Admin Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter bag quantity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: adminCutoffWeightController,
                        decoration: const InputDecoration(labelText: "Cutoff Weight (Admin Input)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter cutoff weight';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: submitDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("Submit Admin Details"),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Prompt admin to approve first before entering details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Please approve the driver's details before entering the net weight and bag quantity.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
