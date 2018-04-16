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

##### 학습거리
* 이미지 채우는 contentMode에 대해 학습함
* UITableViewController를 활용해서 static cell을 디자인하는 방식을 학습함