import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class SelectWorkOut extends StatefulWidget {
  const SelectWorkOut({super.key});

  @override
  State<SelectWorkOut> createState() => _SelectWorkOutState();
}

class _SelectWorkOutState extends State<SelectWorkOut> {
  List? workOutList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workOutList = context.watch<provider.WorkOutListStore>().workOut;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          inputContent: const [
            Text(
              "Select Your Work-Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return SelectBox(
                workOutName: workOutList?[index] ?? "불러오지 못함",
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: workOutList?.length ?? 1,
          ),
        ),
      ],
    );
  }
}

class SelectBox extends StatefulWidget {
  final String workOutName;

  const SelectBox({
    super.key,
    required this.workOutName,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _checker = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.workOutName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Checkbox(
          value: _checker,
          onChanged: (value) => setState(() {
            _checker = value!;
          }),
        ),
      ],
    );
  }
}
