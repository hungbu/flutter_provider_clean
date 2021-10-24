import 'package:cleanproject/gateway/job_gateway.dart';
import 'package:cleanproject/gateway/user_gateway.dart';
import 'package:cleanproject/repository/job_repository.dart';
import 'package:cleanproject/repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerSetup = [...independentProvider, ...streamProvider];

List<SingleChildWidget> independentProvider = [
  Provider(create: (_) => UserRepository(userGateWay: UserGateWay())),
  Provider(create: (_) => JobRepository(jobGateWay: JobGateWay())),
];

List<SingleChildWidget> streamProvider = [
   //StreamProvider<List<Job>>(create: (context) => Provider.of<JobRepository>(context, listen: false).streamJobs, lazy: false, initialData: listJob),
];