// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('SliverFillRemaining control test', (WidgetTester tester) async {
    final List<Widget> children = new List<Widget>.generate(20, (int i) {
      return new Container(child: new Text('$i', textDirection: TextDirection.ltr));
    });

    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: new CustomScrollView(
          slivers: <Widget>[
            new SliverFillViewport(
              delegate: new SliverChildListDelegate(children, addAutomaticKeepAlives: false),
            ),
          ],
        ),
      ),
    );

    final RenderBox box = tester.renderObject<RenderBox>(find.byType(Container).first);
    expect(box.size.height, equals(600.0));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsNothing);

    await tester.drag(find.byType(Scrollable), const Offset(0.0, -700.0));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsNothing);
    expect(find.text('4'), findsNothing);

    await tester.drag(find.byType(Scrollable), const Offset(0.0, 200.0));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);
    expect(find.text('3'), findsNothing);

    await tester.drag(find.byType(Scrollable), const Offset(0.0, 700.0));
    await tester.pump();

    final RenderBox box2 = tester.renderObject<RenderBox>(find.byType(Container).first);
    expect(box2.size.height, equals(600.0));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsNothing);
    expect(find.text('3'), findsNothing);

    final RenderObject viewport = tester.renderObject<RenderObject>(find.byType(SliverFillViewport).first);
    expect(viewport, hasAGoodToStringDeep);
    expect(
      viewport.toStringDeep(),
      equalsIgnoringHashCodes(
        'RenderSliverFillViewport#00000 relayoutBoundary=up1\n'
        ' │ creator: SliverFillViewport ← Viewport ← _ScrollableScope ←\n'
        ' │   IgnorePointer-[GlobalKey#00000] ← Listener ← _GestureSemantics\n'
        ' │   ←\n'
        ' │   RawGestureDetector-[LabeledGlobalKey<RawGestureDetectorState>#00000]\n'
        ' │   ← RepaintBoundary ← CustomPaint ← RepaintBoundary ←\n'
        ' │   NotificationListener<ScrollNotification> ←\n'
        ' │   GlowingOverscrollIndicator ← ⋯\n'
        ' │ parentData: paintOffset=Offset(0.0, 0.0) (can use size)\n'
        ' │ constraints: SliverConstraints(AxisDirection.down,\n'
        ' │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        ' │   0.0, remainingPaintExtent: 600.0, crossAxisExtent: 800.0,\n'
        ' │   crossAxisDirection: AxisDirection.right,\n'
        ' │   viewportMainAxisExtent: 600.0)\n'
        ' │ geometry: SliverGeometry(scrollExtent: 12000.0, paintExtent:\n'
        ' │   600.0, maxPaintExtent: 12000.0, hasVisualOverflow: true)\n'
        ' │ currently live children: 0 to 0\n'
        ' │\n'
        ' └─child with index 0: RenderRepaintBoundary#00000\n'
        '   │ creator: RepaintBoundary-[<0>] ← SliverFillViewport ← Viewport ←\n'
        '   │   _ScrollableScope ← IgnorePointer-[GlobalKey#00000] ← Listener ←\n'
        '   │   _GestureSemantics ←\n'
        '   │   RawGestureDetector-[LabeledGlobalKey<RawGestureDetectorState>#00000]\n'
        '   │   ← RepaintBoundary ← CustomPaint ← RepaintBoundary ←\n'
        '   │   NotificationListener<ScrollNotification> ← ⋯\n'
        '   │ parentData: index=0; layoutOffset=0.0\n'
        '   │ constraints: BoxConstraints(w=800.0, h=600.0)\n'
        '   │ layer: OffsetLayer#00000\n'
        '   │ size: Size(800.0, 600.0)\n'
        '   │ metrics: 50.0% useful (1 bad vs 1 good)\n'
        '   │ diagnosis: insufficient data to draw conclusion (less than five\n'
        '   │   repaints)\n'
        '   │\n'
        '   └─child: RenderParagraph#00000\n'
        '     │ creator: RichText ← Text ← Container ← RepaintBoundary-[<0>] ←\n'
        '     │   SliverFillViewport ← Viewport ← _ScrollableScope ←\n'
        '     │   IgnorePointer-[GlobalKey#00000] ← Listener ← _GestureSemantics\n'
        '     │   ←\n'
        '     │   RawGestureDetector-[LabeledGlobalKey<RawGestureDetectorState>#00000]\n'
        '     │   ← RepaintBoundary ← ⋯\n'
        '     │ parentData: <none> (can use size)\n'
        '     │ constraints: BoxConstraints(w=800.0, h=600.0)\n'
        '     │ size: Size(800.0, 600.0)\n'
        '     │ textAlign: start\n'
        '     │ textDirection: ltr\n'
        '     │ softWrap: wrapping at box width\n'
        '     │ overflow: clip\n'
        '     │ maxLines: unlimited\n'
        '     ╘═╦══ text ═══\n'
        '       ║ TextSpan:\n'
        '       ║   <all styles inherited>\n'
        '       ║   "0"\n'
        '       ╚═══════════\n'
      ),
    );
  });
}
