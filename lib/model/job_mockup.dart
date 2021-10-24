import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/model/user_mockup.dart';

List<Job> getListJobMockup () {
  List<Job> jobs = [
    Job(id: 1, title: "Job 1", description: "Job description 1", deadline: DateTime.now().add(Duration(days: 1)), jobType: JobType.normal, jobStatus: JobStatus.normal, createUser: getMe(), assigned: [getUserById(1)]),
    Job(id: 2, title: "Can't delete user on the top button",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ultricies dolor lacus, nec condimentum diam blandit id. Vivamus mollis risus eu vulputate tincidunt. Morbi sagittis, tellus sit amet mattis elementum, arcu sapien placerat augue, in commodo quam ipsum in turpis. Proin lobortis mauris ex, non lobortis sem elementum et. Cras ut interdum risus, sit amet aliquam quam. Vestibulum nec odio venenatis lorem bibendum ultricies. Mauris finibus ut ligula quis euismod. Curabitur imperdiet tortor libero, ut tristique libero dapibus ut. Quisque dignissim ante ligula, eu molestie libero dictum ac. Cras libero ipsum, pretium vel ipsum et, sodales pulvinar odio. ",
        deadline: DateTime.now().add(Duration(days: 5)), jobType: JobType.urgent, jobStatus: JobStatus.inProcess, createUser: getMe(), assigned: [getUserById(2)]),
    Job(id: 3, title: "Job 3", description: "Job description 3", deadline: DateTime.now().add(Duration(days: 2)), jobType: JobType.normal, jobStatus: JobStatus.done, createUser: getMe(), assigned: [getUserById(3), getUserById(2)]),

  ];

  return jobs;
}