import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemGridView extends StatefulWidget {
  final String icon;
  final String title;
  final Function onTap;

  ItemGridView({required this.icon, required this.title, required this.onTap});

  @override
  State<ItemGridView> createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(width: 1.5, color: Colors.black38),
//                   color: Color(0xffF1B606),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Color(0xfff8f9fa),
          elevation: 8,
          shadowColor: Theme.of(context).primaryColor.withOpacity(.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Color(0xff48cae4),
                  ),
                  child: Image.asset(
                    "assets/images/${widget.icon}.png",
                    width: 85,
                    height: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: AutoSizeText(widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => widget.onTap(),
    );
  }
}
