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
	private let musclesCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 5.0
        layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(MuscleCollectionViewCell.self, forCellWithReuseIdentifier: MuscleCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
    
    private let exercisesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.bounces = true
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    //MARK: - Data variables
    private var exercisesToShow = [Exercise]()
    private var exercisesList = [Exercise]() {
        didSet{
            exercisesToShow = exercisesList.filter({ exercise in
                exercise.MuscleGroups.contains { muscle in
                    muscle.MuscleGroupID == muscleGroup?.MuscleGroupID
                }
            })
            exercisesCollectionView.reloadData()
        }
    }
    private var muscleGroup: MuscleGroup?
    
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
		NetworkManager.shared.getMuscleGroups(complete: {(muscs) in
			self.muscles = muscs
				self.musclesCollectionView.reloadData()
            let index = IndexPath(row: 0, section: 0)
            self.musclesCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
		})
        
        NetworkManager.shared.getExercises(complete: {(exerc) in
            self.exercisesList = exerc
        })
        
	}
	private func setupViews(){
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(named: "Background")
		view.addSubview(musclesCollectionView)
        view.addSubview(exercisesCollectionView)
        musclesCollectionView.allowsSelection = true
		musclesCollectionView.delaysContentTouches = false
        
        exercisesCollectionView.delaysContentTouches = false
        
	}
	
	private func setDelegates(){
		
		musclesCollectionView.delegate = self
		musclesCollectionView.dataSource = self
        exercisesCollectionView.delegate = self
        exercisesCollectionView.dataSource = self
		
		
	}
}


//MARK: - Constraints
extension MuscleListViewController{
	private func setConstraints(){
		
        NSLayoutConstraint.activate([
            musclesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            musclesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            musclesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            musclesCollectionView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
            exercisesCollectionView.topAnchor.constraint(equalTo: musclesCollectionView.bottomAnchor, constant: 5),
            exercisesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            exercisesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            exercisesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
}


//MARK: - Delegate & DataSource
extension MuscleListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case musclesCollectionView:
            return muscles.count
        case exercisesCollectionView:
            return exercisesToShow.count
        default:
            return 0
        }
                    
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case musclesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MuscleCollectionViewCell.identifier, for: indexPath) as? MuscleCollectionViewCell{
                cell.muscleData = muscles[indexPath.row]
            return cell
            }
        case exercisesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as? ExerciseCollectionViewCell{
                cell.exerciseData = exercisesToShow[indexPath.row]
            return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        
        switch collectionView {
        case musclesCollectionView:
            musclesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            muscleGroup = muscles[indexPath.row]
            exercisesToShow = exercisesList.filter({ exercise in
                exercise.MuscleGroups.contains { muscle in
                    muscle.MuscleGroupID == muscleGroup?.MuscleGroupID
                }
            })
            exercisesCollectionView.reloadData()
        case exercisesCollectionView:
            let vc = ExerciseDetailViewController()
            vc.exercise = exercisesToShow[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case musclesCollectionView:
            return CGSize(
                width: collectionView.frame.width/3.5,
                height: 40
            )
        case exercisesCollectionView:
            return CGSize(
                width: collectionView.frame.width-20,
                height: self.view.bounds.width/5
            )
        default:
            return CGSize()
        }
        
        
	}
	
}



