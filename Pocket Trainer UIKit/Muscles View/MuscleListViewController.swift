//
//  ViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit
import Combine

class MuscleListViewController: UIViewController {
	
	//MARK: - variables
	private var collectionView: UICollectionView?
	
	private var muscles: [MuscleGroup] = []

	//MARK: - initiating UI
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(named: "Background")
		navigationController?.navigationBar.prefersLargeTitles = true
		createCollectionView()
		startFetch()
		
	}
	
	//MARK: - functions
	
	//fetching muscle list from API
	func startFetch(){
		getMuscleGroups(complete: {(cum) in
			self.muscles = cum
				let layout = UICollectionViewFlowLayout()
				layout.scrollDirection = .vertical
				layout.minimumLineSpacing = 15.0
				layout.itemSize = CGSize(width: self.view.bounds.width-26, height: self.view.bounds.width/5)
				self.collectionView?.setCollectionViewLayout(layout, animated: true)
				self.collectionView?.reloadData()
		})
	}
	
	//creating collection view and its cringe ass properties
	func createCollectionView(){
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 15.0
		layout.itemSize = CGSize(width: view.bounds.width-20, height: view.bounds.width/5)
		
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		guard let collectionView = collectionView else{
			return
		}
		collectionView.register(MuscleCollectionViewCell.self, forCellWithReuseIdentifier: MuscleCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		collectionView.backgroundColor = UIColor(named: "Background")
		
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
		
	}
}


//MARK: - Delegate & DataSource
extension MuscleListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return muscles.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MuscleCollectionViewCell.identifier, for: indexPath) as? MuscleCollectionViewCell{
			cell.muscleData = muscles[indexPath.row]
		return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = ExerciseListViewController()
		vc.muscleGroup = muscles[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
}



