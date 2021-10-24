import 'package:cleanproject/model/user.dart';

class Job {
  int? id;
  String? title;
  String? description;
  JobType? jobType;
  JobStatus? jobStatus;
  DateTime? deadline;
  User? createUser;
  List<User>? assigned;

  Job({this.jobType, this.jobStatus, this.title, this.description, this.id, this.assigned, this.createUser, this.deadline});

  factory Job.fromJson(Map<String, dynamic> json) {
    User? _createUser;
    if (json['createUser'] != null) {
      _createUser = User.fromJson(json['createUser']);
    }

    List<User>? _assigned;
    if (json['assigned'] != null) {
      _assigned = (json['assigned'] as List<dynamic>).map((u) => User.fromJson(u)).toList();
    }

    JobType? _jobType;
    if (json['jobType'] != null) {
      switch (json['jobType']) {
        case 'urgent':
          _jobType = JobType.urgent;
          break;

        default:
          _jobType = JobType.normal;
          break;
      }
    }

    JobStatus? _jobStatus;
    if (json['jobStatus'] != null) {
      switch (json['jobStatus']) {
        case 'process':
          _jobStatus = JobStatus.inProcess;
          break;

        case 'done':
          _jobStatus = JobStatus.done;
          break;

        default:
          _jobStatus = JobStatus.normal;
          break;
      }
    }

    return Job(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        assigned: _assigned,
        createUser: _createUser,
        jobStatus: _jobStatus,
        jobType: _jobType,
        deadline: DateTime.parse(json['deadline'])
    );
  }
}

enum JobType { normal, urgent }
enum JobStatus { normal, inProcess, done }
