class Note {
  int? id;
  String? title;
  String? description;
  DateTime? time;

  Note({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? time,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'title': title,
      'description': description,
      'time': time?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, Object?> map) {
    return Note(
      id: map['_id'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      time: map['time'] != null ? DateTime.parse(map['time'] as String) : null,
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }
  //covariant kıyaslama yapmak için var 

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
  }
  //hashCode metodunun kullanım amacı, bir nesnenin koleksiyonlarda (örneğin, Set veya Map) veya == operatörü ile eşitlik kontrolünde kullanılmasını sağlamaktır. Eşit nesneler aynı hashCode değerine sahip olmalıdır. Bu, koleksiyonlarda nesneleri hızlıca bulmak ve eşitlik durumunu doğru bir şekilde kontrol etmek için kullanılır.
}
