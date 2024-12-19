import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final Color? cardColor;
  final Color? cardLeadingContainerColor;
  final Color? cardLeadingContainerTextColor;
  final String requestID;
  final String requestTitle;
  final String requestSubTitle;
  final String requestDate;
  final String reqiestTime;
  final String requestDepartment;
  final GestureTapCallback? cardClickFunction;

  const ClickableCard({
    super.key,
    this.cardColor,
    this.cardLeadingContainerColor = const Color(0xff0C9EDF),
    this.cardLeadingContainerTextColor = Colors.white,
    required this.requestID,
    required this.requestTitle,
    required this.requestDate,
    required this.reqiestTime,
    required this.requestDepartment,
    required this.requestSubTitle,
    this.cardClickFunction,
  });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      color: cardColor,
      elevation: 5.0, // Adds a shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: InkWell(
        onTap: cardClickFunction,
        child: ListTile(
          leading: Container(
            width: 57,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: cardLeadingContainerColor),
            child: Center(
              child: Text(
                requestID,
                style: TextStyle(color: cardLeadingContainerTextColor),
              ),
            ),
          ),
          title: SizedBox(
              height: 20,
              child: Text(
                requestTitle,
                overflow: TextOverflow.ellipsis,
              )),
          subtitle: SizedBox(
            width: 20,
            child: Text(
              requestSubTitle,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(requestDepartment),
              Text(requestDate),
              Text(reqiestTime)
            ],
          ),
        ),
      ),
    );
  }
}

