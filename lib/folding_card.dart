// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// const backgroundColor = Color.fromRGBO(42, 45, 51, 1);
//
// void main() => runApp(const App());
//
// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const title = 'Ticket Fold Demo';
//     return MaterialApp(
//       title: title,
//       theme: ThemeData.dark().copyWith(
//         // primaryColor: Colors.orange,
//         colorScheme: const ColorScheme.dark(
//           primary: Colors.orange,
//         ),
//       ),
//       home: TicketFoldDemo(),
//     );
//   }
// }
//
// class FoldItem {
//   final Widget front;
//   Widget? back;
//   final double height;
//
//   FoldItem({
//     required this.front,
//     this.back,
//     required this.height,
//   }) {
//     back = Transform(
//       alignment: FractionalOffset.center,
//       transform: Matrix4.identity()
//         ..setEntry(3, 2, 0.001)
//         ..rotateX(pi),
//       child: back,
//     );
//   }
// }
//
// class TicketFoldDemo extends StatefulWidget {
//   @override
//   _TicketFoldDemoState createState() => _TicketFoldDemoState();
// }
//
// class _TicketFoldDemoState extends State<TicketFoldDemo> {
//   final List<BoardingPassData> _boardingPasses = DemoData().boardingPasses;
//
//   int? _openTickets;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: _buildAppBar(),
//       body: ListView.builder(
//         // padding: const EdgeInsets.all(16),
//         // scrollDirection: Axis.horizontal,
//         // // controller: _scrollController,
//         // onPageChanged: (_) {},
//         // controller: PageController(
//         //   viewportFraction: 0.95,
//         // ),
//         physics: const BouncingScrollPhysics(),
//         itemCount: _boardingPasses.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             padding: const EdgeInsets.all(12),
//             width: MediaQuery.of(context).size.width,
//             child: Ticket(
//               boardingPass: _boardingPasses.elementAt(index),
//               onClick: () => _handleClickedTicket(index),
//             ),
//           );
//         },
//         // separatorBuilder: (BuildContext context, int index) {
//         //   return const SizedBox(height: 8);
//         // },
//       ),
//     );
//   }
//
//   bool _handleClickedTicket(int clickedTicket) {
//     // Scroll to ticket position
//     // Add or remove the item of the list of open tickets
//
//     if (_openTickets == clickedTicket) {
//       Future.delayed(const Duration(milliseconds: 600), () {
//         _openTickets = null;
//         setState(() {});
//       });
//     } else {
//       _openTickets = clickedTicket;
//       setState(() {});
//       // });
//     }
//
//     return true;
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       leading: const Icon(Icons.more_horiz),
//       backgroundColor: backgroundColor,
//       elevation: 0,
//       centerTitle: true,
//       title: const Text(
//         "HOME",
//         style: TextStyle(
//           fontSize: 15,
//           letterSpacing: 0.5,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       actions: const [
//         CircleAvatar(radius: 18),
//         SizedBox(width: 24),
//       ],
//     );
//   }
// }
//
// class Ticket extends StatefulWidget {
//   static const double nominalOpenHeight = 400;
//   static const double nominalClosedHeight = 160;
//   final BoardingPassData boardingPass;
//   final Function onClick;
//
//   const Ticket({Key? key, required this.boardingPass, required this.onClick})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _TicketState();
// }
//
// class _TicketState extends State<Ticket> {
//   FlightSummary? frontCard;
//   FlightSummary? topCard;
//   late FlightDetails middleCard;
//   late FlightBarcode bottomCard;
//   late bool _isOpen;
//
//   Widget get backCard => Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.0),
//           color: const Color.fromRGBO(25, 31, 36, 1.0),
//         ),
//       );
//
//   @override
//   void initState() {
//     super.initState();
//     _isOpen = false;
//     frontCard = FlightSummary(boardingPass: widget.boardingPass);
//     middleCard = FlightDetails(boardingPass: widget.boardingPass);
//     bottomCard = const FlightBarcode();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FoldingTicket(
//       entries: _getEntries(),
//       isOpen: _isOpen,
//       onClick: _handleOnTap,
//     );
//   }
//
//   List<FoldEntry> _getEntries() {
//     return [
//       FoldEntry(height: 250.0, front: topCard),
//       FoldEntry(height: 250.0, front: middleCard, back: frontCard),
//       FoldEntry(height: 56.0, front: bottomCard, back: backCard),
//     ];
//   }
//
//   void _handleOnTap() {
//     widget.onClick();
//     setState(() {
//       _isOpen = !_isOpen;
//       topCard = FlightSummary(
//         boardingPass: widget.boardingPass,
//         theme: SummaryTheme.dark,
//         isOpen: _isOpen,
//       );
//     });
//   }
// }
//
// class FoldingTicket extends StatefulWidget {
//   static double padding = 32.0;
//   final bool isOpen;
//   final List<FoldEntry> entries;
//   final void Function()? onClick;
//   final Duration? duration;
//
//   const FoldingTicket({
//     Key? key,
//     this.duration,
//     required this.entries,
//     this.isOpen = false,
//     this.onClick,
//   });
//
//   @override
//   _FoldingTicketState createState() => _FoldingTicketState();
// }
//
// class _FoldingTicketState extends State<FoldingTicket>
//     with SingleTickerProviderStateMixin {
//   late List<FoldEntry> _entries;
//   double _ratio = 0.0;
//   late AnimationController _controller;
//
//   double get openHeight =>
//       _entries.fold(0.0, (num val, o) => val + o.height) +
//       FoldingTicket.padding * 2;
//
//   double get closedHeight => _entries[0].height + FoldingTicket.padding * 2;
//
//   bool get isOpen => widget.isOpen;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//     _controller.addListener(_tick);
//     _updateFromWidget();
//   }
//
//   @override
//   void didUpdateWidget(FoldingTicket oldWidget) {
//     // Opens or closes the ticked if the status changed
//     _updateFromWidget();
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: closedHeight +
//           (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
//       child: Container(child: _buildEntry(0)),
//     );
//   }
//
//   Widget _buildEntry(int index) {
//     FoldEntry entry = _entries[index];
//     int count = _entries.length - 1;
//     double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));
//
//     Matrix4 mtx = Matrix4.identity()
//       ..setEntry(3, 2, 0.001)
//       ..setEntry(1, 2, 0.2)
//       ..rotateX(pi * (ratio - 1.0));
//
//     Widget card = SizedBox(
//         height: entry.height, child: ratio < 0.5 ? entry.back : entry.front);
//
//     return Transform(
//         alignment: Alignment.topCenter,
//         transform: mtx,
//         child: GestureDetector(
//           onTap: widget.onClick,
//           child: SingleChildScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             // Note: Container supports a transform property, but not alignment for it.
//             child: (index == count || ratio <= 0.5)
//                 ? card
//                 : // Don't build a stack if it isn't needed.
//                 Column(children: [
//                     card,
//                     _buildEntry(index + 1),
//                   ]),
//           ),
//         ));
//   }
//
//   void _updateFromWidget() {
//     _entries = widget.entries;
//     _controller.duration =
//         widget.duration ?? Duration(milliseconds: 2000 * (_entries.length - 1));
//     isOpen ? _controller.forward() : _controller.reverse();
//   }
//
//   void _tick() {
//     setState(() {
//       _ratio = Curves.easeInQuad.transform(_controller.value);
//     });
//   }
// }
//
// class FoldEntry {
//   final Widget? front;
//   Widget? back;
//   final double height;
//
//   FoldEntry({required this.front, required this.height, Widget? back}) {
//     this.back = Transform(
//       alignment: FractionalOffset.center,
//       transform: Matrix4.identity()
//         ..setEntry(3, 2, .001)
//         ..rotateX(pi),
//       child: back,
//     );
//   }
// }
//
// /// card data
//
// class BoardingPassData {
//   String passengerName;
//   _Airport origin;
//   _Airport destination;
//   _Duration duration;
//   TimeOfDay boardingTime;
//   DateTime departs;
//   DateTime arrives;
//   String gate;
//   int zone;
//   String seat;
//   String flightClass;
//   String flightNumber;
//
//   BoardingPassData({
//     required this.passengerName,
//     required this.origin,
//     required this.destination,
//     required this.duration,
//     required this.boardingTime,
//     required this.departs,
//     required this.arrives,
//     required this.gate,
//     required this.zone,
//     required this.seat,
//     required this.flightClass,
//     required this.flightNumber,
//   });
// }
//
// class _Airport {
//   String code;
//   String city;
//
//   _Airport({
//     required this.city,
//     required this.code,
//   });
// }
//
// class _Duration {
//   int hours;
//   int minutes;
//
//   _Duration({
//     required this.hours,
//     required this.minutes,
//   });
//
//   @override
//   String toString() {
//     return '\t${hours}H ${minutes}M';
//   }
// }
//
// class DemoData {
//   final List<BoardingPassData> _boardingPasses = [
//     BoardingPassData(
//         passengerName: 'Ms. Jane Doe',
//         origin: _Airport(code: 'YEG', city: 'Edmonton'),
//         destination: _Airport(code: 'LAX', city: 'Los Angeles'),
//         duration: _Duration(hours: 3, minutes: 30),
//         boardingTime: TimeOfDay(hour: 7, minute: 10),
//         departs: DateTime(2019, 10, 17, 23, 45),
//         arrives: DateTime(2019, 10, 18, 02, 15),
//         gate: '50',
//         zone: 3,
//         seat: '12A',
//         flightClass: 'Economy',
//         flightNumber: 'AC237'),
//     BoardingPassData(
//         passengerName: 'Ms. Jane Doe',
//         origin: _Airport(code: 'YYC', city: 'Calgary'),
//         destination: _Airport(code: 'YOW', city: 'Ottawa'),
//         duration: _Duration(hours: 3, minutes: 50),
//         boardingTime: TimeOfDay(hour: 12, minute: 15),
//         departs: DateTime(2019, 10, 17, 23, 45),
//         arrives: DateTime(2019, 10, 18, 02, 15),
//         gate: '22',
//         zone: 1,
//         seat: '17C',
//         flightClass: 'Economy',
//         flightNumber: 'AC237'),
//     BoardingPassData(
//         passengerName: 'Ms. Jane Doe',
//         origin: _Airport(code: 'YEG', city: 'Edmonton'),
//         destination: _Airport(code: 'MEX', city: 'Mexico'),
//         duration: _Duration(hours: 4, minutes: 15),
//         boardingTime: TimeOfDay(hour: 16, minute: 45),
//         departs: DateTime(2019, 10, 17, 23, 45),
//         arrives: DateTime(2019, 10, 18, 02, 15),
//         gate: '30',
//         zone: 2,
//         seat: '22B',
//         flightClass: 'Economy',
//         flightNumber: 'AC237'),
//     BoardingPassData(
//         passengerName: 'Ms. Jane Doe',
//         origin: _Airport(code: 'YYC', city: 'Calgary'),
//         destination: _Airport(code: 'YOW', city: 'Ottawa'),
//         duration: _Duration(hours: 3, minutes: 50),
//         boardingTime: TimeOfDay(hour: 12, minute: 15),
//         departs: DateTime(2019, 10, 17, 23, 45),
//         arrives: DateTime(2019, 10, 18, 02, 15),
//         gate: '22',
//         zone: 1,
//         seat: '17C',
//         flightClass: 'Economy',
//         flightNumber: 'AC237'),
//   ];
//
//   get boardingPasses => _boardingPasses;
//
//   getBoardingPass(int index) {
//     return _boardingPasses.elementAt(index);
//   }
// }
//
// /// card widgets
//
// class FlightBarcode extends StatelessWidget {
//   const FlightBarcode({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//           color: Color.fromRGBO(25, 31, 36, 1.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(
//             right: 16,
//             left: 16,
//             bottom: 16,
//           ),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               shadowColor: Colors.transparent,
//             ),
//             child: const Text(
//               "Submit",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               // print('Button was pressed');
//             },
//           ),
//         ),
//       );
// }
//
// class FlightDetails extends StatelessWidget {
//   final BoardingPassData boardingPass;
//   final TextStyle titleTextStyle = const TextStyle(
//     fontFamily: 'OpenSans',
//     fontSize: 11,
//     height: 1,
//     letterSpacing: .2,
//     fontWeight: FontWeight.w600,
//     color: Color(0xffafafaf),
//   );
//
//   final TextStyle contentTextStyle = const TextStyle(
//     fontFamily: 'Oswald',
//     fontSize: 16,
//     height: 1.8,
//     letterSpacing: .3,
//     color: Color(0xffeeeeee),
//   );
//
//   const FlightDetails({Key? key, required this.boardingPass}) : super(key: key);
//
//   // const FlightDetails(this.boardingPass);
//
//   @override
//   Widget build(BuildContext context) => Container(
//         decoration: BoxDecoration(
//           color: const Color.fromRGBO(25, 31, 36, 1.0),
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Gate'.toUpperCase(), style: titleTextStyle),
//                       Text(boardingPass.gate, style: contentTextStyle),
//                     ]),
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Zone'.toUpperCase(), style: titleTextStyle),
//                       Text(boardingPass.zone.toString(),
//                           style: contentTextStyle),
//                     ]),
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Seat'.toUpperCase(), style: titleTextStyle),
//                       Text(boardingPass.seat, style: contentTextStyle),
//                     ]),
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Class'.toUpperCase(), style: titleTextStyle),
//                       Text(boardingPass.flightClass, style: contentTextStyle),
//                     ]),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Flight'.toUpperCase(), style: titleTextStyle),
//                       Text(boardingPass.flightNumber, style: contentTextStyle),
//                     ]),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Departs'.toUpperCase(), style: titleTextStyle),
//                     Text(DateFormat("dd MMM yy").format(boardingPass.departs),
//                         style: contentTextStyle),
//                   ],
//                 ),
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Arrives'.toUpperCase(), style: titleTextStyle),
//                       Text(DateFormat("dd MMM yy").format(boardingPass.arrives),
//                           style: contentTextStyle)
//                     ]),
//               ],
//             ),
//           ],
//         ),
//       );
// }
//
// enum SummaryTheme { dark, light }
//
// class FlightSummary extends StatelessWidget {
//   final BoardingPassData boardingPass;
//   final SummaryTheme theme;
//   final bool isOpen;
//
//   const FlightSummary(
//       {Key? key,
//       required this.boardingPass,
//       this.theme = SummaryTheme.light,
//       this.isOpen = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(48, 53, 61, 1.0),
//         borderRadius: BorderRadius.only(
//           topLeft: const Radius.circular(16),
//           topRight: const Radius.circular(16),
//           bottomLeft: Radius.circular(isOpen ? 0 : 16),
//           bottomRight: Radius.circular(isOpen ? 0 : 16),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24.0,
//               vertical: 24.0,
//             ),
//             decoration: BoxDecoration(
//               color: const Color.fromRGBO(25, 29, 34, 1),
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(
//                   DateFormat("dd MMM yy").format(boardingPass.departs),
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     _buildTicketOrigin(),
//                     Text(
//                       boardingPass.duration.toString(),
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white60,
//                       ),
//                     ),
//                     _buildTicketDestination()
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   // color: Colors.blue,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24.0,
//                     vertical: 0,
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             height: 8,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 1,
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.white24,
//                                   Colors.white,
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const Positioned(
//                             left: 0,
//                             child: CircleAvatar(
//                               backgroundColor: Color(0xFF777777),
//                               radius: 4,
//                             ),
//                           ),
//                           const Positioned(
//                             right: 0,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 4,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("1000"),
//                           Text("2230"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.airplanemode_active,
//                         color: Color(0xFFaaaaaa),
//                         size: 16,
//                       ),
//                       const SizedBox(width: 8),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "B747-400",
//                             style:
//                                 Theme.of(context).textTheme.caption?.copyWith(
//                                       color: const Color(0xFFaaaaaa),
//                                     ),
//                           ),
//                           Text(
//                             "G-CIVB",
//                             style:
//                                 Theme.of(context).textTheme.caption?.copyWith(
//                                       color: const Color(0xFFaaaaaa),
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.person,
//                         color: Color(0xFFaaaaaa),
//                         size: 16,
//                       ),
//                       const SizedBox(width: 8),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "R. Moody",
//                             style:
//                                 Theme.of(context).textTheme.caption?.copyWith(
//                                       color: const Color(0xFFaaaaaa),
//                                     ),
//                           ),
//                           Text(
//                             "C Russell",
//                             style:
//                                 Theme.of(context).textTheme.caption?.copyWith(
//                                       color: const Color(0xFFaaaaaa),
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.access_time_outlined,
//                         color: Color(0xFFaaaaaa),
//                         size: 16,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         "12:30",
//                         style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                               // color: const Color(0xFFaaaaaa),
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTicketOrigin() {
//     return Text(
//       boardingPass.origin.code.toUpperCase(),
//       style: const TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.w300,
//       ),
//     );
//   }
//
//   Widget _buildTicketDestination() {
//     return Text(
//       boardingPass.destination.code.toUpperCase(),
//       style: const TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.w300,
//       ),
//     );
//   }
// }
