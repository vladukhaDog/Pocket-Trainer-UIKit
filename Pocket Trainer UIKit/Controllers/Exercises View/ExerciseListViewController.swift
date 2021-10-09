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
		layout.minimumLineSpacing = 5
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	//MARK: - initiating design
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupViews()
		setDelegates()
		setConstraints()
		startFetch()
		
	}
	
	//MARK: - functions
	
	private func setConstraints(){
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
	}
	
	
	//fetching Exercises from API
	private func startFetch(){
		getExercises(complete: {(cum) in
			self.exercisesArray = cum.filter({ exercise in
				exercise.MuscleGroups.contains { muscle in
					muscle.MuscleGroupID == self.muscleGroup.MuscleGroupID
				}
			})
				//let layout = UICollectionViewFlowLayout()
				//layout.scrollDirection = .vertical
				//layout.minimumLineSpacing = 15.0
				//layout.itemSize = CGSize(width: self.view.bounds.width-26, height: self.view.bounds.width/5)
				//self.collectionView?.setCollectionViewLayout(layout, animated: true)
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

//MARK: - Delegate & DataSource
extension ExerciseListViewController: UICollectionViewDelegate, UICollectionViewDataSource{

	
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
		CGSize(width: collectionView.frame.width, height: 100)
		
		
	}
	
	
}

