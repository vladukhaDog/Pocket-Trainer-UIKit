//
//  TabBarHomeViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 10.10.2021.
//

import UIKit

class TabBarHomeViewController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.delegate = self
		
		
	}
	
	
	//MARK: - setting up ViewControllers in Tabs
	func setupVCs() {
		   viewControllers = [
			   createNavController(for: MuscleListViewController(), title: NSLocalizedString("Упражнения", comment: ""), image: UIImage(systemName: "list.dash")!),
			   createNavController(for: WorkoutsListViewController(), title: NSLocalizedString("Программы", comment: ""), image: UIImage(systemName: "chart.bar.doc.horizontal")!)
		   ]
		
	}
	
	
	fileprivate func createNavController(for rootViewController: UIViewController,
										 title: String,
										 image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		view.backgroundColor = UIColor(named: "BackgroundTabBar")
		UITabBar.appearance().barTintColor = UIColor(named: "BackgroundTabBar")
		UITabBar.appearance().backgroundColor = UIColor(named: "BackgroundTabBar")
		tabBar.tintColor = .label
		UITabBar.appearance().isTranslucent = false
		setupVCs()
		
	}
	
	// UITabBarControllerDelegate method
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		//print("Selected \(viewController.title!)")
	}
}
