//
//  ChooseExerciseViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit

class ChooseExerciseViewController: UIViewController {
	var delegate:ExerciseAdderDelegate?
	var exercises: [Exercise]!
	private var exercisesFiltered = [Exercise]()
	
	//MARK: - UI elements
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		//collectionView.backgroundColor = UIColor(named: "Background")
		collectionView.bounces = true
		collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private let searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.translatesAutoresizingMaskIntoConstraints = false
		bar.placeholder = "Поиск упражнения..."
		bar.enablesReturnKeyAutomatically = false
		return bar
	}()
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setConstraints()
		setDelegates()
		
		//startFetch()
    }
    


}


//MARK: - initial setups
extension ChooseExerciseViewController{
	private func setupViews(){
		view.backgroundColor = UIColor(named: "Background")
		view.addSubview(searchBar)
		view.addSubview(collectionView)
		exercisesFiltered = exercises
	}
	
	private func setDelegates(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		searchBar.delegate = self
		
	}
	
	//fetching Exercises from API
	private func startFetch(){
		getExercises(complete: {(cum) in
			self.exercises = cum
			self.exercisesFiltered = cum
			self.collectionView.reloadData()
			})
			
		
	}
	
	private func setConstraints(){
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.topAnchor),
			searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
			searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
		])
		
	}
}


//MARK: - CollectionView Delegate & DataSource
extension ChooseExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return exercisesFiltered.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as? ExerciseCollectionViewCell{
			cell.exerciseData = exercisesFiltered[indexPath.row]
		return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//print("pressed")
		let saved = SavedExercise(Exercise: ExerciseSavedData(ExerciseID: exercisesFiltered[indexPath.row].ExerciseId, RepsNumber: []), date: Date(), Weights: [])
		delegate?.addExercise(saved)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			
					width: collectionView.frame.width-20,
					height: self.view.bounds.width/5
				)
		
		
	}
	
	
}


//MARK: - SearchBar delegate
extension ChooseExerciseViewController: UISearchBarDelegate{
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
			exercisesFiltered = searchText.isEmpty ? exercises : exercises.filter { (item: Exercise) -> Bool in
				// If dataItem matches the searchText, return true to include it
				return item.Name.lowercased().contains(searchText.lowercased())
			}
			
			collectionView.reloadData()
		}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}
