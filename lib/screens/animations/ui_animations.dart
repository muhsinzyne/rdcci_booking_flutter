import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum LoadingAnimationStyle { style1, style2, style3 }

class PageLoadingAnimation extends StatelessWidget {
  final LoadingAnimationStyle style;
  final double size;
  const PageLoadingAnimation({Key key, this.style = LoadingAnimationStyle.style1, this.size = 80}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (style) {
      case LoadingAnimationStyle.style1:
        return SpinKitPouringHourglass(
          color: Theme.of(context).primaryColor,
          size: size,
        );
        break;
      case LoadingAnimationStyle.style2:
        return SpinKitDoubleBounce(
          color: Theme.of(context).primaryColor,
          size: size,
        );
        break;
      default:
        return SpinKitWave(
          color: Theme.of(context).primaryColor,
          type: SpinKitWaveType.start,
          size: size,
        );
        break;
    }
  }
}
