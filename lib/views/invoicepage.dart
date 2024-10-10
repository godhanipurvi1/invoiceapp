import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart'; // Ensure this path is correct

class InvoiceData {
  String invoiceId;
  String name;
  String address;
  String contactNumber;
  String city;
  String companyName;
  String companyAddress;
  List<Item> items;
  double totalPrice;

  InvoiceData({
    required this.invoiceId,
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.city,
    required this.companyName,
    required this.companyAddress,
    required this.items,
    required this.totalPrice,
  });
}

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String _invoiceId = '';
  String _name = '';
  String _address = '';
  String _contactNumber = '';
  String _city = '';
  String _companyName = '';
  String _companyAddress = '';

  XFile? _image;
  final List<Item> _items = [];
  double _totalPrice = 0.0;

  final TextEditingController _invoiceIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();

  void _addItem(String name, double price, int quantity) {
    setState(() {
      _items.add(Item(name: name, price: price, quantity: quantity));
      _updateTotalPrice();
    });
  }

  void _updateTotalPrice() {
    double total = _items.fold(0.0, (sum, item) {
      if (item != null) {
        return sum + (item.price * item.quantity);
      }
      return sum;
    });

    setState(() {
      _totalPrice = total;
    });
  }

  void _showAddItemDialog() {
    String name = '';
    double price = 0.0;
    int quantity = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) => name = value ?? '',
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => price = double.tryParse(value) ?? 0.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addItem(name, price, quantity);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _handleSubmit() {
    final invoiceData = InvoiceData(
      invoiceId: _invoiceId,
      name: _name,
      address: _address,
      contactNumber: _contactNumber,
      city: _city,
      companyName: _companyName,
      companyAddress: _companyAddress,
      items: _items,
      totalPrice: _totalPrice,
    );
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PdfPage(invoiceData),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Invoice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Company logo picker
            Center(
              child: Column(
                children: [
                  if (_image != null)
                    Image.file(
                      File(_image!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  else
                    Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  TextButton(
                    onPressed: _pickImage,
                    child: Text('Pick Company Logo'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Invoice ID TextField
            TextField(
              controller: _invoiceIdController,
              decoration: InputDecoration(
                labelText: 'Invoice ID',
                hintText: 'Enter Invoice ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _invoiceId = value),
            ),
            SizedBox(height: 16.0),
            // Name TextField
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _name = value),
            ),
            SizedBox(height: 16.0),
            // Address TextField
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter Your Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _address = value),
            ),
            SizedBox(height: 16.0),
            // Contact Number TextField
            TextField(
              controller: _contactNumberController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                hintText: 'Enter Your Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _contactNumber = value),
            ),
            SizedBox(height: 16.0),
            // City TextField
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Enter Your City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _city = value),
            ),
            SizedBox(height: 16.0),
            // Company Name TextField
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(
                labelText: 'Company Name',
                hintText: 'Enter Company Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _companyName = value),
            ),
            SizedBox(height: 16.0),
            // Company Address TextField
            TextField(
              controller: _companyAddressController,
              decoration: InputDecoration(
                labelText: 'Company Address',
                hintText: 'Enter Company Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) => setState(() => _companyAddress = value),
            ),
            SizedBox(height: 20.0),
            // Items ListView and Total Price
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(
                                'Quantity: ${item.quantity}, Price: \$${item.price.toStringAsFixed(2)}'),
                            trailing: Text(
                                'Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Total Price: \$${_totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}
