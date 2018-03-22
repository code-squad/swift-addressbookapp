# 주소록 앱

## Step1 (시작하기 - UITableViewController)
### 요구사항
- iOS 프로젝트 Single View App 템플릿으로 하고 프로젝트 이름을 "AddressBookApp"으로 지정하고, 위에 만든 로컬 저장소 경로에 생성한다.
- 기본 상태로 아이폰 8 Plus 시뮬레이터를 골라서 실행한다.
- readme.md 파일을 자신의 프로젝트에 대한 설명으로 변경한다.
    - 단계별로 미션을 해결하고 리뷰를 받고나면 readme.md 파일에 주요 작업 내용(바뀐 화면 이미지, 핵심 기능 설명)과 완성 날짜시간을 기록한다.
    - 실행한 화면을 캡처해서 readme.md 파일에 포함한다.

### 프로그래밍 요구사항
- iOS 프로젝트 Single View App 템플릿으로 하고 프로젝트 이름을 "AddressBookApp"으로 지정하고, 위에 만든 로컬 저장소 경로에 생성한다.
- 아래 이미지 4장을 다운받아 Assets 에 추가한다.
    - http://public.codesquad.kr/jk/weather-sunny.png
    - http://public.codesquad.kr/jk/weather-cloudy.png
    - http://public.codesquad.kr/jk/weather-rainny.png
    - http://public.codesquad.kr/jk/weather-snowy.png
- 스토리보드에 새로운 TableViewController를 추가하고, Initial ViewController로 지정한다.
- 새로 추가한 TableViewController 속성에서 Content 값을 Static Cells로 변경한다. 그리고 DateTimeCell, WeatherCell 2가지 셀을 추가한다.
- DateTimeCell 부분을 다음과 같이 디자인한다.
    - 셀 높이는 80으로 지정
    - 가이드라인에 맞춰서 윗 부분에는 dateLabel과 timeLabel 이 폭을 2등분
    - dateLabel은 좌측 정렬, timeLabel은 우측 정렬
    - dateLabel과 timeLabel 높이는 24보다 크고 절반을 차지
    - 그 아래 eventLabel가 위치하고 높이는 20보다 크고 나머지 영역을 차지한다.
    - eventLabel 내용은 가운데 정렬하고, 글자 크기는 14, 글자색은 회색
- WeatherCell 부분을 다음과 같이 디자인한다.
    - UIImageView로 셀 전체에 배경 이미지를 지정한다.
    - 이미지는 에셋에 추가한 4장 중에 하나로 선택하고, contentMode를 aspectToFill 로 지정한다.
    - 그 위에 weatherDescription 과 detailButton을 위치한다.
    - weatherDesciption 글자 크기는 20, 글자색은 흰색으로 지정한다.
    - 설명은 배경 이미지에 맞춰서 문구를 지정한다.

### 결과
#### UI
![기본 화면](materials/step1_01.png)

---
## 중간에 고생했던 부분 / 기억할 부분 간단 정리
- contentMode
    - Scale To Fill : 정해져 있는 UIImageView의 사이즈에 맞춰 사진 사이즈가 조정된다.
    - Aspect Fit : 정해져 있는 UIImageView의 사이즈의 width나 height 중 사진과 대비하여 작은 사이즈에 맞춰 사진 크기가 조정된다.
    - Aspect Fill : 사진의 사이즈에 맞춰 UIImageView의 사이즈가 조정된다.
- TableViewController의 TableView 속성에서 Content 값을 Static Cells로 정하면 기본 뷰의 디자인을 기호에 맞게 정의할 수 있다.
