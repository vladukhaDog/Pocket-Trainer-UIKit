//
//  CalendarViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit

protocol ExerciseAdderDelegate{
	func addExercise(_ exercise: SavedExercise)
	func editExercise(_ exercise: SavedExercise)
	func removeExercise(_ exercise: SavedExercise)
}

class CalendarViewController: UIViewController, ExerciseAdderDelegate {

	private var exercises = [Exercise]()
	private let db = DataBase()
	private var savedExercises = [SavedExercise]()
	
	
	//MARK: - UI elements
	
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		//collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(SavedExerciseCollectionViewCell.self, forCellWithReuseIdentifier: SavedExerciseCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
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
		button.isEnabled = false
		return button
	}()
	


	
	//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
		setConstraints()
		setDelegates()
		startFetch()
    }
    
	//MARK: - functions
	@objc private func datePickerValueChanged(_ sender: UIDatePicker){
		dateChange()
	
	}
	private func dateChange(){
		savedExercises = db.getExercisesByDate(datePicker.date)
		collectionView.reloadData()
		print("Changed date")
	}
	
	@objc private func buttonPressed(_ sender: UIButton){
		let vc = ChooseExerciseViewController()
		vc.delegate = self
		vc.exercises = self.exercises
		self.present(vc, animated: true)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			
			collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
			
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		collectionView.contentInset = .zero
	}
	
	
	
	private func startFetch(){
		Requester.shared.getExercises(complete: {(cum) in
			self.exercises = cum
			self.addButton.isEnabled = true
			self.collectionView.reloadData()
			})
	}
	
	
}

//MARK: - delegates
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print(savedExercises.count)
		return savedExercises.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedExerciseCollectionViewCell.identifier, for: indexPath) as? SavedExerciseCollectionViewCell{
			//cell.exerciseData = savedExercises[indexPath.row]
			cell.exercise = exercises.first(where: {$0.ExerciseId == savedExercises[indexPath.row].Exercise.ExerciseID})
		return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("pressed")
		let saved = savedExercises[indexPath.row]
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(

					width: collectionView.frame.width-20,
					height: 130
				)
	}
	


	
	
}

//MARK: - Initial setups
extension CalendarViewController{
	
	private func setupViews(){
		view.addSubview(datePicker)
		view.addSubview(addButton)
		view.addSubview(collectionView)
		
		//design little
		view.backgroundColor = UIColor(named: "Background")
		collectionView.backgroundColor = .clear
		self.navigationController?.isNavigationBarHidden = true
		
		
		
		//logic
		datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
		addButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
		savedExercises = db.getExercisesByDate(Date())
		
		
		
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		for i in 1...10{
		savedExercises.append(SavedExercise(Exercise: ExerciseSavedData(ExerciseID: 10, RepsNumber: [30,12]), date: Date(), Weights: [10,12]))
		}
	}
	
	private func setDelegates(){
		collectionView.delegate = self
		collectionView.dataSource = self
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
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: 0)
		])
	}
}


//MARK: - database delegate extension
extension CalendarViewController{
	
	func addExercise(_ exercise: SavedExercise) {
		//ADD
		savedExercises.append(exercise)
		collectionView.reloadData()
		self.dismiss(animated: true)
	}
	func editExercise(_ exercise: SavedExercise) {
		//EDIT
	}
	
	func removeExercise(_ exercise: SavedExercise) {
		//REMOVE
	}
	
}
