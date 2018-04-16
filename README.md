# 주소록앱

### 1. 시작하기 - UITableViewController

##### 프로그래밍 요구사항
* 스토리보드에 새로운 TableViewController를 추가하고, Initial ViewController로 지정함
* DateTimeCell 부분을 다음과 같이 디자인함
    * 셀 높이는 80으로 지정함
    * 가이드라인에 맞춰서 윗 부분에는 dateLabel과 timeLabel 이 폭을 2등분함
    * dateLabel은 좌측 정렬, timeLabel은 우측 정렬함
    * dateLabel과 timeLabel 높이는 24보다 크고 절반을 차지함
    * 그 아래 eventLabel가 위치하고 높이는 20보다 크고 나머지 영역을 차지함
* eventLabel 내용은 가운데 정렬하고, 글자 크기는 14, 글자색은 회색
    * WeatherCell 부분을 다음과 같이 디자인함
    * UIImageView로 셀 전체에 배경 이미지를 지정함
    * 이미지는 에셋에 추가한 4장 중에 하나로 선택하고, contentMode를 aspectToFill 로 지정함
    * 그 위에 weatherDescription 과 detailButton을 위치함
    * weatherDesciption 글자 크기는 20, 글자색은 흰색으로 지정함
    * 설명은 배경 이미지에 맞춰서 문구를 지정함

##### 실행결과

<img src="./images/address-book-1-1.png" width="45%"></img>
<img src="./images/address-book-1-2.png" width="45%"></img>

##### 학습거리
* 이미지 채우는 contentMode에 대해 학습함
* UITableViewController를 활용해서 static cell을 디자인하는 방식을 학습함

### 2. DataSource 객체

##### 프로그래밍 요구사항
* 스토리보드에 새로운 ViewController (Scene)를 추가하고, Initial ViewController로 지정함
* 새로 추가한 ViewController.View에 TableView를 추가하고 화면 가득하게 채움
    * TableView.Content 속성은 Dynamic Prototypes 로 지정하고, Prototype Cells는 1로 설정함
    * 셀 프로토타입 Style은 Subtitle로 지정하고, reuse identifier 속성에 id를 고유한 값으로 지정함
* UIViewController 에서 상속받아 새로운 뷰컨트롤러 클래스 HolidayViewController를 만들고, 스토리보드 ViewController의 Custom Class로 지정함
    * TableView를 HolidayViewController 클래스의 IBOutlet으로 연결함
    * TableView.dataSource를 HolidayViewController로 지정함
* 다음과 같은 JSON 데이터를 HolidayViewController 코드에 추가하고 JSONSerialization을 활용해서 Array<Dictionary<String,String>> 타입으로 변환함

```
[{"date":"1월1일", "subtitle":"신정"},
{"date":"2월16일", "subtitle":"구정"},
{"date":"3월1일", "subtitle":"삼일절"},
{"date":"5월5일", "subtitle":"어린이날"},
{"date":"5월22일", "subtitle":"석가탄신일"},
{"date":"6월6일", "subtitle":"현충일"},
{"date":"8월15일", "subtitle":"광복절"},
{"date":"9월24일", "subtitle":"추석"},
{"date":"10월3일", "subtitle":"개천절"},
{"date":"10월9일", "subtitle":"한글날"},
{"date":"12월25일", "subtitle":"성탄절"}]
```

* HolidayViewController에 UITableViewDataSource 프로토콜을 채택하고 필수 메소드를 구현함
    * cell.textLabel 에는 date 값을 출력하고, cell.subtitle 에는 subtitle 값을 출력함

##### 실행결과

<img src="./images/address-book-2-1.png" width="45%"></img>

##### 학습거리 
* UITableViewController와 UIViewController에 UITableView를 추가한 차이를 학습함
* DataSource 프로토콜을 구현하기 위한 필수 메소드 형식과 동작 방식을 정리함
* Delegate 패턴과 DataSource 프로토콜과 비슷한 점, 차이점은 무엇인지 학습함