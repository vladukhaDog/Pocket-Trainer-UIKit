//
//  CalendarViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit

class CalendarViewController: UIViewController {
	private let db = DataBase()
	private var exercises = [SavedExercise]()
	
	
	//MARK: - UI elements
	private let datePicker: UIDatePicker = {
		let picker = UIDatePicker()
		picker.datePickerMode = .date
		picker.preferredDatePickerStyle = .compact
		picker.translatesAutoresizingMaskIntoConstraints = false
		
		return picker
	}()
	
	private var addButton: UIButton = {
		let button = UIButton()
		button.setTitle("Добавить Упражнение", for: .normal)
		button.setTitleColor(UIColor.systemBlue, for: .normal)
		button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.4), for: .highlighted)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	
	//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
		setConstraints()
    }
    
	//MARK: - functions
	@objc private func datePickerValueChanged(_ sender: UIDatePicker){
		dateChange()
	
	}
	private func dateChange(){
		exercises = db.getExercisesByDate(datePicker.date)
		print("Changed date")
	}
	
	@objc private func buttonPressed(_ sender: UIButton){
		self.present(ChooseExerciseViewController(), animated: true)
	}
	
	
}




//MARK: - Initial setups
extension CalendarViewController{
	
	private func setupViews(){
		view.addSubview(datePicker)
		view.addSubview(addButton)
		view.backgroundColor = UIColor(named: "Background")
		title = ""
		datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
		addButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
		exercises = db.getExercisesByDate(Date())
	}
	
	//MARK: - Constraints
	private func setConstraints(){
		NSLayoutConstraint.activate([
			datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
		])
		NSLayoutConstraint.activate([
			addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		])
	}
}
