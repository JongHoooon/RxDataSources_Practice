//
//  BoardCell.swift
//  10-2-home
//
//  Created by JongHoon on 2022/10/15.
//

import Then
import SnapKit
import UIKit

final class BoardCell: UICollectionViewCell {
  
  
  private lazy var categoryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    $0.textColor = .systemGreen
  }
  
  private lazy var titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  private lazy var purposeLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private lazy var memberLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  lazy var chiefLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  lazy var startDayLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  lazy var totalTimeLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private lazy var contentLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14.0, weight: .regular)
    $0.textColor = .label
    $0.numberOfLines = 2
  }
  
  
  private lazy var separatorView = UIView().then {
    $0.backgroundColor = .quaternaryLabel
  }
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(with boardpost: BoardPost) {
    self.categoryLabel.text = boardpost.category
    self.titleLabel.text = boardpost.title
    self.purposeLabel.attributedText = boardpost.member
    self.chiefLabel.attributedText = boardpost.chief
    self.startDayLabel.attributedText = boardpost.start
    self.totalTimeLabel.attributedText = boardpost.totalTime
    self.contentLabel.text = boardpost.content
  }
}

// MARK: - Private

private extension BoardCell {
  
  func configureLayout() {
    
    let firstLineStackView = UIStackView(arrangedSubviews: [
      purposeLabel,
      memberLabel,
      chiefLabel
    ]).then {
      $0.axis = .horizontal
      $0.distribution = .equalSpacing
      $0.spacing = 8.0
    }
    
    let secondLineStackView = UIStackView(arrangedSubviews: [
      startDayLabel,
      totalTimeLabel
    ]).then {
      $0.axis = .horizontal
      $0.distribution = .equalSpacing
      $0.spacing = 8.0
    }
    
    [
      categoryLabel,
      titleLabel,
      firstLineStackView,
      secondLineStackView,
      separatorView,
      contentLabel
    ].forEach { addSubview($0) }
    
    categoryLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16.0)
      $0.top.equalToSuperview().inset(16.0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(categoryLabel.snp.bottom).offset(8.0)
    }
    
    firstLineStackView.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
    }
    
    secondLineStackView.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(firstLineStackView.snp.bottom)
    }
    separatorView.snp.makeConstraints {
      $0.top.equalTo(secondLineStackView.snp.bottom).offset(8.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.height.equalTo(0.5)
    }
    
    contentLabel.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(separatorView.snp.bottom).offset(8.0)
    }
   
    backgroundColor = .systemBackground
    self.layer.cornerRadius = 8.0
    self.clipsToBounds = true
  }
}
