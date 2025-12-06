import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/comment_provider.dart';
import 'package:store/core/widgets/custom_button_widget.dart';
import 'package:store/screens/widgets/custom_button.dart';
import 'package:store/screens/widgets/custom_text_form_field.dart';

class ShowBottomSheetWidget {
  final String commentId;
  ShowBottomSheetWidget({required this.commentId});
  final TextEditingController changeCommentController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.sizeOf(context).width,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Editing the Comment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              SizedBox(height: 10),
              Consumer<CommentProvider>(
                builder: (context, commentProvider, child) {
                  return SizedBox(
                    width: 350,
                    child: CustomTextFormField(
                      controller: changeCommentController,
                      icon: Icon(Icons.comment),
                      title: "Change Comment",
                      obscure: false,
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButtonWidget(
                    title: 'Edit',
                    onPressed: () async {
                      await context.read<CommentProvider>().updateComment(
                        commentId: commentId,
                        newContent: changeCommentController.text,
                      );
                      Navigator.pop(context);
                    },
                  ),
                  CustomButtonWidget(
                    title: 'Delete',
                    onPressed: () async {
                      await context.read<CommentProvider>().deleteComment(commentId);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
