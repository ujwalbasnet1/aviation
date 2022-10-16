import 'package:aviation/ticket_cut.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Ticket Fold Demo';
    return MaterialApp(
      title: title,
      theme: ThemeData.light().copyWith(
        // primaryColor: Colors.orange,
        colorScheme: const ColorScheme.dark(
          primary: Colors.orange,
        ),
      ),
      home: const TicketCut(),
    );
  }
}
