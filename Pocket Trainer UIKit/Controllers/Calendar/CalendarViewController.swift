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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
		setConstraints()
    }
    
	
	@objc func datePickerValueChanged(_ sender: UIDatePicker){
		exercises = db.getExercisesByDate(sender.date)
	
	}
	
	
}




//MARK: - Initial setups
extension CalendarViewController{
	
	private func setupViews(){
		view.addSubview(datePicker)
		datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
	}
	
	private func setConstraints(){
		NSLayoutConstraint.activate([
			datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
			datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}
