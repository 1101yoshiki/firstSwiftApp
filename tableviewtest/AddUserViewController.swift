//
//  AddUserViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/12/08.
//

import UIKit
import RealmSwift


class AddUserViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if view.frame.size.width < view.frame.size.height {
            headerView.frame = CGRect(x:0, y:46, width:view.frame.size.width, height:77)
            username.frame = CGRect(x:95,y:240, width:203, height: 34)
            password.frame = CGRect(x:95,y:300, width:203, height: 34)
            button.frame = CGRect(x:123,y:388, width:134, height: 35)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height:77)
            username.frame = CGRect(x:325,y:100, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 回転開始時に行う処理
        if size.width < size.height {
            headerView.frame = CGRect(x:0, y:46, width:size.width, height:77)
            username.frame = CGRect(x:95,y:240, width:203, height: 34)
            password.frame = CGRect(x:95,y:300, width:203, height: 34)
            button.frame = CGRect(x:123,y:388, width:134, height: 35)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:size.width, height:77)
            username.frame = CGRect(x:325,y:100, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addUser(_ sender: Any) {
        let userData = user()
        let realm = try! Realm()
        
        guard let wrappedName = username.text else { return }
        guard let wrappedPass = password.text else { return }
        if wrappedName != "" && wrappedPass != "" {
            if let result = realm.objects(user.self).where({$0.userName == wrappedName}).first {
                alert(title: "新規登録失敗", message: "ユーザーがすでに存在しています")
            } else {
                userData.userName = wrappedName
                userData.password = wrappedPass
                let realm = try! Realm()
                try! realm.write{
                    realm.add(userData)
                }
                alert(title: "新規登録完了！", message: "小池屋でたくさん買い物してね💰")
                
            }
            
        } else {
            alert(title: "新規登録失敗", message: "何も入力されてないっす！")
        }
    }
    
    func addUser(){
        let userData = user()
        let realm = try! Realm()

        userData.userName = "koikeyoshiki"
        userData.password = "0000"
        try! realm.write{
            realm.add(userData)
        }
    }
}






