//
//  QRCodeGenerateViewController.swift
//  QRGenerator
//
//  Created by buginux on 2018/1/18.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit
import MBProgressHUD

class QRCodeGenerateViewController: UIViewController {
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var countDownLabel: QRCountDownLabel!
    
    var qrCodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QRCode"
        
        countDownLabel.delegate = self
        generateQRCodeImage()
    }
    
    private func generateQRCodeImage() {
        countDownLabel.isHidden = true
        
        let hud = showLoading()
        QRSeedService.fetchQRSeed { [unowned self] seed in
            hud.hide(animated: true)
            
            guard let seed = seed else { return }
            
            let data = seed.seed.data(using: String.Encoding.utf8)
            let filter = CIFilter(name: "CIQRCodeGenerator")!
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            
            self.qrCodeImage = filter.outputImage
            self.displayQRCodeImage()
            self.countDownLabel.startCountDown(withExpiresAt: seed.expiresAt)
            self.countDownLabel.isHidden = false
        }
    }
    
    private func showLoading(withText text: String = "Loading") -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = text
        
        return hud
    }
    
    private func displayQRCodeImage() {
        let scaleX = qrCodeImageView.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = qrCodeImageView.frame.size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        qrCodeImageView.image = UIImage(ciImage: transformedImage)
    }
}

extension QRCodeGenerateViewController: QRCountDownLabelDelegate {
    func countDownLabelDidExpired() {
        generateQRCodeImage()
    }
}
