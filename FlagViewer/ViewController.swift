//
//  ViewController.swift
//  FlagViewer
//
//  Created by Zeeshan Waheed on 24/01/2024.
//

import UIKit

class ViewController: UITableViewController {

    var pictures_hd = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let flags = try! fm.contentsOfDirectory(atPath: path)
        
        for flag in flags {
            if flag.hasSuffix(".png") {
                pictures_hd.append(flag)
            }
        }
        
//        for flag in flags {
//            if flag.hasPrefix("flag_sd") {
//                pictures_sd.append(flag)
//            }
//        }
        
        pictures_hd.sort()
//        pictures_sd.sort()
//        
        print("This is hd: ", pictures_hd)
//        print()
//        print("This is sd: ", pictures_sd)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures_hd.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1).  " + pictures_hd[indexPath.row].replacingOccurrences(of: ".png", with: "")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier:"Detail") as? DetailViewController {
            let sortedPictures = pictures_hd.sorted()
            vc.selectedImage = sortedPictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

