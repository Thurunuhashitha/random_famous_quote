import 'package:flutter/material.dart';
import 'dart:math';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final Map<String, List<Map<String, String>>> quotesByCategory = {
    'Motivational': [
      {'quote': 'The only limit to our realization of tomorrow is our doubts of today.', 'author': 'Franklin D. Roosevelt', 'details': 'Self-doubt limits potential.'},
      {'quote': 'Do what you can, with what you have, where you are.', 'author': 'Theodore Roosevelt', 'details': 'Start where you are and improve.'},
    ],
    'Success': [
      {'quote': 'Success usually comes to those who are too busy to be looking for it.', 'author': 'Henry David Thoreau', 'details': 'Hard work leads to success.'},
      {'quote': 'Opportunities don’t happen, you create them.', 'author': 'Chris Grosser', 'details': 'Success comes from taking action.'},
    ],
  };

  final Map<String, String> categoryImages = {
    'Motivational': 'assets/images/motivation.jpeg',
    'Success': 'assets/images/success.jpeg',
  };

  String selectedCategory = 'Motivational';
  Map<String, String> currentQuote = {};

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  void _getRandomQuote() {
    final quotes = quotesByCategory[selectedCategory]!;
    setState(() {
      currentQuote = quotes[Random().nextInt(quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Famous Quote Generator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              items: quotesByCategory.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  _getRandomQuote();
                });
              },
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                categoryImages[selectedCategory]!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '\"${currentQuote['quote']}\"',
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- ${currentQuote['author']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getRandomQuote,
              child: Text('New Quote'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailScreen(quote: currentQuote, imagePath: categoryImages[selectedCategory]!),
                  ),
                );
              },
              child: Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteDetailScreen extends StatelessWidget {
  final Map<String, String> quote;
  final String imagePath;

  QuoteDetailScreen({required this.quote, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quote Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '\"${quote['quote']}\"',
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- ${quote['author']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              quote['details']!,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
