//
//  ViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit
import Combine

class MuscleListViewController: UIViewController {
	
	//MARK: - UI
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(MuscleCollectionViewCell.self, forCellWithReuseIdentifier: MuscleCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private var muscles: [MuscleGroup] = []

	//MARK: - initiating UI
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setConstraints()
		setDelegates()
		
		startFetch()
		
	}
	
	//MARK: - functions
	
	//fetching muscle list from API
	func startFetch(){
		NetworkManager.shared.getMuscleGroups(complete: {(cum) in
			self.muscles = cum
				self.collectionView.reloadData()
		})
	}
	private func setupViews(){
		title = "Мышцы"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		view.addSubview(collectionView)
		collectionView.delaysContentTouches = false
	}
	
	private func setDelegates(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		
	}
}


//MARK: - Constraints
extension MuscleListViewController{
	private func setConstraints(){
		
		NSLayoutConstraint.activate([
					collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
					collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
					collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
					collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
				])
		
	}
}


//MARK: - Delegate & DataSource
extension MuscleListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			
					width: collectionView.frame.width-20,
					height: self.view.bounds.width/5
				)
		
		
	}
	
	
}



