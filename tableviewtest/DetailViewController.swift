//
//  DetailViewController.swift
//  tableviewtest
//
//  Created by yoshiki koike on 2022/11/29.
//

import UIKit
import AVFoundation


class DetailViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var outputImg: UIImage!
    var outputProduct: String!
    var outputPrice: String!
    
    var DeviceDisplayShort: CGFloat = 0.0
    var DeviceDisplayLong: CGFloat = 0.0
    
    @IBOutlet weak var buyQuantity: UITextField!
    
 
    @IBOutlet weak var DetailContainer: UIView!
    @IBOutlet weak var cartIcon: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var Product: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var DetailImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailImg.image = outputImg
        Product.text = outputProduct
        Price.text = outputPrice
        
        if view.frame.size.width < view.frame.size.height {
            headerView.frame = CGRect(x:0, y:46, width:view.frame.size.width, height:77)
            cartIcon.frame = CGRect(x:326, y:11, width:59, height:54)
            DetailImg.frame = CGRect(x:0, y:121, width:view.frame.size.width, height:334 * (view.frame.size.width / 393))
            DetailContainer.frame = CGRect(x:0, y:121 + 334 * (view.frame.size.width / 393) + 10, width:view.frame.size.width, height:344)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height:77)
            cartIcon.frame = CGRect(x:750, y:11, width:59, height:54)
            DetailImg.frame = CGRect(x:20, y:87, width:view.frame.size.height * 0.8, height:(view.frame.size.height * 0.8) * (334 / 393))
            DetailContainer.frame = CGRect(x:view.frame.size.width / 2, y:77, width:view.frame.size.height * 0.8, height:view.frame.size.height * 0.8)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 回転開始時に行う処理
        if size.width < size.height {
            headerView.frame = CGRect(x:0, y:46, width:size.width, height:77)
            cartIcon.frame = CGRect(x:326, y:11, width:59, height:54)
            DetailImg.frame = CGRect(x:0, y:121, width:size.width, height:334 * (size.width / 393))
            DetailContainer.frame = CGRect(x:0, y:121 + 334 * (size.width / 393) + 10, width:size.width, height:344)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:size.width, height:77)
            cartIcon.frame = CGRect(x:750, y:11, width:59, height:54)
            DetailImg.frame = CGRect(x:20, y:87, width:size.height * 0.8, height:(size.height * 0.8) * (334 / 393))
            DetailContainer.frame = CGRect(x:size.width / 2, y:87, width:size.height * 0.8, height:size.height * 0.75)
        }
    }
        
    @IBAction func cartTap(_ sender: Any) {
        print("Tap!!!")
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartView") as! CartViewController
        ViewController.modalPresentationStyle = .fullScreen
        self.present(ViewController, animated: true, completion: nil)
    }
    
    @IBAction func returnMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func count(_ sender: Any) {
        let counter: Double = stepper.value
        buyQuantity.text! = String(Int(counter))
    }
    
    @IBAction func insertCart(_ sender: Any) {
        if let index = productInCartProduct.firstIndex(of: outputProduct) {
            productInCartQuantity[index] = String(Int(productInCartQuantity[index])! + Int(buyQuantity.text!)!)
            playSound(name: "insertCart")
        } else {
            productInCartImg += [outputImg]
            productInCartProduct += [outputProduct]
            productInCartPrice += [outputPrice]
            productInCartQuantity += [buyQuantity.text!]
            playSound(name: "insertCart")
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

extension DetailViewController: AVAudioPlayerDelegate {
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
