# RxDataSources_Practice

> [RxDataSoureces](https://github.com/RxSwiftCommunity/RxDataSources) 의 How순서에 따라 적용해 보겠습니다.

## 1. `SectionModelType` protocol을 따르는 struct로 section을 정의합니다.

```swift
struct BoardPost {
  var category = "대학생"
  var title = "스위프트 코테 스터디"
  var purpose = makeLabel("목표", content: "5시간")
  var member = makeLabel("인원", content: "1/3명")
  var chief = makeLabel("그룹장", content: "위프트")
  var start = makeLabel("시작일", content: "22. 4. 11")
  var totalTime = makeLabel("공부량", content: "5시간 23분")
  var content = "스위프트 코딩테스트 모집합니다~~"
}

struct SectionOfBoardPost {
  var header: String
  var items: [Item]
}

extension SectionOfBoardPost: SectionModelType {
  typealias Item = BoardPost
  
  init(original: SectionOfBoardPost, items: [BoardPost]) {
    self = original
    self.items = items
  }
}
```

<br>

> [Differentiator](https://github.com/RxSwiftCommunity/RxDataSources/tree/main/Sources/Differentiator) 라이브러리를 사용하면 1번과정을 다음과 같이 줄일 수 있습니다.
>
```swift
typealias SectionOfBoardPost = SectionModel<String, BoardPost>
```



## 2. dataSource 객체를 만들고 `SectionOfCustomData` 타입을 전달한다.

```swift
let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfBoardPost>(
    configureCell: { dataSource, collectionView, indexPath, boardPost in
      
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "Cell",
        for: indexPath
      ) as? BoardCell
      cell?.configureCell(with: boardPost)
      
      return cell ?? UICollectionViewCell()
      
    }, configureSupplementaryView: { dataSource, collectionview, title, indexPath in
      
      let header = collectionview.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: "Header",
        for: indexPath
      ) as? BoardHeaderView
      
      let title = dataSource.sectionModels[indexPath.section].header
      header?.configureHeader(with: title)
      
      return header ?? UICollectionReusableView()
    }
  )
  ```
 
 <br>
 

## 3. 필요에따라 dataSource의 closure를 커스텀합니다.


collectionView에서는 다음 메소드를 사용할 수 없어서 2번과정에서 headerView title을 설정했습니다.
```swift
dataSource.titleForHeaderInSection = { dataSource, index in
  return dataSource.sectionModels[index].header
}
```

<br>
 
 ## 4. CustomData의 Observable sequence로 실제 data를 정의한다.

```swift
var sections = [
    SectionOfBoardPost(header: "초등학생", items: [
      BoardPost(), BoardPost(), BoardPost()
      ]),
    SectionOfBoardPost(header: "중학생", items: [
      BoardPost(), BoardPost(), BoardPost()
      ]),
    SectionOfBoardPost(header: "고등학생", items: [
      BoardPost(), BoardPost(), BoardPost()
      ])
  ]
  
  
  Observable.just(viewModel.sections)
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposebag)Observable.just(viewModel.sections)
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposebag)
```




