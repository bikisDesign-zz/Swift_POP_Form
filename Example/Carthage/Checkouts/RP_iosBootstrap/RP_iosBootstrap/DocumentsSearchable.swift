//
//  DocumentsSearchable.swift
//  RP_iosBootstrap
//
//  Created by Aaron bikis on 6/30/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import Foundation
public protocol DocumentsSearchable {
  func getDocumentsDirectory() -> URL
}

extension DocumentsSearchable {
  public func getDocumentsDirectory() -> URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
}
