//
//  ExercisesViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit

class ExerciseListViewController: UIViewController {

	//MARK: - Variables and stuff
	
	
	
	private var exercisesArray = [Exercise]()
	var muscleGroup: MuscleGroup!
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: "ExerciseCell")
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	//MARK: - initiating design
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupViews()
		setConstraints()
		setDelegates()
		
		startFetch()
		
	}
	
	//MARK: - functions
	
	
	//fetching Exercises from API
	private func startFetch(){
		getExercises(complete: {(cum) in
			self.exercisesArray = cum.filter({ exercise in
				exercise.MuscleGroups.contains { muscle in
					muscle.MuscleGroupID == self.muscleGroup.MuscleGroupID
				}
			})
				self.collectionView.reloadData()
			
			
		})
	}
	
	private func setupViews(){
		title = "Упражнения: \(muscleGroup.Name!)"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		view.addSubview(collectionView)
	}
	
	
	private func setDelegates(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		
	}
    
	


}

//MARK: - Constraints
extension ExerciseListViewController{
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
extension ExerciseListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

	
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			
					width: collectionView.frame.width-20,
					height: self.view.bounds.width/5
				)
		
		
	}
	
	
}

