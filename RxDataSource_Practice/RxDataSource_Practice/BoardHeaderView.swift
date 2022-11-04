//
//  BoardHeaderView.swift
//  RxDataSource_Practice
//
//  Created by JongHoon on 2022/11/04.
//

import UIKit
import SnapKit

final class BoardHeaderView: UICollectionReusableView {
  
  // MARK: - Property
  
  private lazy var titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16.0, weight: .bold)
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    backgroundColor = .systemGreen
    addSubview(titleLabel)
      
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16.0)
      $0.centerY.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureHeader(with title: String) {
    self.titleLabel.text = title
  }
}
