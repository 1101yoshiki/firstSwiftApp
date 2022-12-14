//
//  ViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/11/28.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    var DeviceDisplayShort: CGFloat = 0.0
    var DeviceDisplayLong: CGFloat = 0.0
    
    @IBOutlet weak var cartIcon: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var table: UITableView!
    var selectedImg:UIImage?
    var selectedProduct: String?
    var selectedPrice: String?
    
    
    // section毎の画像配列
    let imgArray: [String] = [
        "img0","img1",
        "img2","img3",
        "img4","img5",
        "img6","img7",
        "img8","img9",
        "img10"]
    
    let label2Array: [String] = [
        "スコーン　やみつきバーベキュー","カラムーチョ",
        "ポテトチップス　のり塩","ポリンキー　あっさりコーン",
        "ドンタコス　チリトマト","じゃがいも心地",
        "プライドポテト　凛凛レモン","プライドポテト　神のり塩",
        "ポテトチップス　ガーリック","ポテトチップス　うすしお",
        "ポテトチップス　のり醤油"]
    
    
    let priceArray: [Int] = [
        84,162,
        93,84,
        84,101,
        110,110,
        93,93,
        93]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if view.frame.size.width < view.frame.size.height {
            headerView.frame = CGRect(x:0, y:46, width:view.frame.size.width, height:77)
            cartIcon.frame = CGRect(x:326, y:11, width:59, height:54)
            table.frame = CGRect(x:0, y:118, width:393, height:view.frame.size.height - 77)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height:77)
            cartIcon.frame = CGRect(x:750, y:11, width:59, height:54)
            table.frame = CGRect(x:0, y:77, width:view.frame.size.width, height:view.frame.size.height - 77)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 回転開始時に行う処理
        if size.width < size.height {
            headerView.frame = CGRect(x:0, y:46, width:size.width, height:77)
            cartIcon.frame = CGRect(x:326, y:11, width:59, height:54)
            table.frame = CGRect(x:0, y:118, width:393, height:size.height - 77)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:size.width, height:77)
            cartIcon.frame = CGRect(x:750, y:11, width:59, height:54)
            table.frame = CGRect(x:0, y:77, width:size.width, height:view.frame.size.height - 77)
        }
    }
    
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "tableCell",
                                             for: indexPath)
        
        let img = UIImage(named: imgArray[indexPath.row])
        
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = img
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = cell.viewWithTag(2) as! UILabel
        label1.text = String(priceArray[indexPath.row]) + "円"
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let label2 = cell.viewWithTag(3) as! UILabel
        label2.text = String(label2Array[indexPath.row])
        
        return cell
    }
    // Cell の高さを１２０にする
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
                ViewController.modalPresentationStyle = .fullScreen
        
        selectedImg = UIImage(named: imgArray[indexPath.row])
        selectedProduct = String(describing: label2Array[indexPath.row])
        selectedPrice = String(describing: priceArray[indexPath.row]) + "円"
        
        ViewController.outputImg = selectedImg
        ViewController.outputProduct = selectedProduct
        ViewController.outputPrice = selectedPrice
        
        if selectedImg != nil {
            self.present(ViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cartTap(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartView") as! CartViewController
        ViewController.modalPresentationStyle = .fullScreen
        self.present(ViewController, animated: true, completion: nil)
        print("Tap!!!")
        print(productInCartImg)
    }
    
  
}
