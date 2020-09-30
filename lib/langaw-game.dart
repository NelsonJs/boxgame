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
import 'package:boxgame/view.dart';
import 'package:boxgame/views/home-view.dart';
import 'package:boxgame/components/start-button.dart';
import 'package:boxgame/views/lost-view.dart';
import 'package:boxgame/controllers/spawner.dart';
import 'package:boxgame/components/credits-button.dart';
import 'package:boxgame/components/help-button.dart';
import 'package:boxgame/views/help-view.dart';
import 'package:boxgame/views/credits-view.dart';

class LangawGame extends Game {
  Size screenSize;
  double titleSize;
  List<Fly> flies;
  Random rnd;

  Backyard background;

  View activeView = View.home;
  HomeView homeView;

  StartButton startButton;

  LostView lostView;

  FlySpawner spawner;

  HelpButton helpButton;
  CreditsButton creditsButton;

  HelpView helpView;
  CreditsView creditsView;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = List();
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);


    rnd = Random();
    spawner = FlySpawner(this);

    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);

    helpView = HelpView(this);
    creditsView = CreditsView(this);
  }

  @override
  void render(Canvas canvas) {
    /*Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576754);
    canvas.drawRect(bgRect, bgPaint);*/
    background.render(canvas);

    flies.forEach((Fly fly)=> fly.render(canvas));

    if (activeView == View.home) homeView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    if (activeView == View.lost) lostView.render(canvas);

    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);

  }

  @override
  void update(double t) {

    flies.forEach((Fly fly)=> fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    titleSize = screenSize.width/9;
  }


  void onTapDown(TapDownDetails details) {
    bool isHandled = false;

    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    if (!isHandled && startButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool didHitAFly = false;
      for (var i = 0; i < flies.length; i++) {
        if (flies[i].flyRect.contains(details.globalPosition)) {
          flies[i].onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      }
      if (activeView == View.playing && !didHitAFly) {
        activeView = View.lost;
      }
    }

    // 教程按钮
    if (!isHandled && helpButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

// 感谢按钮
    if (!isHandled && creditsButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
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