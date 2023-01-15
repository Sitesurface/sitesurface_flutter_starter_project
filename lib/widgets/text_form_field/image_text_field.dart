// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:the_pet_nest_partner/helpers/image_helper.dart';
// import 'package:the_pet_nest_partner/style/pallet.dart';
// import 'package:the_pet_nest_partner/style/styles.dart';

// class ImageTextField extends StatelessWidget {
//   final void Function(dynamic) onChanged;
//   final String heading;
//   final String? label;
//   final String? subHeading;
//   final String? Function()? validator;
//   final bool pickMultiple;
//   ImageTextField(
//       {Key? key,
//       required this.onChanged,
//       required this.heading,
//       this.label,
//       this.subHeading,
//       this.validator,
//       this.pickMultiple = false})
//       : super(key: key);

//   final _imageHelper = ImagePickerHelper();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 5.h,
//         ),
//         Text(
//           heading,
//           style: Style.h12.copyWith(fontWeight: FontWeight.w500),
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         if (subHeading != null)
//           Text(
//             subHeading ?? "",
//             style: Style.h12
//                 .copyWith(fontWeight: FontWeight.w300, color: Pallet.lightGrey),
//           ),
//         InkWell(
//           onTap: () async {
//             if (pickMultiple) {
//               var image = await _imageHelper.pickMultiImage();
//               if (image.isNotEmpty) {
//                 onChanged(image);
//               }
//             } else {
//               await _imageHelper.showImageSourceDialog(context);
//               var image = await _imageHelper.pickImage();
//               if (image != null) {
//                 onChanged(image);
//               }
//             }
//           },
//           child: Stack(
//             children: [
//               AbsorbPointer(
//                 absorbing: true,
//                 child: TextFormField(
//                   readOnly: true,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) {
//                     if (validator != null) {
//                       return validator!();
//                     }
//                     return null;
//                   },
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     helperText: ' ',
//                     filled: true,
//                     fillColor: Pallet.background,
//                     focusColor: Pallet.textFieldColor,
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 14.5.h, horizontal: 12.w),
//                     labelText: label,
//                     labelStyle: Style.h12.copyWith(
//                         fontWeight: FontWeight.w300, color: Pallet.darkGrey),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned.fill(
//                 right: 15.w,
//                 top: 15,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
//                     decoration: BoxDecoration(
//                         color: Pallet.primary,
//                         borderRadius: BorderRadius.circular(6.r)),
//                     child: Text(
//                       "Choose a picture",
//                       style: Style.h12.copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//       ],
//     );
//   }
// }
