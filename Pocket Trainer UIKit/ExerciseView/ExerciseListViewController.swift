//
//  ExercisesViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit

class ExerciseListViewController: UIViewController {

	private var collectionView: UICollectionView?
	private var exercisesArray = [Exercise]()
	var muscleGroup: MuscleGroup!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Упражнения: \(muscleGroup.Name!)"
		view.backgroundColor = UIColor(named: "Background")
		navigationController?.navigationBar.prefersLargeTitles = true
		createCollectionView()
		startFetch()
		
	}
	
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
				layout.itemSize = CGSize(width: self.view.bounds.width-12, height: self.view.bounds.width/5)
				self.collectionView?.setCollectionViewLayout(layout, animated: true)
				self.collectionView?.reloadData()
			
			
		})
	}
	
	func createCollectionView(){
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 15.0
		layout.itemSize = CGSize(width: view.bounds.width-12, height: view.bounds.width/5)
		
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		guard let collectionView = collectionView else{
			return
		}
		collectionView.register(MuscleCollectionViewCell.self, forCellWithReuseIdentifier: MuscleCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
		
	}
    
	


}

extension ExerciseListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return exercisesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MuscleCollectionViewCell.identifier, for: indexPath) as? MuscleCollectionViewCell{
			print(exercisesArray[indexPath.row].Name)
			//cell.muscleData = Ex
		return cell
		}
		return UICollectionViewCell()
	}
	
	//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	//	let vc = ExerciseListViewController()
	//	vc.muscleGroup = muscles[indexPath.row]
	//	navigationController?.pushViewController(vc, animated: true)
	//}
	
	
}

