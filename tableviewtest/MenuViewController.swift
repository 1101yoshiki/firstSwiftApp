//
//  MenuViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/11/29.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    var DeviceDisplayShort: CGFloat = 0.0
    var DeviceDisplayLong: CGFloat = 0.0

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.isSecureTextEntry = true
        print(self.view.window?.windowScene!.interfaceOrientation)
        print(UIDevice.current.orientation.isPortrait)
        
        print(UIApplication.shared.statusBarOrientation.isPortrait)
        if UIApplication.shared.statusBarOrientation.isPortrait {
            DeviceDisplayShort = view.frame.size.width
            DeviceDisplayLong = view.frame.size.height
            headerView.frame = CGRect(x:0, y:46, width:DeviceDisplayShort, height:77)
            username.frame = CGRect(x:95,y:240, width:203, height: 34)
            password.frame = CGRect(x:95,y:300, width:203, height: 34)
            button.frame = CGRect(x:123,y:388, width:134, height: 35)
        } else {
            DeviceDisplayShort = view.frame.size.height
            DeviceDisplayLong = view.frame.size.width
            headerView.frame = CGRect(x:0, y:0, width:DeviceDisplayLong, height:77)
            username.frame = CGRect(x:325,y:100, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                                   selector:#selector(didChangeOrientation(_:)),
                                                   name: UIDevice.orientationDidChangeNotification,
                                                   object: nil)
    }
    
    @objc private func didChangeOrientation(_ notification: Notification) {
        print(self.view.window?.windowScene!.interfaceOrientation.isPortrait)
        print(UIDevice.current.orientation.isPortrait)
        //画面回転時の処理
//        if (self.view.window?.windowScene!.interfaceOrientation.isPortrait) != nil {
//            print("状態わからん")
//        } else
            if UIApplication.shared.statusBarOrientation.isPortrait {
            headerView.frame = CGRect(x:0, y:46, width:DeviceDisplayShort, height:77)
            username.frame = CGRect(x:95,y:240, width:203, height: 34)
            password.frame = CGRect(x:95,y:300, width:203, height: 34)
            button.frame = CGRect(x:123,y:388, width:134, height: 35)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:DeviceDisplayLong, height:77)
            username.frame = CGRect(x:325,y:125, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
        }
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as! ViewController
        ViewController.modalPresentationStyle = .fullScreen
        
        let textFieldUserName: String = username.text!
        let textFieldPassword: String = password.text!
        
        let realm = try! Realm()
        
        let userTable = realm.objects(user.self)
        
        if let result = userTable.where({$0.userName == textFieldUserName}).first {
            if (result.userName == textFieldUserName && result.password == textFieldPassword){
                self.present(ViewController, animated: true, completion: nil)
                username.text = ""
                password.text = ""
            } else {
                alert(title: "ログイン失敗！", message: "パスワードが違うかユーザーが存在しません")
            }
           
            print(result)
        } else {
            alert(title: "ログイン失敗！", message: "パスワードが違うかユーザーが存在しません")
        }
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
    
    @IBAction func dbCheck(_ sender: Any) {
        let realm = try! Realm()
        
       

//        try! realm.write{
//            realm.deleteAll()
//        }
        
        
        let result = realm.objects(user.self)
        print(result)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
