//
//  NextViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func dimissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showPhotoAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    deinit {
//        print("destroy NextVC")
//    }

}

extension NextViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let image:UIImage? = info["UIImagePickerControllerOriginalImage"] as? UIImage
        if image != nil {
            self.imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

