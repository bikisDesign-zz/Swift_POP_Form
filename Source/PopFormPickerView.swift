//
//  PopFormPickerView.swift
//  InnerPro
//
//  Created by Aaron bikis on 7/20/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol PopFormPickerViewDelegate: class {
  func formPicker(didSelectValue value:String)
}

public class PopFormPickerView: UIPickerView {
  
  private var data: PopFormPickerViewDataSource
  weak var formPickerDelegate: PopFormPickerViewDelegate?
  
  init(data: PopFormPickerViewDataSource) {
    self.data = data
    super.init(frame: CGRect.zero)
    setUpPicker()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  private func setUpPicker() {
    delegate = self
    dataSource = self
    let tgr = UITapGestureRecognizer(target: self, action: #selector(pickerTapped))
    addGestureRecognizer(tgr)
    tgr.delegate = self
    
  }
  
  @objc func pickerTapped(_ sender: UITapGestureRecognizer){
    let rowHeight = self.rowSize(forComponent: 0).height
    let selectedRowFrame = self.bounds.insetBy(dx: 0.0, dy: (self.frame.height - rowHeight) / 2.0)
    let userTappedOnSelectedRow = selectedRowFrame.contains(sender.location(in: self))
    if userTappedOnSelectedRow {
      let value = data.content[selectedRow(inComponent: 0)]
      formPickerDelegate?.formPicker(didSelectValue: value)
    }
  }
}


extension PopFormPickerView: UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return data.content[row]
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return data.content.count
  }
}


extension PopFormPickerView: UIPickerViewDelegate {
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    formPickerDelegate?.formPicker(didSelectValue: data.content[row])
  }
}


extension PopFormPickerView: UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
