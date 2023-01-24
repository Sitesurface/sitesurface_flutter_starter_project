import 'package:flutter/material.dart';
import '../../constants/assets/asset_constants.dart';
import '../../util/asset_helper/asset_helper.dart';
import '../../util/extentions/extensions.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  String? body,
  String? image,
  String? confirmButtonLabel,
  VoidCallback? onConfirm,
}) async {
  final colorScheme = context.colorScheme;

  await showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0c000000),
                      blurRadius: 60,
                      offset: Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12.86,
                  ),
                  Text(
                    title,
                  ),
                  const SizedBox(
                    height: 8.38,
                  ),
                  AssetHelper(image: image ?? AssetConstants.iconRedError),
                  const SizedBox(
                    height: 21,
                  ),
                  if (body != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 34,
                              width: 106,
                              decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x0c000000),
                                      blurRadius: 60,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              child: const Center(
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))),
                      const SizedBox(
                        height: 14,
                      ),
                      if (confirmButtonLabel != null)
                        TextButton(
                            onPressed: onConfirm,
                            child: Container(
                                height: 34,
                                width: 106,
                                decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x0c000000),
                                        blurRadius: 60,
                                        offset: Offset(0, 4),
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    confirmButtonLabel,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
