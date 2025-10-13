import 'dart:io';

void main ()async{



}
class Score {
  final int score;

  /// 생성자
  Score(this.score);

  /// 현재 점수를 출력하는 메서드
  void showInfo() {
    print('점수: $score');
  }
}

/// 학생의 정보를 포함하는 클래스 (Score 클래스 상속)
class StudentScore extends Score {
  final String name;

  /// 생성자: 상위 클래스(Score)의 생성자를 호출
  StudentScore(this.name, int score) : super(score);

  /// 상위 클래스의 showInfo() 메서드를 재정의 (Overriding)
  @override
  void showInfo() {
    print('이름: $name, 점수: $score');
  }

  /// 파일 저장을 위한 문자열 형식 반환
  String toFileString() {
    return '이름: $name, 점수: $score';
  }
}

void loadStudentData(String filePath) {
  try {
    final file = File('students.txt');
    final lines = file.readAsLinesSync();

    for (var line in lines) {
      final parts = line.split(',');
      if (parts.length != 2) throw FormatException('잘못된 데이터 형식: $line');

      String name = parts[0];
      int score = int.parse(parts[1]);
    }
  } catch (e) {
    print("학생 데이터를 불러오는 데 실패했습니다: $e");
    exit(1);
  }
  return;
}


void saveResults(String filePath, String content) {
  try {
    final file = File(filePath);
    file.writeAsStringSync(content);
    print("저장이 완료되었습니다.");
  } catch (e) {
    print("저장에 실패했습니다: $e");
  }
}
