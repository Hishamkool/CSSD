import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final bool cssdNetworkImage;
  final bool deptNetworkImage;

  const PromoCard(
      {super.key,
      required this.cssdNetworkImage ,
      required this.deptNetworkImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Color(0xff53E88B), Color(0xff15BE77)])),
      child: Stack(
        children: [
          Opacity(
            opacity: .5,
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
                fit: BoxFit.cover),
          ),
          Image.network( cssdNetworkImage ?
              "https://cdn-icons-png.flaticon.com/512/2610/2610584.png" : "https://img.freepik.com/free-vector/modern-3d-urban-hospital-building-with-helipad-roof-isometric-isolated-vector-illustration_1284-2215.jpg?t=st=1730899773~exp=1730903373~hmac=97f7f93ddba3760685a55e6af6fd5638ae02220015e99a1a5d46bb86adf0f0a3&w=740"),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                "CSSD Department",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
