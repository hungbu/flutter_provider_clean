import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/repository/job_repository.dart';
import 'package:cleanproject/widget/avatar.dart';
import 'package:cleanproject/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class UpdateJobPage extends StatefulWidget {
  final Job job;
  const UpdateJobPage({required this.job});

  @override
  _UpdateJobPageState createState() => _UpdateJobPageState();
}

class _UpdateJobPageState extends State<UpdateJobPage> {

  @override
  Widget build(BuildContext context) {

    TextStyle jobTitleStyle = TextStyle(fontWeight: FontWeight.w500);
    TextStyle jobDesStyle = TextStyle(color: Colors.black54);
    // make  job urgent border color is red
    Color jobTypeColor = widget.job.jobType == JobType.urgent ? Colors.red : Colors.grey;

    List<Widget> assigned;
    if(widget.job.assigned == null || widget.job.assigned!.length == 0) {
      assigned = [Container()];
    } else {
      assigned = widget.job.assigned!.map((u) => Avatar(url: u.avatar ?? '')).toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Job detail'), actions: [
        FlatButton(onPressed: () {
          _doRemove();
        }, child: Text("remove", style: TextStyle(color: Colors.white),))
      ],),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.5),
          gradient: new LinearGradient(
              stops: [0.02, 0.02],
              colors: [jobTypeColor, Colors.white]
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(child: Text(widget.job.title ?? '', style: jobTitleStyle)),
                SizedBox(width: 8,),
                Container(
                  child: jobStatusWidget(widget.job.jobStatus),
                )
              ],
            ),
            Divider(),
            Text(widget.job.description ?? '',style: jobDesStyle),
            SizedBox(height: 16,),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey,),
                SizedBox(width: 8,),
                Text(DateFormat('d MMMM yyyy').format(widget.job.deadline ?? DateTime.now()), style: jobDesStyle),
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: assigned,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget jobStatusWidget(JobStatus? jobStatus) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Status: ', style: TextStyle(fontSize: 12, color: Colors.grey),),
        DropdownButton<JobStatus>(
          value: widget.job.jobStatus,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 1,
            color: Colors.grey,
          ),
          onChanged: (JobStatus? newValue) {
            print(newValue.toString());
            if(newValue != null) {
              setState(() {
                widget.job.jobStatus = newValue;
                Provider.of<JobRepository>(context, listen: false).updateJob(widget.job);
              });
            }
          },
          items: [JobStatus.normal, JobStatus.inProcess, JobStatus.done].map<DropdownMenuItem<JobStatus>>((JobStatus value) {
            return DropdownMenuItem<JobStatus>(
              value: value,
              child: Text(_jobStatusToString(value), textAlign: TextAlign.end,),
            );
          }).toList(),
        )
      ],
    );
  }

  String _jobStatusToString(JobStatus status) {
    switch(status) {
      case JobStatus.normal:
        return 'none';
      case JobStatus.inProcess:
        return 'In Process';
      case JobStatus.done:
        return 'Done';
    }
  }

  void _doRemove() {
    showDialog(
      context: context,
      builder: (_) {
        return IconDialog(
          icon: Icons.delete_forever_outlined,
          title: 'Remove',
          content: Text('Remove this job, are you sure?'),
          textPositive: 'Cancel',
          textNegative: 'Agree',
          color: Colors.deepOrange,
          onPositive: () {
            Navigator.of(context).pop();
          },
          onNegative: () async {

            Provider.of<JobRepository>(context, listen: false).removeJob(widget.job);
            /// back to homepage
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }
}
