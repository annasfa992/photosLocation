

import UIKit

class AppCoordinator: Coordinator {
  
  private let window: UIWindow
    var navigationController: UINavigationController
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController, window: UIWindow) {
       
                self.window = window
            
        self.navigationController = navigationController
    }
    
    func start() {
        window.rootViewController = navigationController
      window.makeKeyAndVisible()
        showSplash()
        
    }
    
    func showSplash() {
        let vc = splashVC.createObject(storyBoard: "Main")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMain() {
        let vc = HomeVC.createObject(storyBoard: "HomeStoryboard")
       
        vc.coordinator = self
        
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(vm:PhotosResponseModel) {
        let vc = HomeDetailsVC.createObject(storyBoard: "HomeStoryboard")
        var viewModel = DetailViewModel()
        viewModel.model = vm
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
