//
//  SavedExerciseRepsViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 17.10.2021.
//

import UIKit
import Foundation

class SavedExerciseRepsViewController: UIViewController {
	
	var delegate:ExerciseAdderDelegate?
	
	var exerciseData: SavedExercise!
	
	//MARK: - UI elements
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		layout.minimumInteritemSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.bounces = true
		collectionView.delaysContentTouches = false
		collectionView.register(removeCell.self, forCellWithReuseIdentifier: removeCell.identifier)
		collectionView.register(repCell.self, forCellWithReuseIdentifier: repCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
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
	private let topStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 10
		stack.distribution = .fillProportionally
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private var addButton: UIButton = {
		let button = UIButton()
		button.setTitle("Добавить Подход", for: .normal)
		button.setTitleColor(UIColor.systemBlue, for: .normal)
		button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.4), for: .highlighted)
		button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	
	

	
	//MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setConstraints()
		setDelegates()
		
    }
	
	
	//MARK: - functions
	
	@objc private func addButtonPressed(_ sender: UIButton){
		addSet()
	}
	
    
	
	private func addSet(){
		let repsString = repsTextField.text ?? ""
		let weightString = weightTextField.text ?? ""
		guard let reps = Int(repsString) else {return}
		guard let weight = Int(weightString) else {return}
		
		exerciseData.Weights.append(weight)
		exerciseData.RepsNumber.append(reps)
		collectionView.reloadData()
		delegate?.editExercise(exerciseData)
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


//MARK: - constraints and view setups
extension SavedExerciseRepsViewController{
	
	private func setupViews(){
		view.backgroundColor = UIColor(named: "BackgroundTabBar")
		
		view.addSubview(topStackView)
		view.addSubview(collectionView)
		
		
		topStackView.addArrangedSubview(numbersStackView)
		//view.addSubview(numbersStackView)
		numbersStackView.addArrangedSubview(weightTextField)
		numbersStackView.addArrangedSubview(repsTextField)
		
		topStackView.addArrangedSubview(addButton)
		
		
		
		
	}
	
	private func setDelegates(){
		weightTextField.delegate = self
		repsTextField.delegate = self
		
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	private func setConstraints(){
		
		
		NSLayoutConstraint.activate([
			topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
		
		])
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor,constant: 10),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
		])
		
		
		
		
	}
}


//MARK: - delegates
extension SavedExerciseRepsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return (exerciseData.SetNumber > 0 ? exerciseData.SetNumber + 1 : 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if (indexPath.row == exerciseData.SetNumber){
			if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: removeCell.identifier, for: indexPath) as? removeCell{
				return cell
			}
		}else {
			if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: repCell.identifier, for: indexPath) as? repCell{
				let reps = exerciseData.RepsNumber[indexPath.row]
				let weight = exerciseData.Weights[indexPath.row]
				cell.configure(reps: reps, weight: weight)
				return cell
			}
		}
		return UICollectionViewCell()
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if (indexPath.row == exerciseData.SetNumber){
			exerciseData.Weights.removeLast()
			exerciseData.RepsNumber.removeLast()
			collectionView.reloadData()
			delegate?.editExercise(exerciseData)
		}
	}
}

//MARK: - remove Button in collectionView
class removeCell: UICollectionViewCell{
	static var identifier = "deleteCell"
	
	
	//MARK: - UI elements
	private var removeButton: UIImageView = {
		let button = UIImageView()
		button.image = UIImage(systemName: "minus")
		button.tintColor = .red
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	
	//MARK: - INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
		setConstraints()
	}
	
	override var isHighlighted: Bool {
		didSet {
			if self.isHighlighted {
				alpha = 0.5
			} else {
				alpha = 1.0
			}
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	//MARK: - functions
	private func setupViews(){
		addSubview(removeButton)
		
		self.layer.cornerRadius = 16.0
		self.layer.borderWidth = 2.0
		self.layer.borderColor = UIColor.systemRed.cgColor
	}
	
	//MARK: - constraints
	private func setConstraints(){
		NSLayoutConstraint.activate([
			removeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			removeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
}


//MARK: - SetData Cell
class repCell: UICollectionViewCell{
	static var identifier = "repCell"
	
	
	//MARK: - UI elements
	private var repsLabel: UILabel = {
		var label = UILabel()
		label.text = ""
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private var weightLabel: UILabel = {
		var label = UILabel()
		label.text = ""
		label.textColor = UIColor.gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	//MARK: - INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	//MARK: - functions
	
	
	func configure(reps: Int, weight: Int){
		repsLabel.text = "\(reps)"
		weightLabel.text = "\(weight)кг"
	}
	
	private func setupViews(){
		addSubview(repsLabel)
		addSubview(weightLabel)
		
		
		self.layer.cornerRadius = 16.0
		self.layer.borderWidth = 2.0
		self.layer.borderColor = UIColor.gray.cgColor
	}
	
	
	//MARK: - Constraints
	private func setConstraints(){
		NSLayoutConstraint.activate([
			repsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			repsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
			
		])
		
		NSLayoutConstraint.activate([
			weightLabel.topAnchor.constraint(equalTo: repsLabel.bottomAnchor),
			weightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
	
}
