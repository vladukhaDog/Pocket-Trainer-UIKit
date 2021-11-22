//
//  CalendarViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit

protocol ExerciseAdderDelegate{
	func addExercise(exerciseID: Int, weights: [Int], repsNumber: [Int])
	func editExercise(_ exercise: SavedExercise)
	func removeExercise(_ exercise: SavedExercise)
}

class CalendarViewController: UIViewController, ExerciseAdderDelegate {

	private var exercises = [Exercise]()
	private let db = dbManager()
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
		picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
		return picker
	}()
	
	private var addButton: UIButton = {
		let button = UIButton()
		button.setTitle("Добавить Упражнение", for: .normal)
		button.setTitleColor(UIColor.systemBlue, for: .normal)
		button.setTitleColor(UIColor.systemGray, for: .disabled)
		button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.4), for: .highlighted)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isEnabled = false
		button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
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
		NetworkManager.shared.getExercises(complete: {(cum) in
			self.exercises = cum
			self.addButton.isEnabled = true
			self.collectionView.reloadData()
			})
	}
	
	
}

//MARK: - delegates
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return savedExercises.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedExerciseCollectionViewCell.identifier, for: indexPath) as? SavedExerciseCollectionViewCell{
			cell.exerciseData = savedExercises[indexPath.row]
			cell.exercise = exercises.first(where: {$0.ExerciseId == savedExercises[indexPath.row].exerciseID})
			cell.delegate = self
		return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let saved = savedExercises[indexPath.row]
		let vc = SavedExerciseRepsViewController()
		vc.delegate = self
		vc.exerciseData = saved
		if let sheet = vc.sheetPresentationController {
			sheet.detents = [.medium()]
			sheet.largestUndimmedDetentIdentifier = .medium
			sheet.prefersEdgeAttachedInCompactHeight = false
			sheet.preferredCornerRadius = 16.0
			sheet.prefersGrabberVisible = true
		}
		present(vc, animated: true, completion: nil)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(

					width: collectionView.frame.width-20,
					height: 100
				)
	}
	


	
	
}

//MARK: - Initial setups
extension CalendarViewController{
	
	private func setupViews(){
		
		//MARK: - DEBUG
		
		savedExercises = db.getExercisesByDate(Date())
		
		view.addSubview(datePicker)
		view.addSubview(addButton)
		view.addSubview(collectionView)
		
		//design little
		view.backgroundColor = UIColor(named: "Background")
		collectionView.backgroundColor = .clear
		self.navigationController?.isNavigationBarHidden = true
		collectionView.delaysContentTouches = false
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		
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
			collectionView.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -10)
		])
	}
}


//MARK: - database delegate extension
extension CalendarViewController{
	
	func addExercise(exerciseID: Int, weights: [Int], repsNumber: [Int]) {
		//ADD
		db.addExerciseToDB(exerciseID: exerciseID, date: datePicker.date, weights: weights, repsNumber: repsNumber)
		savedExercises = db.getExercisesByDate(datePicker.date)
		collectionView.reloadData()
		self.dismiss(animated: true)
	}
	func editExercise(_ exercise: SavedExercise) {
		//EDIT
		guard let index = savedExercises.firstIndex(where: {$0.id == exercise.id}) else {return}
		savedExercises[index] = exercise
		do{
		try db.edit(exercise)
		}catch{
				print("died")
		}
		collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
	}
	
	func removeExercise(_ exercise: SavedExercise) {
		//REMOVE
		guard let index = savedExercises.firstIndex(where: {$0.id == exercise.id}) else {return}
		savedExercises.remove(at: index)
		do{
		try db.remove(exercise)
		}catch{
				print("died")
		}
		collectionView.reloadData()
	}
	
}
