import 'package:flutter/material.dart';
import 'package:first_app/models/ticket.dart';
import 'package:first_app/widgets/create_ticket.dart';
import 'package:first_app/screens/organiser_dashboard/ce_3_edit_bank_information_page.dart';

class TicketManagementScreen extends StatefulWidget {
  
  final String eventName;
  final String location;
  final String description;
  final String type;
  final int capacity;
  final DateTime startDateTime;
  final DateTime endDateTime;

  TicketManagementScreen({
    required this.eventName,
    required this.location,
    required this.description,
    required this.type,
    required this.capacity,
    required this.startDateTime,
    required this.endDateTime,
  });

  @override
  State<TicketManagementScreen> createState() => _TicketManagementScreenState();
}

class _TicketManagementScreenState extends State<TicketManagementScreen> {
  DateTime? salesStart;
  DateTime? salesEnd;
  List<TicketDTO> tickets = [];

  // Helper to pick a date.
  Future<DateTime?> _pickDate(DateTime? initialDate) async {
    DateTime now = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
  }

  Future<void> _selectSalesStart() async {
    final DateTime? picked = await _pickDate(salesStart);
    if (picked != null) {
      setState(() {
        salesStart = picked;
      });
    }
  }

  Future<void> _selectSalesEnd() async {
    final DateTime? picked = await _pickDate(salesEnd ?? salesStart);
    if (picked != null) {
      setState(() {
        salesEnd = picked;
      });
    }
  }

  // Opens the ticket creation pop-up.
  Future<void> _openCreateTicketDialog() async {
    if (salesStart == null || salesEnd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both sales start and end dates.')),
      );
      return;
    }
    final TicketDTO? newTicket = await showDialog<TicketDTO>(
      context: context,
      builder: (context) => CreateTicketDialog(
        salesStart: salesStart!,
        salesEnd: salesEnd!,
      ),
    );
    if (newTicket != null) {
      setState(() {
        tickets.add(newTicket);
      });
    }
  }

  String _formatDate(DateTime? date) {
    return date == null ? 'Not selected' : date.toLocal().toString().split(' ')[0];
  }
  
  void _onContinue(){
    if (salesStart == null || salesEnd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both sales start and end dates.')),
      );
      return;
    }
    if (tickets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one ticket.')),
      );
      return;
    }
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => EditBankInformationPage(
          eventName: widget.eventName,
          location: widget.location,
          description: widget.description,
          type: widget.type,
          capacity: widget.capacity,
          startDateTime: widget.startDateTime,
          endDateTime: widget.endDateTime,
          tickets: tickets,
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sales Start Date
            Row(
              children: [
                Expanded(child: Text('Sales Start: ${_formatDate(salesStart)}')),
                ElevatedButton(
                  onPressed: _selectSalesStart,
                  child: const Text('Select Start'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Sales End Date
            Row(
              children: [
                Expanded(child: Text('Sales End: ${_formatDate(salesEnd)}')),
                ElevatedButton(
                  onPressed: _selectSalesEnd,
                  child: const Text('Select End'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _openCreateTicketDialog,
              child: const Text('Add Ticket'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: tickets.isEmpty
                  ? const Center(child: Text('No tickets added yet.'))
                  : ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        return ListTile(
                          title: Text(ticket.name),
                          subtitle: Text(
                              'Price: ${ticket.price}, Quantity: ${ticket.quantityTotal}'),
                        );
                      },
                    ),
            ),
            ElevatedButton( 
              onPressed: _onContinue,
              child: const Text('Continue'),
            ),
            
          ],
        ),
      ),
    );
  }
}
