//
//  ViewController.swift
//  RxDataSource_Practice
//
//  Created by JongHoon on 2022/11/04.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ViewController: UIViewController {
  
  // MARK: - Property
  
  let disposebag = DisposeBag()
  let viewModel = ViewModel()
  
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
    
  
  @IBOutlet weak var collectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.backgroundColor = .systemGray6
    self.collectionView.register(
      BoardCell.self,
      forCellWithReuseIdentifier: "Cell"
    )
    self.collectionView.register(
      BoardHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: "Header"
    )
    
    self.bind()
    
  }
  
  func bind() {
    Observable.just(viewModel.sections)
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposebag)
    
    collectionView.rx.itemSelected
      .subscribe(onNext: {
        print("\($0)")
      })
      .disposed(by: disposebag)
  
    self.collectionView.rx.setDelegate(self).disposed(by: disposebag)
    
  }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
      return CGSize(width: view.frame.width - 8, height: 160)
    }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: 40)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(
      top: 4.0, left: 0,
      bottom: 4.0, right: 0
    )
  }
}
