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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
		setupViews()
        setConstraints()
    }
	
	//MARK: - functions
	private func setupViews(){
		view.addSubview(stackView)
	}
	
	
}

//MARK: - Constraints
extension WorkoutDaysViewController{
	private func setConstraints() {
		//sstackview constraints
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
	}
}
