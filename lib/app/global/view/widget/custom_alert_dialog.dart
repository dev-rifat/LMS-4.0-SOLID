import 'package:flutter/material.dart';
import '../../../../utils/dimensions.dart';


RoundedRectangleBorder get roundedRectangleBorder {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.radiusMid - 2),
  );
}

