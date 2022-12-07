//
//  DatabaseModel.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/12/05.
//

import Foundation
import RealmSwift
import UIKit

class user: Object {
    @Persisted var userName: String = ""
    @Persisted var password: String = ""
}


