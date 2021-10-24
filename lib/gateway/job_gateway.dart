import 'package:cleanproject/gateway/api_gateway.dart';
import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/model/job_mockup.dart';


class JobGateWay extends APIGateway {

  Future<List<Job>> fetchAll() async {

    // fetch data from server
    // var response = await httpClient.get('path');
    // List<Job> result = (response as List<dynamic>).map((u) => Job.fromJson(u)).toList();
    // return result;

    // return users from mockup data
    return getListJobMockup();
  }
}