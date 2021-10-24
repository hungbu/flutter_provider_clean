import 'dart:async';

import 'package:cleanproject/gateway/job_gateway.dart';
import 'package:cleanproject/model/job.dart';

class JobRepository {
  JobGateWay? _jobGateWay;

  // build singleton
  static final JobRepository _singleton = JobRepository._internal();
  JobRepository._internal();

  factory JobRepository({JobGateWay? jobGateWay}) {
    _singleton._jobGateWay = jobGateWay;
    return _singleton;
  }

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  StreamController<List<Job>> _streamUserController = StreamController<List<Job>>.broadcast();
  Stream<List<Job>> get streamJobs => _streamUserController.stream;

  int newId = 10;

  Future fetchJobs() async {
    _jobs = await _jobGateWay!.fetchAll();
    _streamUserController.add(_jobs);
  }

  Future addJob(Job job) async {
    // add job to server
    //var response = await _jobGateWay.addJob(job: job)
    // Job job = Job.fromJson(response);

    // make job id local
    job.id = newId+=1;

    // add job
    _jobs.add(job);

    // stream new jobs
    _streamUserController.add(_jobs);
  }

  Future updateJob(Job job) async {
    // find index item
    int index = _jobs.indexWhere((j) => j.id == job.id);
    if(index > -1) {

      // update
      _jobs[index] = job;

      //stream new _jobs
      _streamUserController.add(_jobs);
    }
  }

  Future removeJob(Job job) async {
    _jobs.removeWhere((j) => j.id == job.id);

    //stream new _jobs
    _streamUserController.add(_jobs);
  }
}