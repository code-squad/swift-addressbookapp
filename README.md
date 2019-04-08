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

```swift
let familyNameSortDescriptor = NSSortDescriptor(key: CNContact.familyNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
let givenNameSortDescriptor = NSSortDescriptor(key: CNContact.givenNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
let sortDescriptors = [familyNameSortDescriptor, givenNameSortDescriptor]
let sortedContacts = (contacts as NSArray).sortedArray(using: sortDescriptors)
guard let contacts = sortedContacts as? [CNContact] else { return }
self.contacts = contacts
```

- 언어 및 지역 설정 하는 방법에 대해 배웠다.
1. 시뮬레이터에 들어가서 `설정 -> 일반 -> 언어 및 지역`에서 설정 가능.
2. Xcode에서 `Edit Scheme -> Run -> option -> Application Language, Application Region`에서 설정 가능

`UILocalizedIndexedCollation`를 이용할때 Language에 따라 section index title이 달라지기 때문에 알아보게 되었다.

<img width="927" alt="2019-04-05_17-04-52" src="https://user-images.githubusercontent.com/38850628/55613182-fd83f180-57c4-11e9-99a0-eb8a78a5d8a6.png">

- 유니코드 한글 분석 하는 법을 배웠다. 

`( (초성 * 21) + 중성 ) * 28 + 종성 + 0xAC00 = 글자`  

> 조립은 분해의 역순이다.

초성 구하는 방법은 위 식의 역순으로 `0xAC00`을 빼죽고 `28`을 나누고 `21`을 나눠주면 됩니다.

그리고 자음 유니코드가 시작하는 `0x1100`를 더해주면 끝.

```swift
let scalar = Unicode.Scalar("흥")
let consonantIndex = (scalar.value - 0xac00) / 28 / 21
let consonantScalar = Unicode.Scalar(consonantIndex + 0x1100)!

print(consonantScalar)  //ㅎ
```

- 같은 모양, 다른 값의 자음이 존재한다는 것을 알게됐다.

<img width="400" alt="2019-04-06_17-14-18" src="https://user-images.githubusercontent.com/38850628/55666874-8e270400-588f-11e9-91ae-d61704dcc13c.png">
<img width="400" alt="2019-04-06_17-14-31" src="https://user-images.githubusercontent.com/38850628/55666875-8e270400-588f-11e9-9d31-4199be317744.png">

<del>유니코드 분석을 통해 추출된 초성 `ㄱ`은 4352값이 나오고 미리 지정해둔 자음배열의 `ㄱ`은 12593값이 나왔다.  
그래서 원하는대로 딕셔너리에 값이 들어가지 않아서 이 문제를 유니코드 분석후 마지막에 `0x1100` 대신 `0x3131`을 더해주
는 방법으로 해결했다.</del>

해결 못했었다. 숫자 증가량이 달라 일부는 잘 나오고 일부는 나오지 않았었다.
(아래 표를 보면 왼쪽에 추출해서 나온 자음은 'ㄱ'에서 'ㄴ'으로 갈때 2가 증가하지만 오른쪽에 직접입력한 자음은 'ㄱ'에서 'ㄴ'으로 갈때 3이 증가한다.)

왼쪽과 오른쪽의 연관된 규칙도 보이지 않아 서로를 이어주는 매퍼를 만드는것으로 문제를 해결했다.

<img width="261" alt="2019-04-08_22-35-29" src="https://user-images.githubusercontent.com/38850628/55728237-ab560100-5a4e-11e9-9ef2-daf246ae6b24.png">

`출처 - https://winplz.tistory.com/entry/한글-자음-비교같지만-다른-자음들`

- `func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int` 에서 return 값을 `-1`로 주면 이동하지 않는다는것을 배웠다.

### 실행화면

<img src="https://user-images.githubusercontent.com/38850628/55667595-1a89f480-5899-11e9-8b95-36d48fe5ec8a.PNG" height="700">

## step-03. 검색하기

### 배운내용

- `UISearchController`에 대해서 배웠다.

1. `navigationItem.searchController` 또는 `tableView.tableHeaderView`에 주로 위치시켜서 사용한다.
2. `searchResultsUpdater` property에 `UISearchResultsUpdating` 프로토콜을 채택한 객체를 넣어서 사용한다.
3. `searchBar`를 가지고 있다.
4. `dimsBackgroundDuringPresentation`를 `false`로 한다. 이 속성을 `true`로 하면 검색중일때 `searchable content`가 흐려진다.
5. `dimsBackgroundDuringPresentation` 대신 `obscuresBackgroundDuringPresentation`를 사용한다. * 애플 공식문서에 딱 저렇게(아래 Discussion)만 나와있었습니다...

<img width="500" alt="2019-04-07_14-39-16" src="https://user-images.githubusercontent.com/38850628/55679235-f7b41a80-5942-11e9-94d1-35ce3ddf6c38.png">

- `MGCContactStore`에 `fetchContacts(with:completion:)`라는 메서드가 있는데 검색할때 사용하면 되게 좋다는 것을 배웠다.

- `navigationItem.hidesSearchBarWhenScrolling = false`를 하면 검색창을 상단에 고정할 수 있다는 것을 배웠다.

### 실행화면

<img width="500" src="https://user-images.githubusercontent.com/38850628/55726605-22899600-5a4b-11e9-92f6-5d763b2ddbdb.png">
