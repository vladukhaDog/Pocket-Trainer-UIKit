//
//  ExercisesViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit

class ExerciseListViewController: UIViewController {

	//MARK: - Variables and stuff
	private var collectionView: UICollectionView?
	private var exercisesArray = [Exercise]()
	var muscleGroup: MuscleGroup!
	
	//MARK: - initiating design
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Упражнения: \(muscleGroup.Name!)"
		
		navigationController?.navigationBar.prefersLargeTitles = true
		createCollectionView()
		startFetch()
		
	}
	
	//MARK: - functions
	
	//fetching Exercises from API
	func startFetch(){
		getExercises(complete: {(cum) in
			self.exercisesArray = cum.filter({ exercise in
				exercise.MuscleGroups.contains { muscle in
					muscle.MuscleGroupID == self.muscleGroup.MuscleGroupID
				}
			})
				let layout = UICollectionViewFlowLayout()
				layout.scrollDirection = .vertical
				layout.minimumLineSpacing = 15.0
				layout.itemSize = CGSize(width: self.view.bounds.width-26, height: self.view.bounds.width/5)
				self.collectionView?.setCollectionViewLayout(layout, animated: true)
				self.collectionView?.reloadData()
			
			
		})
	}
	
	//creating all the collectionView properties
	//this shitass cringe could've bee 20 times faster and more beautiful in SwiftUI
	func createCollectionView(){
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 15.0
		layout.itemSize = CGSize(width: view.bounds.width-26, height: view.bounds.width/5)
		
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		guard let collectionView = collectionView else{
			return
		}
		//why the fuck is this a thing i hate UIKit
		collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		collectionView.backgroundColor = UIColor(named: "Background")
		
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
		
	}
    
	


}

//MARK: - Delegate & DataSource
extension ExerciseListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
	
	/*
	 why does this have to be so big and unreadable when we have SwiftUI
	 being able to configure every property is a pro
	 needing to configure every property is a con
	 UIKit after 2020 is just cringe
	 */
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return exercisesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as? ExerciseCollectionViewCell{
			cell.exerciseData = exercisesArray[indexPath.row]
		return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = ExerciseDetailViewController()
		vc.exercise = exercisesArray[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
}

