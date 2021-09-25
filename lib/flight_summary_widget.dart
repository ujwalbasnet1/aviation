import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models.dart';

enum SummaryTheme { dark, light }

class FlightSummary extends StatelessWidget {
  final BoardingPassData boardingPass;
  final SummaryTheme theme;
  final bool isOpen;

  const FlightSummary({
    Key? key,
    required this.boardingPass,
    this.theme = SummaryTheme.light,
    this.isOpen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(48, 53, 61, 1.0),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isOpen ? 0 : 16),
          bottomRight: Radius.circular(isOpen ? 0 : 16),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(25, 29, 34, 1),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  DateFormat("dd MMM yy").format(boardingPass.departs),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _buildTicketOrigin(),
                    Text(
                      boardingPass.duration.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white60,
                      ),
                    ),
                    _buildTicketDestination()
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  // color: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white24,
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 0,
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF777777),
                              radius: 4,
                            ),
                          ),
                          const Positioned(
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("1000"),
                          Text("2230"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.airplanemode_active,
                        color: Color(0xFFaaaaaa),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "B747-400",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: const Color(0xFFaaaaaa),
                                    ),
                          ),
                          Text(
                            "G-CIVB",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: const Color(0xFFaaaaaa),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xFFaaaaaa),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "R. Moody",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: const Color(0xFFaaaaaa),
                                    ),
                          ),
                          Text(
                            "C Russell",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: const Color(0xFFaaaaaa),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Color(0xFFaaaaaa),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "12:30",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              // color: const Color(0xFFaaaaaa),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketOrigin() {
    return Text(
      boardingPass.origin.code.toUpperCase(),
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildTicketDestination() {
    return Text(
      boardingPass.destination.code.toUpperCase(),
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
