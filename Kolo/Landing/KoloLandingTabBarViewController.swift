//
//  KoloLandingTabBarViewController.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import UIKit

class KoloLandingTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        setUpControllers()
    }
    

    func setUpControllers() {
        let controller1 = CharactersViewController()
        controller1.title = AAConstants.characters
        controller1.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        controller1.tabBarItem.image = UIImage(systemName: "person")
        let characterController = UINavigationController(rootViewController: controller1)

        let controller2 = ComicsViewController()
        controller2.title = AAConstants.comics
        controller2.tabBarItem.selectedImage = UIImage(systemName: "book.fill")
        controller2.tabBarItem.image = UIImage(systemName: "book")
        let comicController = UINavigationController(rootViewController: controller2)

        self.viewControllers = [characterController, comicController]
        self.selectedIndex = 0
    }

}
