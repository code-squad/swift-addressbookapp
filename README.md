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

##### 피드백
* 고치기 전
    * 모델 클래스가 뷰를 알거나 델리게이트 메소드를 그대로 가져올 필요는 없어요. 그럴거면 DataSource 역할을 하는 객체를 따로 만드는게 좋습니다.
    * Cell을 채우는 코드는 차라리 Cell 내부에 구현하고, Cell에게는 필요한 데이터만 넘기세요. 
    * 만약 ViewController가 DataSource 역할을 할꺼면 holidays: [Holiday] = [Holiday]() 를 대체하는 객체만 만들고,
    * DataSource 프로토콜을 구현하는 메소드에서 모델 객체에 필요한 데이터만 요청해서 받아서 Cell을 채우세요.
    
```swift
class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var holidays: [Holiday] = [Holiday]()

    // ...
}

class HolidayBox {
    private var holiday: Holiday
    
    init(_ holiday: Holiday) {
        self.holiday = holiday
    }
    
    func cell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewProperties.holidayTableCell, for: indexPath)
        cell.textLabel?.text = holiday.date
        cell.detailTextLabel?.text = holiday.subtitle
        return cell
    }
}
```

* 고친 후
    * 피드백에 대해 제대로 이해하지 못함
    * `HolidayViewController가 [Holiday]를 직접 가지고 있는게 아니라 [Holiday]를 가지고 있는 HolidayDataManager 객체가 가지고 있는 속성이나 함수를 통해 접근해야 함`
    * 예전에 자판기 앱 했을 때 동일한 작업인데, 놓치고 있었음. 프로토콜 이런 것보다 새로운 객체로 쪼갤 수 있다면 그렇게 처리하고 쉽게 생각하고 기본에 충실하자:)

```swift
class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var holidayDataManager: HolidayDataManager!
    private let cellIndentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        holidayDataManager = HolidayDataManager().convert(HolidayJson.string)
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        cell.textLabel?.text = holidayDataManager[indexPath.row].date
        cell.detailTextLabel?.text = holidayDataManager[indexPath.row].subtitle
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidayDataManager.count
    }
}
```

##### 학습거리 
* UITableViewController와 UIViewController에 UITableView를 추가한 차이를 학습함
* DataSource 프로토콜을 구현하기 위한 필수 메소드 형식과 동작 방식을 정리함
* Delegate 패턴과 DataSource 프로토콜과 비슷한 점, 차이점은 무엇인지 학습함