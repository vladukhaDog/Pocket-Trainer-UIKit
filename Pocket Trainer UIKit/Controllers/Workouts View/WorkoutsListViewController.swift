//
//  ProgrammListViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 06.10.2021.
//

import UIKit

class WorkoutsListViewController: UIViewController {
	
	//MARK: - data n'shit
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private var workouts: [Workout] = []
	

	
	//MARK: - initiating UI
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setConstraints()
		setDelegates()
		
		startFetch()
		
		
		
	}
	
	//MARK: - functions
	private func setupViews(){
		title = "Программы"
		navigationController?.navigationBar.prefersLargeTitles = true
		view.addSubview(collectionView)
	}
	
	
	//fetching muscle list from API
	private func startFetch(){
		getWorkouts(complete: { (cum) in//(complete: {(cum) in
			self.workouts = cum
			self.collectionView.reloadData()
		})
	}
	
	private func setDelegates(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		
	}

}

//MARK: - Constraints
extension WorkoutsListViewController{
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
extension WorkoutsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			
					width: collectionView.frame.width-20,
					height: self.view.bounds.width/3.5
				)
		
		
	}
}



