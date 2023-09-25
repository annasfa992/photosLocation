//
//  splachVC.swift
//  photosSelection
//
//  Created by Anas on 24/09/2023.
//

import UIKit
import Lottie


class splashVC: UIViewController,Storybordable {

    var coordinator: AppCoordinator?
    private var animationView: LottieAnimationView?
    enum ProgressKeyFrames: CGFloat {
        case start = 140
        case end = 187
        case complete = 240
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI(){

      
        animationView = .init(name: "animationSplash")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        
        view.sendSubviewToBack(animationView!)
        animationView!.play { (finished) in
          //  animationViewNewOrder!.isHidden = true
            print("done")
            self.coordinator?.showMain()
        }

        // Do any additional setup after loading the view.
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
