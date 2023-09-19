import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/views/screens/pickodds/chattab/chattab.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final TextEditingController _chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return true
        ? Center(
            heightFactor: 3,
            child: Text(
              "Currently Not Available",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ChattabItem();
                  },
                  itemCount: 10,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 0.5)),
                      margin: const EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        obscureText: false,
                        controller: _chatController,
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: ProjectColors.gameweekBackground,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ProjectColors.primaryColor,
                          )),
                          contentPadding:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                          hintText: "Type your messege here..",
                          hintStyle: TextStyle(
                              fontSize: 12.0, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(
                            "assets/images/Button.svg",
                            fit: BoxFit.fill,
                          )),
                    )
                  ],
                ),
              )
            ],
          );
  }
}
