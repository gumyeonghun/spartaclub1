import 'dart:io';

// -----------------------------------------------------------
// 1. Score와 StudentScore 클래스 구성 (객체 지향)
// -----------------------------------------------------------

/// 점수를 표현하는 기본 클래스 (필수 정의: Score 클래스)
class Score {
final int score;

/// 생성자
Score(this.score);

/// 현재 점수를 출력하는 메서드
void showInfo() {
print('점수: $score'); // 출력 형태: 점수: 90
}
}

/// 학생의 정보를 포함하는 클래스 (필수 정의: Score 클래스 상속)
class StudentScore extends Score {
final String name;

/// 생성자: 상위 클래스(Score)의 생성자를 호출
StudentScore(this.name, int score) : super(score);

/// 상위 클래스의 showInfo() 메서드를 재정의 (Overriding)
@override
void showInfo() {
print('이름: $name, 점수: $score'); // 출력 형태: 이름: 홍길동, 점수: 90
}

/// 파일 저장을 위한 문자열 형식 반환
String toFileString() {
return '이름: $name, 점수: $score';
}
}

// -----------------------------------------------------------
// 2. 파일로부터 데이터 읽어오기 기능 (컬렉션 활용)
// -----------------------------------------------------------

/// students.txt 파일에서 학생 데이터를 읽어와 List<StudentScore>를 반환합니다.
List<StudentScore> loadStudentData(String filePath) {
final List<StudentScore> students = [];
print("✅ 학생 데이터를 불러오는 중...");

try {
final file = File(filePath);
// 동기 방식으로 파일의 모든 줄을 읽어옴
final lines = file.readAsLinesSync();

    for (var line in lines) {
      final parts = line.split(','); // CSV 데이터 분리
      
      if (parts.length != 2) {
        print('경고: 잘못된 데이터 형식 무시 - $line');
        continue;
      }

      try {
        String name = parts[0].trim();
        // 점수를 int로 변환
        int score = int.parse(parts[1].trim()); 

        // StudentScore 객체 생성 및 List<StudentScore>에 저장 (컬렉션 활용)
        students.add(StudentScore(name, score));
      } on FormatException {
        print('경고: 점수 형식이 잘못되어 무시 - $line');
      }
    }
    print("✅ ${students.length}명의 학생 데이터를 성공적으로 불러왔습니다.");

} catch (e) {
// 파일이 없거나 읽기 오류 발생 시
print("❌ 학생 데이터를 불러오는 데 실패했습니다: $e");
// 프로그램 즉시 종료
exit(1);
}

return students;
}

// -----------------------------------------------------------
// 4. 프로그램 종료 후, 결과를 파일에 저장하는 기능
// -----------------------------------------------------------

/// 결과를 result.txt 파일에 저장합니다.
void saveResults(String filePath, String content) {
try {
final file = File(filePath);
// 동기 방식으로 파일에 문자열을 씁니다.
file.writeAsStringSync(content);
print("✅ 저장이 완료되었습니다."); // 필수 조건: "저장이 완료되었습니다." 출력
print("(저장 파일: $filePath)");
} catch (e) {
print("❌ 저장에 실패했습니다: $e");
}
}

// -----------------------------------------------------------
// 메인 실행 함수 (3. 사용자 입력 및 전체 흐름 제어)
// -----------------------------------------------------------

void main() {
// 2. 학생 데이터 불러오기
final List<StudentScore> students = loadStudentData('students.txt');

if (students.isEmpty) {
print("분석할 학생 데이터가 없어 프로그램을 종료합니다.");
return;
}

// 3. 사용자로부터 입력 받아 학생 점수 확인 기능

StudentScore? selectedStudent;
String? resultString; // 최종 저장할 문자열

// 올바른 학생 이름이 입력될 때까지 반복
while (selectedStudent == null) {
stdout.write("\n어떤 학생의 통계를 확인하시겠습니까? (예시 학생: ${students.map((s) => s.name).join(', ')}): ");

    // 사용자 입력 받기
    String? inputName = stdin.readLineSync()?.trim(); 

    if (inputName == null || inputName.isEmpty) {
      print("잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.");
      continue;
    }
    
    // 입력된 이름으로 학생 찾기
    try {
      selectedStudent = students.firstWhere(
        (student) => student.name == inputName
      );

      // 학생 정보 출력
      print("🔎 확인 결과:");
      selectedStudent.showInfo(); // 출력 예시: "이름: 홍길동, 점수: 90"
      
      // 저장할 문자열 생성
      resultString = selectedStudent.toFileString(); 
      
    } on StateError {
      // firstWhere가 요소를 찾지 못했을 때 StateError 발생
      print("잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.");
      selectedStudent = null; // 반복 계속
    }
}

// 4. 결과 파일 저장 및 프로그램 종료
if (resultString != null) {
print("\n📝 결과를 파일에 저장하고 프로그램을 종료합니다.");
saveResults('result.txt', resultString);
}
}