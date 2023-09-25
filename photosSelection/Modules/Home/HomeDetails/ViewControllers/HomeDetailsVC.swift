//
//  HomeDetailsVC.swift
//  photosSelection
//
//  Created by Anas on 25/09/2023.
//

import UIKit
import SDWebImage
class HomeDetailsVC: UIViewController ,Storybordable{
    var coordinator: AppCoordinator?
    var viewModel: DetailViewModel?
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImage()
        // Do any additional setup after loading the view.
    }
    func setupView(){
        let url = URL(string:viewModel?.model?.urls?.full ?? "")
        coverPhoto.sd_setImage(with: url)
        descriptionLbl.text = viewModel?.model?.description ?? viewModel?.model?.alt_description
    }
    func setupImage(){
        
        coverPhoto.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector (self.pinchGesture))
        coverPhoto.addGestureRecognizer(pinchGesture)
        }
  
    @objc func pinchGesture(sender:UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
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


