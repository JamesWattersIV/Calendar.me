class Event {

  final String title;
  final String date;
  final String time;
  bool isDone;

  Event({this.title, this.isDone = false,this.date,this.time});

  void toggleDone() {
    isDone = !isDone;
  }

}