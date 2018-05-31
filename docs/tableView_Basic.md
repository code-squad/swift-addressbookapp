## 테이블뷰와 셀 스타일 기본

### 테이블뷰 생성
- 스토리보드에서 UITableViewController 추가하여 이용
- 코드로는 커스텀 클래스에 UITableViewDataSource와 UITableViewDelegate 프로토콜 구현하여 테이블뷰컨트롤러로 이용
- 커스텀 클래스를 따로 프로토콜을 구현하지않고 프로젝트 내에 파일 추가시 Cocoa Touch Class를 선택하여 UITableViewController를 추가하는 방법도 있다.
  - 참고: `class UITableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource`

### Static Cells / Dynamic Prototypes
테이블뷰의 특성은 동적 프로토타입 / 정적 셀 이 있다. 새로운 테이블뷰를 생성할 때 기본 설정 값은 동적 프로토타입이다.
- Dynamic Prototypes (동적 프로토타입)
  - 행(셀)의 개수가 고정되어있지 않는 테이블뷰에 사용.
  - 앱이 실행되는 도중 상태가 바뀌면 (ex. 사용자가 목록에서 항목을 삭제하거나 추가하는 행동을 할때) 셀의 개수가 상황에 따라 변경된다.
  - UITableViewDataSource 인스턴스에 의해 콘텐츠를 관리
  - 셀 하나를 디자인해 이를 다른 셀의 템플릿으로 사용
- Static Cells (정적 셀)
  - 말그대로 정적. 고정된 레이아웃과 행(셀)의 수를를 가지는 테이블뷰에 사용한다.
  - 테이블뷰를 만드는 시점에 테이블의 형태와 셀의 수가 정해져있는 경우 사용한다. 앱이 실행되면서 상태가 바뀐다고해서 테이블뷰의 셀의 수가 변화되거나 하지 않는다.

### 테이블뷰 스타일
- plain
  - 하나 이상의 섹션을 가질 수 있음
  - 섹션 또한 하나 이상의 열(row)을 가질 수 있고, 각 섹션은 header와 footer를 가질 수 있음
  - (헤더와 섹션에 이미지를 넣고싶으면 커스텀뷰를 가지게 할 수도 있다.)
  - indexed list : 주소록처럼 인덱스가 섹션의 헤더 타이틀이고 오른쪽 스크롤에 인덱스가 표시됨
  - selection list
- grouped
  - 섹션이 그룹핑되어있는 형태로, 각각의 섹션이 시각적으로 구분되어 보임
  - 구분된 섹션은 회색으로 배경이 처리되고 그룹 내의 셀들은 흰색 배경

### 셀 스타일
- 테이블에서 열(row)형태로 그려진 셀. 셀 스타일은 네가지가 제공된다.
- [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell)클래스를 이용하여 셀의 content와 background를 관리한다.
- 가장 간단한 방법은 predefined styles을 사용하는 것이다.
  - [UITableViewCellStyleDefault](https://developer.apple.com/documentation/uikit/uitableviewcellstyle/default): 왼쪽에 이미지, 이미지 옆은 타이틀 한개 있는 형태
  - [UITableViewCellStyleSubtitle](https://developer.apple.com/documentation/uikit/uitableviewcellstyle/subtitle): default스타일과 동일하지만 타이틀 아래에 subtitle(상세 설명. 작은 글씨)이 있는 형태
  - [UITableViewCellStyleValue1](https://developer.apple.com/documentation/uikit/uitableviewcellstyle/uitableviewcellstylevalue1): 이미지가 없고 셀 왼쪽에 타이틀이 있고 오른쪽에 subtitle이 있는 형태. 이미지를 넣을 수 없다.
  - [UITableViewCellStyleValue2](https://developer.apple.com/documentation/uikit/uitableviewcellstyle/value2): 마찬가지로 이미지를 넣을 수 없으며, 셀 왼쪽에 subtitle이 있고 오른쪽에는 description이 있는 형태.

- [테이블 뷰 셀에 대한 상세설명 - Table View Programming Guide - A Closer Look at Table View Cells ](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7-SW1)

### 악세서리 뷰
accessory-type constants로 제공되는 세 개의 표준 뷰가 있다.
<img src="./accessoryView.png" width="100%">
- [이미지 출처 - Table View Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewStyles/TableViewCharacteristics.html#//apple_ref/doc/uid/TP40007451-CH3-SW1)
