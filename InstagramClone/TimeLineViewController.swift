//
//  TimeLineViewController.swift
//  InstagramClone
//
//  Created by Евгений Лянкэ on 03.05.2022.
//

import UIKit
import Firebase
class TimeLineViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        tabBar.backgroundColor = UIColor(white: 0, alpha: 0.09)
        tabBar.tintColor = .black
//        configureLogOUT()
       
        let feed  = createNavControllers(viewController:UIViewController(), title:"Feed", image: UIImage(named: "home_unselected")!)
        let search  = createNavControllers(viewController: UIViewController(), title:"Search" , image: UIImage(named: "search_selected")!)
        let newPost  = createNavControllers(viewController: UIViewController(), title:"Post" , image: UIImage(named: "plus.app")!)
        let likes  = createNavControllers(viewController: UIViewController(), title:"Likes" , image: UIImage(named: "like_unselected")!)
        let profile  = createNavControllers(viewController: UIViewController(), title:"Profile" , image: UIImage(named: "profile_unselected")!)
        viewControllers = [feed,search,newPost,likes,profile]
       
    }
    
   
    
    func createNavControllers(viewController:UIViewController,title:String,image:UIImage)->UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        
        navController.tabBarItem.image = image
        return navController
    }
//    func configureLogOUT(){
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LOG out", style: .plain, target: self, action:#selector(logout))
//    }
//    @objc func logout(){
//
//        let alert = UIAlertController(title: "Do you want to log out?", message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
//            do {
//                try Auth.auth().signOut()
//
//                self.navigationController?.popViewController(animated: true)
//
//
//            }catch {
//                print("Failed to sigh out")
//            }
//
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }

}
