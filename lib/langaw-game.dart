import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/components/backyard.dart';
import 'package:boxgame/components/house-fly.dart';
import 'package:boxgame/components/hungry-fly.dart';
import 'package:boxgame/components/macho-fly.dart';
import 'package:boxgame/components/drooler-fly.dart';
import 'package:boxgame/components/agile-fly.dart';
import 'package:flutter/gestures.dart';

class LangawGame extends Game {
  Size screenSize;
  double titleSize;
  List<Fly> flies;
  Random rnd;

  Backyard background;


  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = List();
    resize(await Flame.util.initialDimensions());
    background = Backyard(this);
    rnd = Random();
    spawnFly();
  }

  @override
  void render(Canvas canvas) {
    /*Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576754);
    canvas.drawRect(bgRect, bgPaint);*/
    background.render(canvas);

    flies.forEach((Fly fly)=> fly.render(canvas));
  }

  @override
  void update(double t) {
    flies.forEach((Fly fly)=> fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);

  }

  @override
  void resize(Size size) {
    screenSize = size;
    titleSize = screenSize.width/9;
  }

  void onTapDown(TapDownDetails details) {
      for (var i = 0; i < flies.length; i++) {
        if (flies[i].flyRect.contains(details.globalPosition)) {
          flies[i].onTapDown();
        }
      }
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - titleSize*2.025);
    double y = rnd.nextDouble() * (screenSize.height - titleSize*2.025);
    switch(rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

}