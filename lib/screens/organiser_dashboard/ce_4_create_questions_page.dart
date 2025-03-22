import 'package:flutter/material.dart';
import 'package:first_app/models/question.dart';
import 'package:first_app/widgets/create_question.dart';
import 'package:first_app/models/ticket.dart';

class CreateEventQuestions extends StatefulWidget {

  final String eventName;
  final String location;
  final String description;
  final String type;
  final int capacity;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<TicketDTO> tickets;
  final String accountName;
  final String accountNumber;
  final String bsb;

  const CreateEventQuestions({
    super.key,
    required this.eventName,
    required this.location,
    required this.description,
    required this.type,
    required this.capacity,
    required this.startDateTime,
    required this.endDateTime,
    required this.tickets,
    required this.accountName,
    required this.accountNumber,
    required this.bsb,
  });

  @override
  State<CreateEventQuestions> createState() =>
      _CreateEventQuestionsScreenState();
}

class _CreateEventQuestionsScreenState extends State<CreateEventQuestions> {
  // List to store added questions.
  List< CreateQuestionDTO> questions = [];

  // Opens the pop-up dialog to create a new question.
  Future<void> _openCreateQuestionDialog() async {
    final  CreateQuestionDTO? newQuestion = await showDialog< CreateQuestionDTO>(
      context: context,
      builder: (context) => const CreateQuestionDialog(),
    );
    if (newQuestion != null) {
      setState(() {
        questions.add(newQuestion);
      });
    }
  }

  // Continue button action: check that at least one question is added and navigate.
  void _continue() {
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question.')),
      );
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to add a new question.
            ElevatedButton(
              onPressed: _openCreateQuestionDialog,
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 16),
            // Display list of added questions.
            Expanded(
              child: questions.isEmpty
                  ? const Center(child: Text('No questions added yet.'))
                  : ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return ListTile(
                          title: Text(question.questionText),
                          subtitle: Text(
                              'Required: ${question.isRequired ? "Yes" : "No"}, Order: ${question.displayOrder}'),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            // Continue button.
            ElevatedButton(
              onPressed: _continue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
