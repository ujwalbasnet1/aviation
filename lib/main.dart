import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'flight_barcode_widget.dart';
import 'flight_detail_widget.dart';
import 'flight_summary_widget.dart';
import 'folding_card.dart';
import 'models.dart';

const backgroundColor = Color.fromRGBO(42, 45, 51, 1);

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Ticket Fold Demo';
    return MaterialApp(
      title: title,
      theme: ThemeData.dark().copyWith(
        // primaryColor: Colors.orange,
        colorScheme: const ColorScheme.dark(
          primary: Colors.orange,
        ),
      ),
      home: TicketFoldDemo(),
    );
  }
}

class FoldItem {
  final Widget front;
  Widget? back;
  final double height;

  FoldItem({
    required this.front,
    this.back,
    required this.height,
  }) {
    back = Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(pi),
      child: back,
    );
  }
}

class TicketFoldDemo extends StatefulWidget {
  @override
  _TicketFoldDemoState createState() => _TicketFoldDemoState();
}

class _TicketFoldDemoState extends State<TicketFoldDemo> {
  final List<BoardingPassData> _boardingPasses = DemoData().boardingPasses;

  int? _openTickets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: (250 + 250 + 56 + 24 + 20 + 125),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              // controller: _scrollController,
              onPageChanged: (_) {},
              controller: PageController(
                viewportFraction: 1,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: _boardingPasses.length,
              itemBuilder: (BuildContext context, int index) {
                return FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Container(
                    padding: const EdgeInsets.all(12).copyWith(top: 32),
                    width: MediaQuery.of(context).size.width,
                    child: Ticket(
                      boardingPass: _boardingPasses.elementAt(index),
                      onClick: () => _handleClickedTicket(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _handleClickedTicket(int clickedTicket) {
    // Scroll to ticket position
    // Add or remove the item of the list of open tickets

    if (_openTickets == clickedTicket) {
      Future.delayed(const Duration(milliseconds: 600), () {
        _openTickets = null;
        setState(() {});
      });
    } else {
      _openTickets = clickedTicket;
      setState(() {});
      // });
    }

    return true;
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const Icon(Icons.more_horiz),
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "HOME",
        style: TextStyle(
          fontSize: 15,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        CircleAvatar(radius: 18),
        SizedBox(width: 24),
      ],
    );
  }
}

class Ticket extends StatefulWidget {
  static const double nominalOpenHeight = 400;
  static const double nominalClosedHeight = 160;
  final BoardingPassData boardingPass;
  final Function onClick;

  const Ticket({Key? key, required this.boardingPass, required this.onClick})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  FlightSummary? frontCard;
  FlightSummary? topCard;
  late FlightDetails middleCard;
  late FlightDetails2 middleCard2;
  late FlightBarcode bottomCard;
  late bool _isOpen;

  Widget get backCard => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: const Color.fromRGBO(25, 31, 36, 1.0),
        ),
      );

  @override
  void initState() {
    super.initState();
    _isOpen = false;

    frontCard = FlightSummary(boardingPass: widget.boardingPass);
    middleCard = FlightDetails(boardingPass: widget.boardingPass);
    middleCard2 = FlightDetails2(boardingPass: widget.boardingPass);
    bottomCard = const FlightBarcode();
  }

  @override
  Widget build(BuildContext context) {
    return FoldingTicket(
      entries: _getEntries(),
      isOpen: _isOpen,
      onClick: _handleOnTap,
    );
  }

  List<FoldEntry> _getEntries() {
    /// HEIGHTs
    /// frontCard, topcard -> 250
    /// middleCard -> 125
    /// middleCard2 -> 125
    /// bottomCard -> 56

    return [
      FoldEntry(height: 250.0, front: frontCard, back: backCard),
      FoldEntry(height: 125, front: middleCard, back: topCard),
      FoldEntry(height: 125, front: middleCard2, back: backCard),
      FoldEntry(height: 56.0, front: bottomCard, back: backCard),
    ];
  }

  void _handleOnTap() {
    widget.onClick();
    setState(() {
      _isOpen = !_isOpen;
      topCard = FlightSummary(
        boardingPass: widget.boardingPass,
        theme: SummaryTheme.dark,
        isOpen: _isOpen,
      );
    });
  }
}

class FoldingTicket extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final List<FoldEntry> entries;
  final void Function()? onClick;
  final Duration? duration;

  const FoldingTicket({
    Key? key,
    this.duration,
    required this.entries,
    this.isOpen = false,
    this.onClick,
  });

  @override
  _FoldingTicketState createState() => _FoldingTicketState();
}

class _FoldingTicketState extends State<FoldingTicket>
    with SingleTickerProviderStateMixin {
  late List<FoldEntry> _entries;
  double _ratio = 0.0;
  late AnimationController _controller;

  double get openHeight =>
      _entries.fold(0.0, (num val, o) => val + o.height) +
      FoldingTicket.padding * 2;

  double get closedHeight => _entries[0].height + FoldingTicket.padding * 2;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_tick);
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(FoldingTicket oldWidget) {
    // Opens or closes the ticked if the status changed
    _updateFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: closedHeight +
          (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(child: _buildEntry(0)),
    );
  }

  Widget _buildEntry(int index) {
    FoldEntry entry = _entries[index];
    int count = _entries.length - 1;
    double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));

    Matrix4 mtx = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..rotateX(pi * (ratio - 1.0));

    Widget card = SizedBox(
      height: entry.height,
      child: ratio < 0.5 ? entry.back : entry.front,
    );

    return Transform(
      alignment: Alignment.topCenter,
      transform: mtx,
      child: GestureDetector(
        onTap: widget.onClick,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          // Note: Container supports a transform property, but not alignment for it.
          child: (index == count || ratio <= 0.5)
              ? card
              : // Don't build a stack if it isn't needed.
              Column(
                  children: [
                    card,
                    _buildEntry(index + 1),
                  ],
                ),
        ),
      ),
    );
  }

  void _updateFromWidget() {
    _entries = widget.entries;

    _controller.duration = widget.duration ??
        Duration(
          milliseconds: 2000 * (_entries.length - 1),
        );

    isOpen ? _controller.forward() : _controller.reverse();
  }

  void _tick() {
    setState(() {
      _ratio = Curves.easeInQuad.transform(_controller.value);
    });
  }
}

class FoldEntry {
  final Widget? front;
  Widget? back;
  final double height;

  FoldEntry({required this.front, required this.height, Widget? back}) {
    this.back = Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..rotateX(pi),
        child: back);
  }
}
