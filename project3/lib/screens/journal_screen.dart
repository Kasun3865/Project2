import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final List<String> entries = [
    "Today, I felt a renewed sense of energy. After completing my morning routine, I took a moment to reflect on my goals...",
    "It was a challenging day, but I managed to keep a positive mindset. I realized how important it is to focus on progress...",
    "Gratitude has been a key part of my journey. I listed three things I'm grateful for, and it really uplifted my spirits...",
    "I had a productive day, working on both personal and professional growth. Staying focused on my wellness goals has been rewarding..."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            return JournalEntry(
              text: entries[index],
            );
          },
        ),
      ),
    );
  }
}

class JournalEntry extends StatefulWidget {
  final String text;

  const JournalEntry({Key? key, required this.text}) : super(key: key);

  @override
  _JournalEntryState createState() => _JournalEntryState();
}

class _JournalEntryState extends State<JournalEntry> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [Colors.blueAccent, Colors.lightBlueAccent]
                : [
                    const Color.fromARGB(255, 22, 177, 99),
                    const Color.fromARGB(255, 71, 241, 148)
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
