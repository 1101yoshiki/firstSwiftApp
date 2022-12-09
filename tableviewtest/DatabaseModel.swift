//
//  DatabaseModel.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/12/05.
//

import Foundation
import RealmSwift

class user: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var password: String = ""
}


