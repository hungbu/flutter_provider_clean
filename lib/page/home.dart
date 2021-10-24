import 'package:cleanproject/common/constant.dart';
import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/page/update_job.dart';
import 'package:cleanproject/repository/job_repository.dart';
import 'package:cleanproject/widget/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextStyle jobTitleStyle = TextStyle(fontWeight: FontWeight.w500);
  TextStyle jobDesStyle = TextStyle(color: Colors.black54);

  @override
  void initState() {
    _init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.addJob);
            },
            child: Text('Add Job', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StreamBuilder<List<Job>>(
        stream: Provider.of<JobRepository>(context, listen: false).streamJobs,
        builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          return Center(child: Text("OOPS!"),);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();

            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return listJob(snapshot.data);

            case ConnectionState.done:
              return Container();
          }
        }})
      )
    );
  }


  // build list job
  Widget listJob(List<Job>? jobs) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: jobs!.length,
      itemBuilder: (context, index) {
        return jobWidget(jobs[index]);
      }
    );
  }

  Widget jobWidget(Job job) {

    // make  job urgent border color is red
    Color jobTypeColor = job.jobType == JobType.urgent ? Colors.red : Colors.grey;

    List<Widget> assigned;
    if(job.assigned == null || job.assigned!.length == 0) {
      assigned = [Container()];
    } else {
      assigned = job.assigned!.map((u) => Avatar(url: u.avatar ?? '')).toList();
    }

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJobPage(job: job)));
      },
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                children: [
                  Expanded(child: Text(job.title ?? '', style: jobTitleStyle)),
                  SizedBox(width: 8,),
                  Container(
                    child: jobStatusWidget(job.jobStatus),
                  )
                ],
              ),
              Divider(),
              Text(job.description ?? '',style: jobDesStyle, overflow: TextOverflow.ellipsis, maxLines: 3,),
              SizedBox(height: 16,),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey,),
                  SizedBox(width: 8,),
                  Text(DateFormat('d MMMM yyyy').format(job.deadline ?? DateTime.now()), style: jobDesStyle),
                  Expanded(child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: assigned,
                  ))
                ],
              )
        ],
      ),
      )
    );
  }



  Widget jobStatusWidget(JobStatus? jobStatus) {

    return jobStatus == JobStatus.normal ? Container() : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Status: ', style: TextStyle(fontSize: 12, color: Colors.grey),),
        Text(
          jobStatus == JobStatus.inProcess ? "In Process" : "Done",
          style: TextStyle(
            color: jobStatus == JobStatus.inProcess ? Colors.orangeAccent : Colors.green,
            fontSize: 12
          )

        )
      ],
    );
  }

  // init all data needed
  _init() async {
    await Provider.of<JobRepository>(context, listen: false).fetchJobs();
  }
}
