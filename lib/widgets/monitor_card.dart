import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kridafighter/shared/shared.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class MonitoringCard extends StatelessWidget {
  final Function(double) onValueChanged;
  final  Object? dataSensor;
  final  String? nameSensor;
  final  String? nameParameter;

  // final  double? dataSensor;


  const MonitoringCard({Key? key, required this.onValueChanged, this.dataSensor,this.nameSensor, this.nameParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBackgroundColor2,
      ),
      child: Column(
        children: [
          Text(nameSensor!,
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              textAlign: TextAlign.center),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.40,
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                  minimum: 0,
                  maximum: 2000,
                  showLabels: false,
                  showTicks: false,
                  radiusFactor: 0.9,
                  axisLineStyle: AxisLineStyle(
                      cornerStyle: CornerStyle.bothCurve,
                      color: Color(0xFF241461),
                      thickness: 26),
                  pointers: <GaugePointer>[
                    RangePointer(
                        value:double.parse(dataSensor!.toString()),
                        cornerStyle: CornerStyle.bothCurve,
                        width: 26,
                        sizeUnit: GaugeSizeUnit.logicalPixel,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFFA6F8F0),
                          Color(0xFF66E0D4)
                        ], stops: <double>[
                          0.25,
                          0.75
                        ])),
                    MarkerPointer(
                        value: double.parse(dataSensor!.toString()),
                        enableDragging: false,
                        onValueChanged: onValueChanged,
                        markerHeight: 27,
                        markerWidth: 27,
                        markerType: MarkerType.circle,
                        color: Color(0xFF66E0D4),
                        borderWidth: 2,
                        borderColor: Colors.white54)
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        angle: 90,
                        axisValue: 10,
                        positionFactor: 0.2,
                        widget: Text(
                          "${dataSensor}",
                          style: greenTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        )),
                    GaugeAnnotation(
                        angle: 90,
                        axisValue: 5,
                        positionFactor: 1.2,
                        widget: Text(nameParameter!,
                            style: greyTextStyle.copyWith(
                                fontSize: 12, fontWeight: medium),
                            textAlign: TextAlign.center))
                  ])
            ]),
          ),
        ],
      ),
    );
  }
}
