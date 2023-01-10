import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/theme/theme_ext.dart';

Future<void> showErrorDialog(BuildContext context, String message) async {
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
                  const DefaultTextStyle(
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xFFA3A6Ab)),
                    child: Text(
                      "Error",
                    ),
                  ),
                  const SizedBox(
                    height: 8.38,
                  ),
                  SvgPicture.asset('assets/icons/icon_confirm_cancel.svg'),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.5,
                          color: Color(0xFF151724)),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
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
                      )
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
