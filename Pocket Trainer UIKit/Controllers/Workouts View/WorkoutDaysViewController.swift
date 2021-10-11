//
//  WorkoutDaysViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 07.10.2021.
//

import UIKit

class WorkoutDaysViewController: UIViewController {

	//MARK: - data vars
	var workout: Workout!
	private var workoutDays = [WorkoutDay]()
	private var currentWorkoutDay: WorkoutDay?
	private var exercises = [Exercise]()
	
	//MARK: - UI elements

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.backgroundColor = UIColor(named: "Background")
		return stackView
	}()
	
	private lazy var segmentControl: UISegmentedControl = {
		let seg = UISegmentedControl()
		seg.frame.size = CGSize(width: 0, height: 30)
		seg.translatesAutoresizingMaskIntoConstraints = false
		
		return seg
	}()
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(WorkoutExerciseCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutExerciseCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	
	//MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupViews()
        setConstraints()
		setDelegates()
		startFetch()
    }
	
	//MARK: - functions
	private func setupViews(){
		view.backgroundColor = UIColor(named: "Background")
		navigationItem.largeTitleDisplayMode = .never
		view.addSubview(segmentControl)
		view.addSubview(collectionView)
		segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
		
	}
	
	@objc func segmentedValueChanged(_ sender:UISegmentedControl!)
	   {
		   currentWorkoutDay = workoutDays[sender.selectedSegmentIndex]
		   collectionView.reloadData()
	   }
	
	private func setDelegates(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		
	}
	
	
	//MARK: - Get API Data
	private func startFetch(){
		getWorkoutDays(complete: {
			self.workoutDays = $0.filter({workoutDay in
				self.workout.WorkoutDays.contains(where: {$0.WorkoutDayID == workoutDay.WorkoutDayID})
			})
			for index in 0..<self.workoutDays.count {
				self.segmentControl.insertSegment(withTitle: self.workoutDays[index].Name ?? "", at: index, animated: true)
			}
			
			
			
			getExercises(complete: {
				self.exercises = $0
				self.segmentControl.selectedSegmentIndex = 0
				self.currentWorkoutDay = self.workoutDays[0]
				self.collectionView.reloadData()
			})
			
			
			
		})
		
	}
	
	
}

//MARK: - Constraints
extension WorkoutDaysViewController{
	private func setConstraints() {
		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
			segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			segmentControl.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -370)
			
		])
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15),
			collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
			collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			
		])
		
	}
}

extension WorkoutDaysViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return (currentWorkoutDay?.Exercises?.count) ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutExerciseCollectionViewCell.identifier, for: indexPath) as? WorkoutExerciseCollectionViewCell{
			let index = indexPath.item
			guard let exercise = self.currentWorkoutDay?.Exercises?[index] else {return UICollectionViewCell()}
			guard let exerciseToShow = exercises.first(where: {$0.ExerciseId == exercise.ExerciseID}) else {return UICollectionViewCell()}
			cell.exerciseData = exerciseToShow
			return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = ExerciseDetailViewController()
		let index = indexPath.item
		guard let exercise = self.currentWorkoutDay?.Exercises?[index] else {return}
		guard let exerciseToShow = exercises.first(where: {$0.ExerciseId == exercise.ExerciseID}) else {return}
		vc.exercise = exerciseToShow
		self.present(vc, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			
					width: collectionView.frame.width-20,
					height: self.view.bounds.width/5
				)
		
		
	}
}


