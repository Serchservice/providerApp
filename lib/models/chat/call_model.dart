class CallModel {
  final bool missed;
  final bool outgoing;
  final bool videoCall;
  final bool t2fVC;
  final String callerName;
  final String callTime;

  CallModel({
    this.missed = false, this.outgoing = false, this.videoCall = false, this.t2fVC = false, required this.callerName, required this.callTime
  });
}