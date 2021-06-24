import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_definition.dart';
import 'package:flutter_animator/animation/tween_list.dart';
import 'package:flutter_animator/animation/animator.dart';
import 'package:flutter_animator/flutter_animator.dart';

class LeftRightwidget extends AnimatorWidget {
  LeftRightwidget({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: ShakeAnimation(
              preferences: preferences,
            ));
}

class ShakeAnimation extends AnimationDefinition {
  ShakeAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller,
      builder: (
        BuildContext context,
        Widget child,
      ) =>
          Transform(
        child: child,
        transform: Matrix4.translationValues(
          animator.get("translateX").value,
          0.0,
          0.0,
        ),
        alignment: const FractionalOffset(0.5, 0.5),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    const origin = 0.0;
    return {
      "translateX": TweenList<double>(
        [
          const TweenPercentage(percent: 0, value: origin),
          const TweenPercentage(percent: 20, value: -5),
          const TweenPercentage(percent: 80, value: 5),
          const TweenPercentage(percent: 100, value: origin),
        ],
      ),
    };
  }
}
