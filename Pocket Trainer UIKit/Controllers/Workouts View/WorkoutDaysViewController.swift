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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupViews()
        setConstraints()
		startFetch()
    }
	
	//MARK: - functions
	private func setupViews(){
		view.backgroundColor = UIColor(named: "Background")
		navigationItem.largeTitleDisplayMode = .never
		view.addSubview(stackView)
		stackView.addArrangedSubview(segmentControl)
		segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
	}
	
	@objc func segmentedValueChanged(_ sender:UISegmentedControl!)
	   {
		   print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
	   }
	
	private func startFetch(){
		getWorkoutDays(complete: {
			self.workoutDays = $0.filter({workoutDay in
				self.workout.WorkoutDays.contains(where: {$0.WorkoutDayID == workoutDay.WorkoutDayID})
			})
			for index in 0..<self.workoutDays.count {
				self.segmentControl.insertSegment(withTitle: self.workoutDays[index].Name ?? "", at: index, animated: true)
			}
			self.segmentControl.selectedSegmentIndex = 0
		})
	}
	
	
}

//MARK: - Constraints
extension WorkoutDaysViewController{
	private func setConstraints() {
		//sstackview constraints
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
		
		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: stackView.topAnchor),
			segmentControl.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -60),
			segmentControl.heightAnchor.constraint(equalTo: stackView.widthAnchor, constant: -370)
			
		])
	}
}



