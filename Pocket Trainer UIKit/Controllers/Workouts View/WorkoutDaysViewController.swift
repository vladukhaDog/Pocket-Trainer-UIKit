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
		stackView.backgroundColor = UIColor.red
		return stackView
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(contentView)
		contentView.addSubview(stackView)
        setupConstraints()
    }
	
	//MARK: - functions
	private func setupConstraints() {
		//content constraints
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
		
		
		
		
		//sstackview constraints
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
		])
		
		
			
		
		//padding from scroll
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20)
			//stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
		])
		
		
		
		
	}
    


}
