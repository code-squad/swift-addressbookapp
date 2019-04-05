# swift-addressbookapp
iOS 레벨3 주소록 앱 저장소

## step-01. 앱 설계하기

### 배운내용
- 샘플코드를 가져와서 적용하는 법을 배웠다.
- 연락처를 사용하려면 info.plist에 `Privacy - Contacts Usage Description`를 YES로 해야한다는 것을 알게 되었다.
- 샘플코드가 너무 잘 만들어져있어서 코딩하기 참 편한 세상에서 살고 있다는 것을 배웠다.

### 실행화면

<img src="https://user-images.githubusercontent.com/38850628/55384401-9a485400-5565-11e9-81ab-0e30ffd25ed6.png" height="700">

## step-02. 섹션 정렬

### 배운내용

- 다양한 순서로 정렬하는 방법을 배웠다.

`NSDescriptor`와 `(NSArray).sortedArray(using:)`을 사용하면 됨.
<script src="https://gist.github.com/hngfu/23fa7e4405b0810efd42b86957c8a515.js"></script>
