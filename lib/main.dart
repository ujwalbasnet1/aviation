import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';

import 'package:markdown/markdown.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // HomeAnother(),
          const MyHomePage(title: 'Demo Flutter HTML Editor'),
    );
  }
}

class HomeAnother extends StatelessWidget {
  const HomeAnother({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          print("YAYA another");

          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.orangeAccent,
          body: Center(
            child: TextFormField(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final quill.QuillController _controller = quill.QuillController.basic();

  String quillDeltaToHtml(quill.Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltaToMarkdown(convertedValue);
    print("MARKdown $markdown");
    final html = markdownToHtml(markdown);

    return html;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          InkWell(
            onTap: () {
              final html = quillDeltaToHtml(_controller.document.toDelta());
              print(html);
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orangeAccent,
              width: double.infinity,
              child: quill.QuillToolbar(
                children: [
                  quill.ToggleStyleButton(
                    attribute: quill.Attribute.bold,
                    icon: Icons.format_bold,
                    controller: _controller,
                  ),
                  quill.ToggleStyleButton(
                    attribute: quill.Attribute.italic,
                    icon: Icons.format_italic,
                    controller: _controller,
                  ),
                  quill.ToggleStyleButton(
                    attribute: quill.Attribute.underline,
                    icon: Icons.format_underline,
                    controller: _controller,
                  ),
                  quill.ClearFormatButton(
                    icon: Icons.format_clear,
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: quill.QuillEditor.basic(
              controller: _controller,
              readOnly: false, // true for view only mode
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
