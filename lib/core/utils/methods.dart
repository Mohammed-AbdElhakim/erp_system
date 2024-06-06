import 'package:flutter/material.dart';

import '../../features/screenTable/data/models/dropdown_model/all_dropdown_model.dart';
import '../../features/screenTable/data/models/screen_model.dart';

bool isOrientationPortrait(BuildContext context) {
  Orientation orientation = MediaQuery.of(context).orientation;
  bool isPortrait = orientation == Orientation.portrait;
  return isPortrait;
}

String getStringNumber({
  required String statement,
  required String search,
  required String type,
}) {
  String s1 = '', s2 = '';

  if (statement.contains("$search >=") &&
      statement.contains("$search <=") &&
      statement.contains("$search <>")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search >=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    } else if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search <=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    } else if (type == "N") {
      s1 = statement.substring(
          statement.indexOf("$search <>") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search >=") &&
      statement.contains("$search <=")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search >=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    } else if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search <=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search <=") &&
      statement.contains("$search <>")) {
    if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search <=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    } else if (type == "N") {
      s1 = statement.substring(
          statement.indexOf("$search <>") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search >=") &&
      statement.contains("$search <>")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search >=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    } else if (type == "N") {
      s1 = statement.substring(
          statement.indexOf("$search <>") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search >=")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search >=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search <=")) {
    if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search <=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search <>")) {
    if (type == "N") {
      s1 = statement.substring(
          statement.indexOf("$search <>") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
    return s2;
  }

  return "";
}

String getStringText({
  required String statement,
  required String search,
}) {
  String s1 = '', s2 = '';
  if (statement.contains(search)) {
    s1 = statement.substring(
        (statement.indexOf(search) + (search.length) + 9), statement.length);

    s2 = s1.substring(0, s1.indexOf('%'));
  }
  return s2;
}

String getStringDate({
  required String statement,
  required String search,
  required String type,
}) {
  String s1 = '', s2 = '';

  if (statement.contains("$search )>= Convert(date, '") &&
      statement.contains("$search) <= Convert(date, '")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search )>= Convert(date, '") +
              (search.length) +
              20,
          statement.length);
      s2 = s1.substring(0, s1.indexOf("'"));
      return s2;
    } else if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search) <= Convert(date, '") +
              (search.length) +
              20,
          statement.length);
      s2 = s1.substring(0, s1.indexOf("'"));
      return s2;
    }
  } else if (statement.contains("$search )>= Convert(date, '")) {
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search )>= Convert(date, '") +
              (search.length) +
              20,
          statement.length);
      s2 = s1.substring(0, s1.indexOf("'"));
      return s2;
    }
  } else if (statement.contains("$search) <= Convert(date, '")) {
    if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search) <= Convert(date, '") +
              (search.length) +
              20,
          statement.length);
      s2 = s1.substring(0, s1.indexOf("'"));
      return s2;
    }
  }

  return "";
}

String getStringDropdown({
  required String statement,
  required String search,
}) {
  String s1 = '', s2 = '';

  if (statement.contains("$search =")) {
    if (statement.contains("or $search =")) {
      s1 =
          statement.substring(statement.indexOf("$search ="), statement.length);
      s2 = s1.substring(0, s1.indexOf(" )"));

      return s2;
    } else if (statement.contains("$search =")) {
      s1 = statement.substring(
          statement.indexOf("$search =") + (search.length) + 3,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(" "));
      return s2;
    }
  }

  return "";
}

String getStringCheckbox({
  required String statement,
  required String search,
}) {
  String s1 = '', s2 = '';
  if (statement.contains("$search =")) {
    s1 = statement.substring(
        (statement.indexOf("$search =") + (search.length) + 3),
        statement.length);

    s2 = s1.substring(0, s1.indexOf(' '));
    if (s2 == "1") {
      return "True";
    } else {
      return 'False';
    }
  }
  return "";
}

buildShowDialog(
  BuildContext context, {
  required String text,
  required String listName,
  ColumnList? columnList,
  required List<AllDropdownModel> allDropdownModelList,
}) {
  // String value = '';
  if (columnList?.insertType == "dropdown") {
    if (columnList?.columnName == columnList?.searchName) {
      List<ListDrop>? listDrop = [];
      List<ItemDrop>? myListDrop = [];
      for (var item in allDropdownModelList) {
        if (item.listName == listName) {
          listDrop = item.list;
        }
      }

      for (var item in listDrop!) {
        if (item.columnName == columnList?.columnName) {
          myListDrop = item.list;
        }
      }
      for (var item in myListDrop!) {
        if (item.id.toString() == text) {
          // value = item.text ?? "";
          if (item.text!.length > 12) {
            return showDialog(
              context: context,
              builder: (context) => Dialog(
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Text(textAlign: TextAlign.center, item.text!),
                  ),
                ),
              ),
            );
          }
        }
      }
    } else {
      if (text.length > 12) {
        return showDialog(
          context: context,
          builder: (context) => Dialog(
            child: InkWell(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 32),
                child: Text(textAlign: TextAlign.center, text),
              ),
            ),
          ),
        );
      }
    }
  } else {
    if (text.length > 12) {
      return showDialog(
        context: context,
        builder: (context) => Dialog(
          child: InkWell(
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16, vertical: 32),
              child: Text(textAlign: TextAlign.center, text),
            ),
          ),
        ),
      );
    }
  }
}
