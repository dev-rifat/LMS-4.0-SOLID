import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/loading_effect/shimmer.dart';
import '../../controller/home_controller.dart';
import 'package:lms_0_3/app/module/home/models/catrgory_model.dart';



class CategoryList extends GetView<HomeController> {
  const CategoryList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: controller.obx((state) {
        final categories = [
        Data(id: 0, name: "All"), //add all text in category's list
          ...?controller.categoriesModel?.data
        ];

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            var category = categories[index];
            return Obx(() => GestureDetector(
              onTap: () {
                controller.isSelectCategory.value = index;

                if(category.name!="All"){
                  controller.getCategoryWithCourse(category.id.toString());
                  controller.isSelectCategoryId.value=category.id.toString()??"";
                  controller.isSelectCategoryName.value=category.name.toString()??"";
                  Get.toNamed(Routes.CATEGORY_WITH_PRODUCT);
                }



              },
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: controller.isSelectCategory.value == index
                        ? decoration
                        : BoxDecoration(
                        color: AppColor.cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault-4)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0, right: 14),
                        child: Text(
                          category.name??"",
                          style: AppStyle.normal_text.copyWith(
                            color: controller.isSelectCategory.value == index
                                ? AppColor.cardColor
                                : AppColor.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
          },
        );
      }, onLoading: const ShimmerListEffect()),
    );
  }
}

Decoration get decoration {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(Dimensions.radiusDefault-4),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        AppColor.primaryColor.withOpacity(0.5),
        AppColor.primaryColor,
        AppColor.primaryColor,
        AppColor.primaryColor,
      ],
    ),
  );
}
