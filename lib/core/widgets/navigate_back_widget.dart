import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/core/app_icons.dart';

class NavigateBackWidget extends StatelessWidget {
  const NavigateBackWidget({super.key, required this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 44,
                        child: InkWell(
                          onTap: onTap,
                          borderRadius: BorderRadius.circular(44),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.backArrow,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
  }
}