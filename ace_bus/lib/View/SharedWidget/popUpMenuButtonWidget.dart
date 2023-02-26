import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:flutter/material.dart';
class PopUpMenuButtonWidget extends StatefulWidget {
   PopUpMenuButtonWidget({Key? key,
    required this.data,
    required this.onTap
}) : super(key: key);
  List data;
  Function onTap;

  @override
  State<PopUpMenuButtonWidget> createState() => _PopUpMenuButtonWidgetState();
}

class _PopUpMenuButtonWidgetState extends State<PopUpMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        offset: const Offset(-1.0, -220.0),
        elevation: 0,
        color: Colors.transparent,
        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        itemBuilder: (context) {
          return <PopupMenuEntry<Widget>>[
            PopupMenuItem<Widget>(
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.size10))),
                height: AppSize.size250,
                width: AppSize.size350,
                child: Scrollbar(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: AppSize.size20),
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final trans = widget.data[index];
                      return  ListTile(
                        title: Text(
                          trans.toString(),
                          style: FontsManager.getTextStyleLight()
                        ),

                        onTap: () {
                          widget.onTap(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ];
        },
        child: const Icon(IconsManager.downIcon));

  }
}
/*
*      PopupMenuButton(
                      position: PopupMenuPosition.over,
                      elevation: 10,
                      child: const Icon(
                        IconsManager.downIcon,
                        color: ColorsManager.darkBlueColor,
                        size: AppSize.size30,
                      ),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<DateTime>>[
                          for (int i = 0; i < startDates.length; i++)
                            PopupMenuItem(
                              value: startDates[i],
                              child: Text(
                                  "${startDates[i].hour}:${startDates[i].minute}"),
                            ),
                        ];
                      },
                      onSelected: (value) {
                        widget.companyModel.companyStartTime =
                            DateTime.parse(value.toString());

                        widget.companyModel.companyEndTime =
                            widget.companyModel.companyStartTime.add(
                                Duration(hours: hourT, minutes: minuteT)); //end

                        setState(() {});
                      }),
                ],
              ),*/