import 'package:cssd/Widgets/animated_clickable_button.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:flutter/material.dart';

class SwitchBetweenCssdAndDepartment extends StatelessWidget {
  const SwitchBetweenCssdAndDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.all(8.0),
            //         shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10))),
            //         elevation: 5,
            //         backgroundColor: Colors.white),
            //     onPressed: () {},
            //     child: Container(
            //       width: 320,
            //       height: 200,
            //       child: Text("data"),
            //     )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedHoverButton(
                  onClickFunction: () {
                    Navigator.pushNamed(context, Routes.dashboardViewCssdCssCssdLogin);
                  },
                  buttonChild: const SizedBox(
                    width: 320,
                    height: 200,
                    child: Center(
                      child: Text(
                        "CSSD User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedHoverButton(
                  onClickFunction: () {
                    Navigator.pushNamed(context, Routes.dashboardViewCssdCussDeptUser);
                  },
                  buttonChild: const SizedBox(
                    width: 320,
                    height: 200,
                    child: Center(
                      child: Text(
                        "Department User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
