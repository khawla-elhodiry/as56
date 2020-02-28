class Group {
  String title;


  Group({
    this.title,

  });

  Group.fromMap(Map map) :
        this.title = map['title'];

  Map toMap(){
    return {
      'title': this.title,

    };
  }
}