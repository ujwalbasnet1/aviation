import 'dart:math';

import 'package:flutter/material.dart';

class TicketCut extends StatefulWidget {
  const TicketCut({Key? key}) : super(key: key);

  @override
  State<TicketCut> createState() => _TicketCutState();
}

class _TicketCutState extends State<TicketCut> {
  bool _isCut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ticket Cut")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const TopSection(),
              const Divider(
                height: 0,
                thickness: 2,
                color: Colors.red,
              ),
              // const AnimatedIcon(
              //   icon: AnimatedIcons.add_event,
              //   progress: 1,
              // ),
              // AnimatedBuilder(
              //   animation: AnimationController(),
              //   builder: builder,
              // ),
              Container(
                color: Colors.blue,
                child: ExpandIcon(
                  isExpanded: _isCut,
                  onPressed: (val) {},
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isCut = !_isCut;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  alignment: Alignment.topLeft,
                  transform: Matrix4.rotationZ((_isCut ? 1 : 0) * pi / 15),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const BottomSection(),
                      AnimatedPositioned(
                        // bottom: 0,
                        curve: Curves.elasticOut,
                        top: _isCut ? 10 : 100,
                        duration: const Duration(milliseconds: 1200),
                        child: const Icon(Icons.airplanemode_on_sharp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.green,
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.deepPurple,
    );
  }
}
