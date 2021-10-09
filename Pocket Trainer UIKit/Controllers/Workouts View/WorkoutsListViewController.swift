//
//  ProgrammListViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 06.10.2021.
//

import UIKit

class WorkoutsListViewController: UIViewController {
	
	//MARK: - variables
	private var collectionView: UICollectionView?
	
	private var workouts: [Workout] = []
	
	//MARK: - UI Elements
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private lazy var contentView: UIView = {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		return contentView
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
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
		getWorkouts(complete: { (cum) in//(complete: {(cum) in
			self.workouts = cum
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .vertical
			layout.minimumLineSpacing = 15.0
			layout.itemSize = CGSize(width: self.view.bounds.width-26, height: self.view.bounds.width/2.6)
			self.collectionView?.setCollectionViewLayout(layout, animated: true)
			self.collectionView?.reloadData()
		})
	}
	
	//creating collection view and its cringe ass properties
	func createCollectionView(){
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 15.0
		
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		guard let collectionView = collectionView else{
			return
		}
		collectionView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		collectionView.backgroundColor = UIColor(named: "Background")
		
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
		
	}
}


//MARK: - Delegate & DataSource
extension WorkoutsListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return workouts.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCollectionViewCell.identifier, for: indexPath) as? WorkoutCollectionViewCell{
			cell.workoutData = workouts[indexPath.row]
			return cell
		}
		return UICollectionViewCell()
	}
	
	
	
	//show days of workout on tap
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let vc = WorkoutDaysViewController()
		vc.workout = workouts[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
		
	}
}



