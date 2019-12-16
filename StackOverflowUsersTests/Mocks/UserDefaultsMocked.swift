//
//  UserDefaultsMocked.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

class UserDefaultsMocked : UserDefaults {

  convenience init() {
    self.init(suiteName: "Mock User Defaults")!
  }

  override init?(suiteName suitename: String?) {
    UserDefaults().removePersistentDomain(forName: suitename!)
    super.init(suiteName: suitename)
  }

}
