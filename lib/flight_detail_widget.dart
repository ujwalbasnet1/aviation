import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models.dart';

class FlightDetails extends StatelessWidget {
  final BoardingPassData boardingPass;
  final TextStyle titleTextStyle = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 11,
    height: 1,
    letterSpacing: .2,
    fontWeight: FontWeight.w600,
    color: Color(0xffafafaf),
  );

  final TextStyle contentTextStyle = const TextStyle(
    fontFamily: 'Oswald',
    fontSize: 14,
    height: 1.8,
    letterSpacing: .3,
    color: Color(0xffeeeeee),
  );

  const FlightDetails({Key? key, required this.boardingPass}) : super(key: key);

  // const FlightDetails(this.boardingPass);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(25, 31, 36, 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 48,
                    width: 48,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        "Edward Norton",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "⭐⭐⭐⭐⭐ (26 Reviews)",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 18,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Depart'.toUpperCase(), style: titleTextStyle),
                      Text(
                        DateFormat("hh:mm aa, MMM dd")
                            .format(boardingPass.departs),
                        style: contentTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Depart'.toUpperCase(), style: titleTextStyle),
                      Text(
                        DateFormat("hh:mm aa, MMM dd")
                            .format(boardingPass.departs),
                        style: contentTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class FlightDetails2 extends StatelessWidget {
  final BoardingPassData boardingPass;
  final TextStyle titleTextStyle = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 8,
    height: 1,
    letterSpacing: .2,
    fontWeight: FontWeight.w600,
    color: Color(0xffafafaf),
  );

  final TextStyle contentTextStyle = const TextStyle(
    fontFamily: 'Oswald',
    fontSize: 15,
    height: 1.8,
    letterSpacing: .3,
    color: Color(0xffeeeeee),
  );

  const FlightDetails2({Key? key, required this.boardingPass})
      : super(key: key);

  // const FlightDetails(this.boardingPass);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(25, 31, 36, 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Flight'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.flightNumber, style: contentTextStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Departs'.toUpperCase(), style: titleTextStyle),
                Text(DateFormat("dd MMM yy").format(boardingPass.departs),
                    style: contentTextStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Arrives'.toUpperCase(), style: titleTextStyle),
                Text(DateFormat("dd MMM yy").format(boardingPass.arrives),
                    style: contentTextStyle)
              ],
            ),
          ],
        ),
      );
}
