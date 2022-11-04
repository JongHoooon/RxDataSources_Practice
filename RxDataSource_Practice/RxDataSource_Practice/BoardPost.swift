//
//  BoardPost.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/04.
//

import Foundation
import Differentiator

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


func makeLabel(
  _ title: String,
  content: String
) -> NSMutableAttributedString {
  let result = NSMutableAttributedString(
    string: title,
    attributes: [ .foregroundColor: UIColor.secondaryLabel, .font: UIFont.systemFont(ofSize: 12.0)]
  )
  result.append(NSAttributedString(string: " "))
  result.append(NSMutableAttributedString(
    string: content,
    attributes: [ .foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 12.0)])
  )
  return result
}
