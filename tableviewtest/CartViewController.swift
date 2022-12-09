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
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var amountContainer: UIView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    var audioPlayer:AVAudioPlayer!
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    func amountCalculation () {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountCalculation()
        
        if view.frame.size.width < view.frame.size.height {
            headerView.frame = CGRect(x:0, y:46, width:view.frame.size.width, height:77)
            table.frame = CGRect(x:0, y:132, width:view.frame.size.width, height:view.frame.size.height - 400)
            amountContainer.frame = CGRect(x:137, y:view.frame.size.height - 230, width:240, height:40)
            purchaseButton.frame = CGRect(x:70, y:view.frame.size.height - 190, width:253, height:40)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height:77)
            
            table.frame = CGRect(x:0, y:77, width:view.frame.size.width, height:view.frame.size.height - 150)
            amountContainer.frame = CGRect(x:0, y:view.frame.size.height - 70, width:240, height:40)
            purchaseButton.frame = CGRect(x:260, y:view.frame.size.height - 70, width:253, height:40)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 回転開始時に行う処理
        print(size)
        if size.width < size.height {
            headerView.frame = CGRect(x:0, y:46, width:size.width, height:77)
            table.frame = CGRect(x:0, y:132, width:size.width, height:size.height - 400)
            amountContainer.frame = CGRect(x:137, y:size.height - 230, width:240, height:40)
            purchaseButton.frame = CGRect(x:70, y:size.height - 190, width:253, height:40)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:size.width, height:77)
            table.frame = CGRect(x:0, y:77, width:size.width, height:size.height - 150)
            amountContainer.frame = CGRect(x:0, y:size.height - 70, width:240, height:40)
            purchaseButton.frame = CGRect(x:260, y:size.height - 70, width:253, height:40)
        }
    }
    
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
//        print(productInCartImg.count)
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
        
        let stepper = cell.viewWithTag(5) as! UIStepper
//        print(stepper.tag)
        print(indexPath.row)
        stepper.addTarget(self, action: #selector(changeQuantity(_:)), for: .valueChanged)
        stepper.accessibilityIdentifier = String(indexPath.row) //タグを設定
        stepper.value = Double(textField.text!)!
        
        return cell
    }
    // Cell の高さを１２０にする
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates {
            productInCartImg.remove(at: indexPath.row)
            productInCartProduct.remove(at: indexPath.row)
            productInCartPrice.remove(at: indexPath.row)
            productInCartQuantity.remove(at: indexPath.row)
            //                remindersRepository.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            amountCalculation()
        } completion: { _ in
            tableView.reloadData()
        }
    }

    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeQuantity(_ sender: UIStepper) {
        let identifer = Int(sender.accessibilityIdentifier!)
        let indexPath = IndexPath(row: identifer!, section: 0)
        print("indexPath",indexPath.row)
        //indexPathでセルを指定可能
        let cell = self.table.cellForRow(at: indexPath)

        // 作成したセルのタグ(4)のviewから値を取り出す
        let textField = cell?.viewWithTag(4) as! UITextField

        
        print("stepperValue= ", sender.value)
        print(textField.text!) //Cell内のcountの値取得
        textField.text = String(Int(sender.value))
        productInCartQuantity[indexPath.row] = String(Int(sender.value))
        amountCalculation()
        print("click")
        
//        let counter: Double = Stepper.value
//        quantityField.text! = String(Int(counter))
    }
    
    @IBAction func purchaseClick(_ sender: Any) {
        let addQuantity =  productInCartQuantity.reduce(0, { (result,quantity) -> Int in
            result + Int(quantity)!
        })
        if productInCartImg.count == 0 || addQuantity == 0{
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

