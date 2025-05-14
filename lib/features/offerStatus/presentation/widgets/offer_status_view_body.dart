import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/offer_master_model.dart';
import '../manager/getOfferMaster/get_offer_master_cubit.dart';
import '../views/offer_status_view.dart';

class OfferStatusViewBody extends StatefulWidget {
  const OfferStatusViewBody({super.key, required this.data, required this.states});

  final Map<String, List<Offers>> data;
  final List<States> states;

  @override
  State<OfferStatusViewBody> createState() => _OfferStatusViewBodyState();
}

class _OfferStatusViewBodyState extends State<OfferStatusViewBody> with TickerProviderStateMixin {
  String? dragFrom;
  Offers? draggedItem;
  String searchQuery = '';

  late final Map<String, List<Offers>> categorizedLists;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _autoScrollController;

  double _pointerY = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    categorizedLists = widget.data;
    _autoScrollController = AnimationController(vsync: this, duration: const Duration(milliseconds: 50))
      ..addListener(_autoScroll);
    super.initState();
  }

  void _autoScroll() {
    if (!_isDragging) return;

    const edgeMargin = 80.0;
    const scrollSpeed = 12.0;

    final max = _scrollController.position.maxScrollExtent;
    final min = _scrollController.position.minScrollExtent;
    final current = _scrollController.offset;

    if (_pointerY < edgeMargin && current > min) {
      _scrollController.jumpTo(current - scrollSpeed);
    } else if (_pointerY > MediaQuery.of(context).size.height - edgeMargin && current < max) {
      _scrollController.jumpTo(current + scrollSpeed);
    }
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        _pointerY = event.position.dy;
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormFieldSearch(
                    hintText: S.of(context).search,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim();
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<GetOfferMasterCubit>(context).getOfferMaster();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DragTarget<Offers>(
              builder: (context, candidateData, rejectedData) {
                return DottedBorder(
                    color: Colors.black,
                    strokeWidth: 1,
                    dashPattern: const [6, 3],
                    // 6 بيكسل خط - 3 بيكسل فراغ
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: candidateData.isNotEmpty ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        // border: Border.all(color: Colors.black, width: .7),
                      ),
                      child: Text(
                        S.of(context).convert_to_supply_order,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ));
              },
              onAcceptWithDetails: (details) {
                HapticFeedback.heavyImpact();
                if (dragFrom != null) {
                  CustomAlertDialog.alertWithCustomButtons(
                    context: context,
                    type: AlertType.none,
                    title: S.of(context).confirmation_set_order,
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          setState(() {
                            categorizedLists[dragFrom!]?.remove(details.data);
                          });
                          BlocProvider.of<GetOfferMasterCubit>(context).setOrder(offerId: details.data.oMID!);
                          Navigator.of(context).pop();
                        },
                        gradient: gradientButton,
                        width: 120,
                        color: AppColors.blueDark,
                        child: Text(
                          S.of(context).ok,
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DialogButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        // gradient: gradientButton,
                        width: 120,
                        color: AppColors.grey,
                        child: Text(
                          S.of(context).cancel,
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categorizedLists.entries.map((entry) {
                  final filteredItems = entry.key == listNoState
                      ? entry.value
                      : entry.value
                          .where((item) => (item.oMName!.toUpperCase().contains(searchQuery.toUpperCase()) ||
                              (item.customer!.toUpperCase().contains(searchQuery.toUpperCase()))))
                          .toList();
                  return _buildVerticalList(entry.key, filteredItems);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalList(String title, List<Offers> items) {
    return Column(
      children: [
        if (title != listNoState)
          Container(
            padding: const EdgeInsets.all(8),
            color: getColor(title),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(getTotalMaony(title), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(items.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        DragTarget<Offers>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 105,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((e) {
                    return LongPressDraggable<Offers>(
                      data: e,
                      onDragStarted: () {
                        dragFrom = title;
                        draggedItem = e;
                        _isDragging = true;
                        _autoScrollController.repeat();
                        HapticFeedback.selectionClick();
                      },
                      onDragEnd: (_) {
                        _isDragging = false;
                        _autoScrollController.stop();
                      },
                      feedback: Material(
                        color: Colors.transparent,
                        child: _buildDraggableItem(e, Colors.red.shade900, title, isDragging: true),
                      ),
                      childWhenDragging: _buildDraggableItem(e, Colors.grey.shade300, title),
                      child: DragTarget<Offers>(
                        builder: (context, candidateData, rejectedData) {
                          return _buildDraggableItem(
                            e,
                            candidateData.isNotEmpty ? Colors.blue : Colors.white,
                            title,
                          );
                        },
                        onWillAcceptWithDetails: (details) => details.data != e,
                        onAcceptWithDetails: (details) {
                          if (dragFrom != null && draggedItem != null && title != listNoState) {
                            setState(() {
                              categorizedLists[dragFrom!]?.remove(details.data);
                              int index = categorizedLists[title]!.indexOf(e);
                              categorizedLists[title]!.insert(index, details.data);
                            });
                            int newStateId = getNewStateId(title);
                            if (newStateId != details.data.stateId) {
                              BlocProvider.of<GetOfferMasterCubit>(context)
                                  .changeOfferStatus(offerId: details.data.oMID!, newStateId: newStateId);
                            }
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          onAcceptWithDetails: (details) {
            if (dragFrom != null && draggedItem != null && title != listNoState) {
              setState(() {
                categorizedLists[dragFrom!]?.remove(details.data);
                categorizedLists[title]?.add(details.data);
              });
              int newStateId = getNewStateId(title);
              if (newStateId != details.data.stateId) {
                BlocProvider.of<GetOfferMasterCubit>(context)
                    .changeOfferStatus(offerId: details.data.oMID!, newStateId: newStateId);
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildDraggableItem(Offers offer, Color color, String title, {bool isDragging = false}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: isDragging ? LinearGradient(colors: [color, color]) : null,
        color: isDragging ? null : color,
        border: title == listNoState ? Border.all(width: .2) : null,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  offset: const Offset(3, 3),
                  blurRadius: 6,
                )
              ]
            : title == listNoState
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      offset: const Offset(2, 2),
                      blurRadius: 2,
                    )
                  ],
      ),
      child: Column(
        children: [
          Text(offer.oMName!, style: TextStyle(color: isDragging ? Colors.white : Colors.black)),
          Text(offer.customer!, style: TextStyle(color: isDragging ? Colors.white : Colors.black)),
          Text(DateFormat('yyyy/MM/dd').format(DateTime.parse(offer.offerDate!)),
              style: TextStyle(color: isDragging ? Colors.white : Colors.black)),
          Text(offer.mony.toString(), style: TextStyle(color: isDragging ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

  String getTotalMaony(String title) {
    List<Offers> list = categorizedLists[title] ?? [];
    double total = 0.0;
    for (var i in list) {
      total = total + i.mony!;
    }
    String formatted = NumberFormat("#,##0.00", "en_US").format(total);
    return formatted;
  }

  getColor(String title) {
    String col = widget.states.firstWhere((element) => (element.arName == title) || (element.enName == title)).color ?? "#ffffff";
    return hexToColor(col);
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse("0x$hex"));
  }

  int getNewStateId(String title) {
    int stateId = widget.states.firstWhere((element) => (element.arName == title) || (element.enName == title)).id ?? 0;
    return stateId;
  }
}

/*من غير scroll
class _OfferStatusViewBodyState extends State<OfferStatusViewBody> {
  String? dragFrom;
  Offers? draggedItem;
  String searchQuery = '';

  late final Map<String, List<Offers>> categorizedLists;

  @override
  void initState() {
    categorizedLists = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormFieldSearch(
                  hintText: S.of(context).search,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.trim();
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<GetOfferMasterCubit>(context).getOfferMaster();
                  },
                  icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DragTarget<Offers>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: candidateData.isNotEmpty ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: .7),
                ),
                child: Text(
                  S.of(context).convert_to_supply_order,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
            onAcceptWithDetails: (details) {
              HapticFeedback.heavyImpact();
              if (dragFrom != null) {
                CustomAlertDialog.alertWithButton(
                  context: context,
                  type: AlertType.error,
                  title: S.of(context).error,
                  desc: S.of(context).massage_choose_delete,
                  onPressed: () {
                    setState(() {
                      categorizedLists[dragFrom!]?.remove(details.data);
                    });
                    Navigator.of(context).pop();
                  },
                );
              }
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categorizedLists.entries.map((entry) {
                final filteredItems = entry.value
                    .where((item) => (item.oMName!.toUpperCase().contains(searchQuery.toUpperCase()) ||
                        (item.customer!.toUpperCase().contains(searchQuery.toUpperCase()))))
                    .toList();
                // if (filteredItems.isEmpty) return const SizedBox.shrink();
                return _buildVerticalList(entry.key, filteredItems);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalList(String title, List<Offers> items) {
    return Column(
      children: [
        if (title != listNoState)
          Container(
            padding: const EdgeInsets.all(8),
            // width: double.infinity,
            color: getColor(title),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  getTotalMaony(title),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  items.length.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        DragTarget<Offers>(
          builder: (context, candidateData, rejectedData) {
            // final isReceiving = candidateData.isNotEmpty;

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 105,
              // color: title == listNoState
              //     ? null
              //     : isReceiving
              //         ? getColor(title)
              //         : getColor(title),
              // decoration: BoxDecoration(
              //   color: isReceiving ? Colors.blue.shade50 : null,
              //   border: Border.all(color: isReceiving ? Colors.blue : Colors.grey, width: 2),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((e) {
                    return LongPressDraggable<Offers>(
                      data: e,
                      onDragStarted: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          dragFrom = title;
                          draggedItem = e;
                        });
                      },
                      feedback: Material(
                        color: Colors.transparent,
                        child: _buildDraggableItem(e, Colors.red.shade900, title, isDragging: true),
                      ),
                      childWhenDragging: _buildDraggableItem(
                        e,
                        Colors.grey.shade300,
                        title,
                      ),
                      child: DragTarget<Offers>(
                        builder: (context, candidateData, rejectedData) {
                          return _buildDraggableItem(
                            e,
                            candidateData.isNotEmpty ? Colors.blue : Colors.white,
                            title,
                          );
                        },
                        onWillAcceptWithDetails: (details) {
                          final incoming = details.data;
                          return incoming != e;
                        },
                        onAcceptWithDetails: (details) {
                          final incoming = details.data;
                          HapticFeedback.lightImpact();
                          if (dragFrom != null && draggedItem != null && title != listNoState) {
                            setState(() {
                              categorizedLists[dragFrom!]?.remove(incoming);
                              int index = categorizedLists[title]!.indexOf(e);
                              categorizedLists[title]!.insert(index, incoming);
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          onAcceptWithDetails: (details) {
            final incoming = details.data;
            HapticFeedback.lightImpact();
            if (dragFrom != null && draggedItem != null && title != listNoState) {
              setState(() {
                categorizedLists[dragFrom!]?.remove(incoming);
                categorizedLists[title]?.add(incoming);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDraggableItem(Offers offer, Color color, String title, {bool isDragging = false}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: isDragging ? LinearGradient(colors: [color, color]) : null,
        color: isDragging ? null : color,
        border: title == listNoState ? Border.all(width: .2) : null,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  offset: const Offset(3, 3),
                  blurRadius: 6,
                )
              ]
            : title == listNoState
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      offset: const Offset(2, 2),
                      blurRadius: 2,
                    )
                  ],
      ),
      child: Column(
        children: [
          Text(
            offer.oMName!,
            style: TextStyle(
              color: isDragging ? Colors.white : Colors.black,
            ),
          ),
          Text(
            offer.customer!,
            style: TextStyle(
              color: isDragging ? Colors.white : Colors.black,
            ),
          ),
          Text(
            DateFormat('yyyy/MM/dd').format(DateTime.parse(offer.offerDate!)),
            style: TextStyle(
              color: isDragging ? Colors.white : Colors.black,
            ),
          ),
          Text(
            offer.mony.toString(),
            style: TextStyle(
              color: isDragging ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String getTotalMaony(String title) {
    double mony = widget.states
            .firstWhere(
              (element) => (element.arName == title) || (element.enName == title),
            )
            .totMony ??
        0.0;
    return mony.toString();
  }

  getColor(String title) {
    String col = widget.states
            .firstWhere(
              (element) => (element.arName == title) || (element.enName == title),
            )
            .color ??
        "#ffffff";
    return hexToColor(col);
  }

  // دالة لتحويل الكود hex إلى لون
  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', ''); // إزالة #

    // إضافة شفافية كاملة إذا لم يكن الكود يحتوي على 8 خانات (ARGB)
    if (hex.length == 6) {
      hex = "FF$hex"; // إضافة الشفافية
    }

    return Color(int.parse("0x$hex"));
  }
}*/
