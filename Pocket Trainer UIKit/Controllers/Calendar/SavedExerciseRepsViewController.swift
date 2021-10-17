//
//  SavedExerciseRepsViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 17.10.2021.
//

import UIKit

class SavedExerciseRepsViewController: UIViewController {
	
	var delegate:ExerciseAdderDelegate?
	
	var exerciseData: SavedExercise!
	{
		didSet{
			
		}
	}
	
	//MARK: - UI elements
	private let weightTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "кг"
		return textField
	}()
	
	private let repsTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "🔁"
		return textField
	}()
	
	private let numbersStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 10
		stack.distribution = .fillProportionally
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	
	//MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}


//MARK: - Textfield delegates
extension SavedExerciseRepsViewController: UITextFieldDelegate{
	
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		repsTextField.resignFirstResponder()
		weightTextField.resignFirstResponder()
		return true
	}
}
