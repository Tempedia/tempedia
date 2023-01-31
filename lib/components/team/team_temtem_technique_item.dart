import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/temtem/temtem_technique_table.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/models/technique.dart';
// import 'package:badges/badges.dart';

class TeamTemtemTechniqueItem extends StatefulWidget {
  final TemtemTechnique data;
  final bool egg;
  final bool course;
  final String? tag;
  final Function()? onTap;
  const TeamTemtemTechniqueItem({
    super.key,
    required this.data,
    this.tag,
    this.egg = false,
    this.course = false,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _TeamTemtemTechniqueItemState();
}

class _TeamTemtemTechniqueItemState extends State<TeamTemtemTechniqueItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.tag == null) {
      return buildCard();
    }
    return Hero(
      tag: '${widget.tag} - ${widget.data.name}',
      child: Material(
        color: Colors.transparent,
        child: buildCard(),
      ),
    );
  }

  buildCard() {
    final data = widget.data;

    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          color: const Color(0xff3c3c3c),
          child: InkWell(
            onLongPress: showTechniqueDialog,
            onTap: widget.onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: TechniquePainter(
                    typeName: data.type,
                    hold: data.hold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: BorderedText(
                          strokeWidth: 2,
                          strokeColor: const Color(0xff0c0c0c),
                          child: Text(
                            data.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      data.damage >= 0
                          ? Badge(
                              padding: const EdgeInsets.all(3),
                              largeSize:20,
                              smallSize:20,
                              label:BorderedText(
                                strokeWidth: 2,
                                strokeColor: const Color(0xff0c0c0c),
                                child: Text(
                                  data.damageStr(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              backgroundColor: const Color(0xff1acfd1),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        data.synergyType.isNotEmpty
            ? Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 2, left: 2),
                child: Image.asset(
                  'assets/image/synergy_plus.png',
                  width: 9,
                  height: 9,
                ),
              )
            : Container(),
        widget.egg
            ? Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 2, left: 0),
                child: Image.asset(
                  'assets/image/egg.png',
                  width: 12,
                  height: 12,
                ),
              )
            : Container(),
        widget.course
            ? Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 2, left: 0),
                child: Image.asset(
                  'assets/image/course.png',
                  width: 12,
                  height: 12,
                ),
              )
            : Container(),
      ],
    );
  }

  showTechniqueDialog() {
    final data = widget.data;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            HtmlView(data: '<i>${data.description}</i>'),
            TemtemTechniqueTable(
              data: data,
            ),
            data.synergyType.isNotEmpty ? buildSynergy() : Container(),
          ],
        ),
      ),
    );
  }

  buildSynergy() {
    final data = widget.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerWithText(text: 'Synergy Details'),
        HtmlView(data: '<i>${data.synergyDescription}</i>'),
        TemtemTechniqueSynergyTable(data: data),
      ],
    );
  }
}

const Map<String, Color> TemtemTypeColor = {
  'Neutral type': Colors.white,
  'Toxic type': Colors.black,
  'Mental type': Colors.purple,
  'Fire type': Colors.red,
  'Digital type': Colors.grey,
  'Melee type': Colors.orange,
  'Electric type': Colors.yellow,
  'Nature type': Colors.green,
  'Water type': Colors.blue,
  'Earth type': Colors.brown,
  'Crystal type': Color(0xffFF00FF),
};

class TechniquePainter extends CustomPainter {
  final String typeName;
  final int hold;
  const TechniquePainter({required this.typeName, required this.hold});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.fill;
    paint.color = TemtemTypeColor[typeName] ?? Colors.white;

    final width = size.width;
    final height = size.height;

    path.moveTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(5, height);
    path.lineTo(30, 0);
    path.close();

    canvas.drawPath(path, paint);

    int i = 0;
    double start = 5;
    double holdWidth = 8;
    while (i < hold) {
      path.reset();
      path.moveTo(start + 5, height);
      path.lineTo(start + holdWidth + 5, height);
      path.lineTo(start + 25 + holdWidth + 5, 0);
      path.lineTo(start + 25 + 5, 0);
      path.close();
      canvas.drawPath(path, paint);

      start = start + holdWidth + 4;
      i++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
