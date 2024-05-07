import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/app/modules/detail/controllers/detail_controller.dart';
import 'package:foodie/app/modules/detail/views/widget/ingredientsListingWidget.dart';
import 'package:get/get.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    var instruction = detailController.recipe;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        itemBuilder: (context, index) {
          var step = instruction[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.arrow_circle_right,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "$step",
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
        itemCount: instruction.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
