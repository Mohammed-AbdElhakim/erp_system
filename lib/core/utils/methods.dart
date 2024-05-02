import 'package:flutter/material.dart';

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
    print(1);
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
    print("2");
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
    print("3");
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
    print("4");
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
    print(5);
    if (type == "F") {
      s1 = statement.substring(
          statement.indexOf("$search >=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search <=")) {
    print(6);
    if (type == "T") {
      s1 = statement.substring(
          statement.indexOf("$search <=") + (search.length) + 4,
          statement.length);
      s2 = s1.substring(0, s1.indexOf(' '));
      return s2;
    }
  } else if (statement.contains("$search <>")) {
    print(7);
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
    print(1);
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
    print(2);
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
    print(3);
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
      print(1);
      s1 =
          statement.substring(statement.indexOf("$search ="), statement.length);
      s2 = s1.substring(0, s1.indexOf(" )"));

      return s2;
    } else if (statement.contains("$search =")) {
      print(2);
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
}) {
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
