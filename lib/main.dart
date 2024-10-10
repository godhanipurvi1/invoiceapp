import 'package:flutter/material.dart';
import 'package:invoice_app/views/invoicepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _invoices = [];

  void _addInvoice(invoice) {
    setState(() {
      _invoices.add(invoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>p))
        //   }, icon: Icon(Icons.picture_as_pdf))
        // ],
      ),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return ListTile(
            title: Text('Invoice ${invoice.id}'),
            subtitle: Text('Total: \$${invoice.total.toStringAsFixed(2)}'),
            onTap: () {
              // Handle invoice detail view
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvoicePage(
                    // onCreate: _addInvoice
                    )),
          );
        },
      ),
    );
  }
}
