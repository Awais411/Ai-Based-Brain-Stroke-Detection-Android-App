import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/basic_screen_imports.dart';

class GraphContainer extends StatefulWidget {
  const GraphContainer({super.key});

  @override
  _GraphContainerState createState() => _GraphContainerState();
}

class _GraphContainerState extends State<GraphContainer> {
  late List<_ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Colors.white,
      borderColor: Colors.grey,
      borderWidth: 1,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
        return Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                    text: '☻',
                    style: const TextStyle(color: CustomColor.darkBlue),
                    children: [
                      TextSpan(
                        text: '${_chartData[pointIndex].y}M',
                        style: TextStyle(color: CustomColor.greyColor, fontWeight: FontWeight.bold, fontSize: 8.r),
                      )
                    ]
                ),),
              Text(
                'These are the total number of patients this year...',
                style: TextStyle(color: Colors.black54, fontSize: 5.r),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 40.r),
      child: Container(
        height: 350.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Grey shadow color
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainCenter,
          children: [
            Text('Last 6 Years', style: CustomStyle.graphHeading,),
            SizedBox(height: 16.r),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                primaryYAxis: NumericAxis(
                  minimum: 10,
                  maximum: 15,
                  interval: 1,
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    if (details.value == 10) {
                      return ChartAxisLabel('10M', const TextStyle(color: Colors.black));
                    } else if (details.value == 15) {
                      return ChartAxisLabel('15M', const TextStyle(color: Colors.black));
                    } else if (details.value == 13) {
                      return ChartAxisLabel('13M', const TextStyle(color: Colors.black));
                    } else {
                      return ChartAxisLabel('${details.value.toInt()}M', const TextStyle(color: Colors.black));
                    }
                  },
                  majorGridLines: const MajorGridLines(width: 0, color: Colors.grey,),                ),
                tooltipBehavior: _tooltipBehavior,
                series: <CartesianSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    width: 0.3, // Decreased the bar width
                    pointColorMapper: (_ChartData data, _) => data.isSelected ? Colors.red : CustomColor.greyColor,
                    onPointTap: (ChartPointDetails details) {
                      setState(() {
                        for (var data in _chartData) {
                          data.isSelected = false;
                        }
                        _chartData[details.pointIndex!].isSelected = true;
                      });
                    },
                  ),
                  LineSeries<_ChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y1,
                    color: CustomColor.lightBlue,
                  ),
                ],
              ),
            ),
            const CustomRow(),
            const SizedBox(height: 10),
            const CustomElevatedButton(),
          ],
        ),
      ),
    );
  }

  List<_ChartData> getChartData() {
    return [
      _ChartData('2018', 13.7, 13.9),
      _ChartData('2019', 13.9, 14.1),
      _ChartData('2020', 14.1, 14.3),
      _ChartData('2021', 14.3, 14.5),
      _ChartData('2022', 14.5, 14.7),
      _ChartData('2023', 14.7, 15),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
  bool isSelected=false;
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainCenter,
      children: const [
        Text(
          '8%',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black
          ),
        ),
        SizedBox(width: 8), // Add spacing between the texts
        Expanded(
          child: Text(
            'Increase in patients of 8%\nwhich is rising time by time',
            style: TextStyle(
                fontSize: 12,
                color: Colors.black
            ),
          ),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    const String url = 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7589849/';
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child: ElevatedButton(

        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            throw 'Could not launch $url';
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: CustomColor.btnBg, // Background color
          foregroundColor: CustomColor.btnFg, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Border radius
          ),
        ),
        child: Text('Details', style: CustomStyle.graphHeading.copyWith(color: CustomColor.btnFg),),
      ),
    );
  }
}
