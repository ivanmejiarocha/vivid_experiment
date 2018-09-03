//
//  DetailViewController.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var information: UILabel!
    var image: UIImage?
    var card: Card?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let img = image {
            view.layer.contents = img.cgImage
            view.layer.masksToBounds = false
            view.layer.contentsGravity = kCAGravityResizeAspectFill
        }

        if let crd = card {
            information.text = crd.topLabel
        }
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

}
