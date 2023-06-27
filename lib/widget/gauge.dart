import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class Gague extends StatelessWidget {
  final double score;

  const Gague({Key? key, this.score = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, // 修改此处高度为需要的高度
      child: Transform.translate(
        offset: Offset(0, -20), // 向上移动的位移值
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 160,
              endAngle: 20,
              canScaleToFit: true,
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.2,
                color: Color.fromARGB(255, 233, 231, 231),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  gradient: const SweepGradient(colors: <Color>[
                    Color.fromARGB(255, 255, 208, 255),
                    Color.fromARGB(255, 224, 95, 224)
                  ], stops: <double>[
                    0.20,
                    0.90
                  ]),
                  value: score,
                  width: 0.2,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 800,
                  animationType: AnimationType.easeInCirc,
                  color: Colors.grey,
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  positionFactor: 0.1,
                  widget: Transform.translate(
                    offset: const Offset(0, 45),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        score.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
