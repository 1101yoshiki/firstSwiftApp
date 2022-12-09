//
//  MenuViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/11/29.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var addUserButton: UIButton!
    
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        
        if view.frame.size.width < view.frame.size.height {
            headerView.frame = CGRect(x:0, y:46, width:view.frame.size.width, height:77)
            username.frame = CGRect(x:95,y:240, width:203, height: 34)
            password.frame = CGRect(x:95,y:300, width:203, height: 34)
            button.frame = CGRect(x:123,y:388, width:134, height: 35)
            addUserButton.frame = CGRect(x:291, y:21, width:94, height:35)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height:77)
            username.frame = CGRect(x:325,y:100, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
            addUserButton.frame = CGRect(x:750, y:21, width:94, height:35)
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
            addUserButton.frame = CGRect(x:291, y:21, width:94, height:35)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:size.width, height:77)
            username.frame = CGRect(x:325,y:100, width:203, height: 34)
            password.frame = CGRect(x:325,y:175, width:203, height: 34)
            button.frame = CGRect(x:353,y:225, width:134, height: 35)
            addUserButton.frame = CGRect(x:750, y:21, width:94, height:35)
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
                alert(title: "ログイン失敗！", message: "パスワードが違うか\nユーザーが存在しません")
            }
           
            print(result)
        } else {
            alert(title: "ログイン失敗！", message: "パスワードが違うか\nユーザーが存在しません")
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
    

    @IBAction func addUserLink(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddUserView") as! AddUserViewController
        ViewController.modalPresentationStyle = .fullScreen
        self.present(ViewController, animated: true, completion: nil)
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
