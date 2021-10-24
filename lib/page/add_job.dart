import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/model/user.dart';
import 'package:cleanproject/repository/job_repository.dart';
import 'package:cleanproject/repository/user_repository.dart';
import 'package:cleanproject/widget/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Job _newJob = new Job(jobType: JobType.normal, deadline: DateTime.now(), jobStatus: JobStatus.normal);
  String validateMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job"),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            SizedBox(height: 16,),
            Text("Title"),
            TextFormField(controller: titleController),

            SizedBox(height: 32,),
            Text("Description"),
            TextFormField(controller: descriptionController, minLines: 2, maxLines: 5,),

            SizedBox(height: 32,),
            _buildJobTypeWidget(),

            SizedBox(height: 32,),
            _buildDatePicker(),

            SizedBox(height: 32,),
            _buildAssignWidget(),
            SizedBox(height: 8,),
            _buildListAssigned(),

            SizedBox(height: 16,),
            validateMessage != "" ? Center(child: Text(validateMessage, style: TextStyle(color: Colors.red),)) : Container(),
            SizedBox(height: 32),
            actionButtons()

          ]
        ),
      ),
    );
  }

  Widget _buildJobTypeWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            'Type',
          ),
        ),
        DropdownButton<JobType>(
            value: _newJob.jobType,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            iconSize: 24,
            elevation: 16,
            underline: Container(
            height: 1,
            color: Colors.grey,
            ),
            onChanged: (JobType? newValue) {
              if(newValue != null) {
                setState(() {
                  _newJob.jobType = newValue;
                });
              }
            },
            items: [JobType.normal, JobType.urgent].map<DropdownMenuItem<JobType>>((JobType value) {
            return DropdownMenuItem<JobType>(
            value: value,
            child: Text(value == JobType.normal ? 'normal' : 'urgent', textAlign: TextAlign.end,),
            );
            }).toList(),
        )
      ],
    );
  }

  Widget _buildDatePicker() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Deadline'
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {

              DatePicker.showDatePicker(
                  context,
                  minDateTime: DateTime.now(),
                  maxDateTime: DateTime.now().add(Duration(days: 365)), // 1 year
                  initialDateTime: _newJob.deadline,
                  dateFormat: "'d MMMM yyyy'",
                  locale: DateTimePickerLocale.en_us,
                  onConfirm: (pick, result) {
                    if(pick != null) {
                      setState(() {
                        _newJob.deadline = pick;
                      });
                    }
                  },
                  pickerTheme: DateTimePickerTheme.Default,
                  pickerMode: DateTimePickerMode.date
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text( _newJob.deadline != null ? DateFormat('d MMMM yyyy').format(_newJob.deadline ?? DateTime.now()) : "",
                  textAlign: TextAlign.end,
                ),
                SizedBox(width: 8,),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            'Assign to',
          ),
        ),
        DropdownButton<User>(
          value: Provider.of<UserRepository>(context).users.first,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 1,
            color: Colors.grey,
          ),
          onChanged: (User? newValue) {
            setState(() {
              if(_newJob.assigned == null)  {
                _newJob.assigned =  [];
              }

              if(!_newJob.assigned!.contains(newValue)) {
                _newJob.assigned!.add(newValue!);
              }
            });
          },
          items: Provider.of<UserRepository>(context).users.map<DropdownMenuItem<User>>((User value) {
            return DropdownMenuItem<User>(
              value: value,
              child: Row(children: [
                Avatar(url: value.avatar ?? ""),
                SizedBox(width: 8,),
                Text(value.name ?? "", textAlign: TextAlign.end,)
              ],)
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildListAssigned() {
    return _newJob.assigned != null ? Container(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        reverse: true,
        scrollDirection: Axis.horizontal,
        children: _newJob.assigned!.map((u) => userAssignedWidget(u)).toList(),
      ),
    ) : Container(child: Center(child: Text("Assign list is empty", style: TextStyle(color: Colors.grey),),),);
  }

  Widget userAssignedWidget(User user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _newJob.assigned!.remove(user);
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Avatar(url: user.avatar ?? "")),
          Positioned(
            right: 0,
            top: 1,
            child: Icon(Icons.cancel_rounded, color: Colors.red, size: 16,)
          )
        ],),
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      OutlinedButton(onPressed: () {
        // back to home page
        Navigator.pop(context);
      }, child: Text("Cancel")),

      ElevatedButton(onPressed: _addJob, child: Text("Add Job")),
    ],);
  }

  // validate form data
  bool _validate() {
    bool resultCheck = false;
    setState(() {
      validateMessage = "";
    });

    if(titleController.text.trim() == '') {
      setState(() {
        validateMessage = "Enter title please!";
      });
      return resultCheck;
    }

    if(descriptionController.text.trim() == '') {
      setState(() {
        validateMessage = "Enter description please!";
      });
      return resultCheck;
    }

    if(_newJob.jobType == null) {
      setState(() {
        validateMessage = "Enter Type please!";
      });
      return resultCheck;
    }

    if(_newJob.deadline == null) {
      setState(() {
        validateMessage = "Enter deadline please!";
      });
      return resultCheck;

    }

    if(validateMessage == "") {
      // case ok
      resultCheck = true;
      _newJob.title = titleController.text.trim();
      _newJob.description = descriptionController.text;
    }

    return resultCheck;
  }
  
  _addJob() async {
    // check form validate
    bool checkValidate = _validate();
    if(checkValidate) {

      // set create user
      _newJob.createUser = Provider.of<UserRepository>(context, listen: false).me;

      // add job
      await Provider.of<JobRepository>(context, listen: false).addJob(_newJob);

      // back to home
      Navigator.pop(context);
    }
  }
}
