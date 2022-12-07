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
        
//        print(self.view.window?.windowScene!.interfaceOrientation.isPortrait)
        if UIApplication.shared.statusBarOrientation.isPortrait {
            DeviceDisplayShort = view.frame.size.width
            DeviceDisplayLong = view.frame.size.height
            headerView.frame = CGRect(x:0, y:46, width:DeviceDisplayShort, height:77)
        } else {
            DeviceDisplayShort = view.frame.size.height
            DeviceDisplayLong = view.frame.size.width
            headerView.frame = CGRect(x:0, y:0, width:DeviceDisplayLong, height:77)
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
        //画面回転時の処理
        if ((self.view.window?.windowScene!.interfaceOrientation.isPortrait) != nil) {
            headerView.frame = CGRect(x:0, y:46, width:DeviceDisplayShort, height:77)
        } else {
            headerView.frame = CGRect(x:0, y:0, width:DeviceDisplayLong, height:77)
        }
    }
    
    @IBAction func cartTap(_ sender: Any) {
        print("Tap!!!")
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartView") as! CartViewController
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
        productInCartImg += [outputImg]
        productInCartProduct += [outputProduct]
        productInCartPrice += [outputPrice]
        productInCartQuantity += [buyQuantity.text!]
        print(productInCartImg)
        print(productInCartProduct)
        print(productInCartPrice)
        print(productInCartQuantity)
        playSound(name: "insertCart")
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
