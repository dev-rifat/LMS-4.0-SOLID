import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/margin_layout.dart';
import '../../controller/home_controller.dart';
import '../widget/SearchList.dart';
import '../widget/search_widget.dart';


class SearchScreen extends GetView<HomeController> {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor:Colors.grey.shade100,
        title: Text(controller.viewAllString,style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),),),
      body: Padding(
        padding: marginLayout.copyWith(left: 8,right: 8),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.only(left: 8.0,right: 8),
               child: SearchWidget(onChanged: (value){
                 controller.getSearchList(query: value);

               },),
             ),
            customSpacerHeight(height: 12),
            const SearchListWidget()
          ],
        ),
      ),

    );
  }
}

