//
//  ViewModel.swift
//  RxDataSource_Practice
//
//  Created by JongHoon on 2022/11/04.
//

import UIKit
import Differentiator

// Differentiator 사용
// typealias SectionOfBoardPost = SectionModel<String, BoardPost>

final class ViewModel {
  
  
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

// Differentiator 사용
//  var sections = [
//    SectionOfBoardPost(model: "초등학생", items: [
//      BoardPost(), BoardPost(), BoardPost()
//    ])
//  ]
}
