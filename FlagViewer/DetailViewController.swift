//
//  DetailViewController.swift
//  FlagViewer
//
//  Created by Zeeshan Waheed on 24/01/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var ImageView: UIImageView!
    
    var pictures_hd = [String]()
    var selectedImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let flags = try! fm.contentsOfDirectory(atPath: path)
        
        for flag in flags {
            if flag.hasSuffix(".png") {
                pictures_hd.append(flag)
            }
        }
        
        //        let sorted_pictures = pictures_hd.sorted()
        
        //        var num: Int = 0
        
        func namingFlag() -> String {
            for name in pictures_hd {
                if name == selectedImage {
                    return name
                }
            }
            return ""
        }
        
        title = namingFlag()
        //        navigationItem.largeTitleDisplayMode = .never
        
        
        print("This is hd: ", pictures_hd)
        
        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
//    @objc func shareFlag() {
//        let items: [Any] = ["\(selectedImage!)"]
//        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true)
//    }
    
    @objc func shareFlag() {
        guard let image = ImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
//      this shares two things an image and a name the commented line below only shares an image
        let vc = UIActivityViewController(activityItems: [title ?? "Unknown country", image], applicationActivities: [])
//        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
