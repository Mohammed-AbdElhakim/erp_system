import 'package:erp_system/features/tasks/data/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/task_repo_impl.dart';
import '../manager/notes/notes_cubit.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key, required this.idTask});
  final int idTask;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<NoteModel> listNotes = [];
  String note="";
  bool show =false;
  bool isEdit=false;
  late NoteModel noteData;
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(getIt.get<TaskRepoImpl>())
        ..getAllNoteList(idTask: widget.idTask),
      child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is AllNotesSuccess) {
            listNotes = state.listNote;
          }
          if (state is AddNotesSuccess||state is DeleteNotesSuccess||state is UpdateNotesSuccess) {
            BlocProvider.of<NotesCubit>(context)
                .getAllNoteList(idTask: widget.idTask);
          }

        },
        builder: (context, state) {
          if (state is NotesFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else if (state is NotesLoading) {
            return const CustomLoadingWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Visibility(
                    visible:show,
                    replacement:  CustomButton(
                      text: S.of(context).add_new,
                      onTap: () {
                        setState(() {
                          show=true;
                        });
                      },
                    ),child: Column(children: [
                    buildTextWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButton(
                              text: isEdit?S.of(context).btn_edit:S.of(context).save,
                              onTap: () {
                                if(isEdit){
                                  BlocProvider.of<NotesCubit>(context)
                                      .updateNotes(
                                    taskID: noteData.taskID!
                                    ,note: controller.text,
                                  dateNote: noteData.nDate!,
                                  empID: noteData.empID!,
                                  tNID: noteData.tNID!,
                                  );
                                }else{
                                  BlocProvider.of<NotesCubit>(context)
                                      .addNewNotes(taskID: widget.idTask
                                    ,note: note,);
                                }

                                setState(() {
                                  show=false;
                                  isEdit=false;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButton(
                              text: S.of(context).cancel,
                              color: Colors.red,
                              noGradient: true,
                              onTap: () {
                                setState(() {
                                  show=false;
                                  isEdit=false;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],),),


                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [

                                Expanded(
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(DateFormat('MMM d, y').format(DateTime.parse(listNotes[index].nDate!).toLocal()),
                                        style:  TextStyle(fontWeight: FontWeight.bold,
                                            backgroundColor: Colors.blue.shade100),),
                                      Text(listNotes[index].note!,),
                                    ],
                                  ),
                                ),
                                Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            show=true;
                                            isEdit=true;
                                            controller.text=listNotes[index].note!;
                                            noteData=listNotes[index];
                                          });

                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                    const SizedBox(height: 12),
                                    InkWell(
                                        onTap: () {
                                          BlocProvider.of<NotesCubit>(context)
                                              .deleteNotes(noteID: listNotes[index].tNID!,)
                                          ;
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),

                                  ],
                                )


                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listNotes.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Widget buildTextWidget() {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onChanged: (value) {
        setState(() {
          note=value;
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.grey,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.blueDark,
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.blueDark,
            )
        ),
      ),
    );
  }
}
