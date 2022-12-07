//
//  CartViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/11/30.
//

import UIKit
import AVFoundation

var productInCartImg:[UIImage] = []
var productInCartProduct:[String] = []
var productInCartPrice:[String] = []
var productInCartQuantity:[String] = []


class CartViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    
    var audioPlayer:AVAudioPlayer!
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if productInCartPrice.count != 0 {
            var addAmount: Int = 0
            for index in 0..<productInCartPrice.count {
                let productAmount = Int(productInCartPrice[index].prefix(productInCartPrice[index].count - 1))! * Int(productInCartQuantity[index])!
                addAmount += productAmount
            }
            totalAmount.text = String(addAmount) + "円"
        } else {
            totalAmount.text = "0円"
        
        }
        // Do any additional setup after loading the view.
    }
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return productInCartImg.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "CartTable",
                                             for: indexPath)
        
        let img = productInCartImg[indexPath.row]
        
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = img
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = cell.viewWithTag(2) as! UILabel
        label1.text = String(productInCartPrice[indexPath.row])
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let label2 = cell.viewWithTag(3) as! UILabel
        label2.text = String(productInCartProduct[indexPath.row])
        
        // Tag番号　４　で　UI Textfield　インスタンス生成
        let textField = cell.viewWithTag(4) as! UITextField
        textField.text = productInCartQuantity[indexPath.row]
        
        return cell
    }
    // Cell の高さを１２０にする
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purchaseClick(_ sender: Any) {
        if productInCartImg.count == 0 {
            alert(title: "カートが空です",
                          message: "なんか買ってください😁")
        } else {
            productInCartImg = []
            productInCartPrice = []
            productInCartProduct = []
            productInCartQuantity = []
            
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "Thanks") as! purchaseViewController
            ViewController.modalPresentationStyle = .fullScreen
            playSound(name: "buy")
            self.present(ViewController, animated: true, completion: nil)
        }
        

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

extension CartViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer.play()
        } else {
            print("音源ファイルが見つかりません")
            return
        }
    }
}

