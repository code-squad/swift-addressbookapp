## 테이블뷰 API

### Table View - 테이블뷰
- TableView는 UITableViewClass의 인스턴스이다.
- UITableViewClass의 메소드를 통해 테이블뷰의 외관(appearance)을 설정할 수 있다.
  - (for example, specifying the default height of rows or providing a subview used as the header for the table)
- 또 다른 메소드로는 현재 선택된 열(row), 특정한 열이나 셀에 접근할 수 있다.
- 메소드로는 선택된 셀을 관리하고, 뷰를 스크롤하거나, 열이나 섹션을 추가하거나 제거할 수 있다.
- UITableView는 UIScrollView를 상속받아 스크롤링을 구현하는데, 테이블뷰는 특별하게 수직적 스크롤링(vertical scrolling)만 허용된다.

### Table View Controller - 테이블뷰 컨트롤러
The UITableViewController class manages a table view and adds support for many standard table
- UITableViewController 클래스는 테이블뷰를 관리하는 동작을 한다. 선택 관리(selection management), 열 수정, 테이블 설정 등의 동작들과 관련해서 테이블뷰를 서포트한다.
- 테이블뷰컨트롤러를 직접적으로 사용하지는 않고, UITableViewController를 상속받아서 커스텀클래스를 구현한다.

### Data Source and Delegate - 데이터소스와 델리게이트
- 테이블뷰를 사용하기위해서는 Data Source and Delegate를 반드시 구현해야한다.
- MVC패턴에 따라, data source는 앱의 model과 table view의 중간자 역할을 한다.
- Delegate는 테이블뷰의 동작과 출현(appearance)을 담당한다. view가 변경되는 사항을 델리게이트가 담당하고, 뷰는 그 델리게이트에 의존하여 뷰를 업데이트한다.
- Data source와 Delegate는 같은 객체일수 있고,(한 클래스에서 구현할 수도 있고) 그 클래스는 UITableViewController를 상속받는다.
- Data source는 UITableViewDataSource프로토콜을 따른다.
- Delegate는  UITableViewDelegate프로토콜을 따르며, required메소드는 없고 optional메소드를 필요에 따라 구현하면 된다.

### NSIndexPath Class
- 테이블뷰의 메소드들은 index path를 파라미터나 리턴밸류로 사용한다.
- index path는 중첩된 어레이의 특정한 노드로 가는 경로를 확인하고(identify), foundation프레임워크 내에서는 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath)클래스이다.
- 테이블뷰에서 셀을 index path를 이용하여 정렬할때 사용한다.
- (Swift에서는 NSIndexPath 대신 IndexPath를 사용.)

### Table View Cells - 테이블뷰 셀
- 셀은 UITableViewCell클래스를 상속받는다.
- UITableViewCell클래스는 셀 선택과 편집, 악세서리 뷰 관리, 셀 설정(configuration) 메소드를 제공한다.
- predefined style을 이용해서 미리 정의된 스타일로 셀을 설정 할 수 있음
- 이미 기존에 있는 셀(“off-the-shelf” cell object)에 커스텀서브뷰를 올려서 구현할 수도 있다.
- UITableViewCell클래스를 상속받은 커스텀뷰를 만들어서 셀의 외관(appearance)이나 동작을 만들 수도 있다.
- [테이블뷰 셀에 대한 더 자세한 내용 - A Closer Look at Table View Cells](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7-SW1)
