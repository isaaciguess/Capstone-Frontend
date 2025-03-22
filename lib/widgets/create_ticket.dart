import 'package:flutter/material.dart';
import 'package:first_app/models/ticket.dart';

class CreateTicketDialog extends StatefulWidget {
  final DateTime salesStart;
  final DateTime salesEnd;

  const CreateTicketDialog({
    super.key,
    required this.salesStart,
    required this.salesEnd,
  });

  @override
  State<CreateTicketDialog> createState() => _CreateTicketDialogState();
}

class _CreateTicketDialogState extends State<CreateTicketDialog> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  String price = '';
  String quantity = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Ticket'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ticket Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ticket Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter ticket name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!.trim(),
              ),
              const SizedBox(height: 8),
              // Description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter description';
                  }
                  return null;
                },
                onSaved: (value) => description = value!.trim(),
              ),
              const SizedBox(height: 8),
              // Price
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter price';
                  }
                  if (double.tryParse(value.trim()) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => price = value!.trim(),
              ),
              const SizedBox(height: 8),
              // Quantity
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter quantity';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'Enter a valid integer';
                  }
                  return null;
                },
                onSaved: (value) => quantity = value!.trim(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cancel
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState!.save();
              final ticket = TicketDTO(
                name: name,
                description: description,
                price: double.parse(price),
                quantityTotal: int.parse(quantity),
                salesStart: widget.salesStart,
                salesEnd: widget.salesEnd,
              );
              Navigator.pop(context, ticket);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}