//
//  QRCodeGenerateViewController.swift
//  QRGenerator
//
//  Created by buginux on 2018/1/18.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit
import JGProgressHUD

class QRCodeGenerateViewController: UIViewController {
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    var qrCodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateQRCodeImage()
    }
    
    private func generateQRCodeImage() {
        let spinner = JGProgressHUD(style: .dark)!
        spinner.textLabel.text = "Loading"
        spinner.show(in: view)
        
        QRSeedService.fetchQRSeed { [unowned self] seed in
            spinner.dismiss()
            
            guard let seed = seed else { return }
            
            let data = seed.seed.data(using: String.Encoding.utf8)
            let filter = CIFilter(name: "CIQRCodeGenerator")!
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            
            self.qrCodeImage = filter.outputImage
            self.displayQRCodeImage()
        }
    }
    
    private func displayQRCodeImage() {
        let scaleX = qrCodeImageView.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = qrCodeImageView.frame.size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        qrCodeImageView.image = UIImage(ciImage: transformedImage)
    }
}
