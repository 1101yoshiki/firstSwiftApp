//
//  purchaseViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/12/01.
//

import UIKit

class purchaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func End(_ sender: Any) {
//        let ViewContoroller = self.storyboard?.instantiateViewController(withIdentifier: "toMain") as! MenuViewController
//        ViewContoroller.modalPresentationStyle = .fullScreen
//        self.present(ViewContoroller, animated: true)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
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
