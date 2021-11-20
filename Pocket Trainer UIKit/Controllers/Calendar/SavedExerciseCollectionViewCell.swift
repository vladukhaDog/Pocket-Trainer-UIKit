//
//  SavedExerciseCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 14.10.2021.
//

import UIKit
import Kingfisher

class SavedExerciseCollectionViewCell: UICollectionViewCell {
	static let identifier = "SavecExerciseCell"
	
	var delegate: ExerciseAdderDelegate!
	
	var exerciseData: SavedExercise!{
		didSet{
			exerciseRepsLabel.text = "Подходов: \(exerciseData.weights.count)"
		}
	}
	
	var exercise: Exercise!{
		didSet{
			guard let exercise = exercise else {return}

			//set name of an exercise
			exerciseNameLabel.text = exercise.Name
			//set image of exercise
			let url = URL(string: exercise.ImagePath ?? "")!
			exerciseImageView.kf.setImage(
				with: url,
				options: [
					.transition(.fade(0.4)),
					
				])
			
		}
	}
	
	//MARK: - UI components
	
	
	private var exerciseNameLabel: UILabel = {
		var label = UILabel()
		label.text = ""
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private var exerciseRepsLabel: UILabel = {
		var label = UILabel()
		label.text = ""
		label.textColor = UIColor.gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var exerciseImageView: UIImageView = {
		var image = UIImageView()
		image.sizeToFit()
		image.layer.cornerRadius = 8.0
		image.clipsToBounds = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	private var removeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "trash")?.withTintColor(.systemRed), for: .normal)//.image = UIImage(systemName: "trash")
		button.tintColor = .red
		button.addTarget(self, action: #selector(removeButtonPressed(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	
	
	

	
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
		setConstraints()
		setDelegates()
		
	}
	
	//MARK: - functions
	
	@objc private func removeButtonPressed(_ sender: UIButton) {
		delegate.removeExercise(exerciseData)
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
	
	
}

//MARK: - constraints and view setups
extension SavedExerciseCollectionViewCell{

	private func setupViews(){
		contentView.layer.cornerRadius = 20.0
		contentView.backgroundColor = UIColor(named: "Block")
		addSubview(exerciseNameLabel)
		addSubview(exerciseImageView)
		addSubview(exerciseRepsLabel)
		addSubview(removeButton)
	}
	
	private func setDelegates(){
	}
	
	private func setConstraints(){
		NSLayoutConstraint.activate([
			exerciseImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			exerciseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			exerciseImageView.heightAnchor.constraint(equalTo: self.heightAnchor,constant: -20),
			exerciseImageView.widthAnchor.constraint(equalTo: exerciseImageView.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			exerciseNameLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
			exerciseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			exerciseNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10)
			
		])
		
		NSLayoutConstraint.activate([
			exerciseRepsLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
			exerciseRepsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			exerciseRepsLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10),
			
		])
		NSLayoutConstraint.activate([
			removeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
			removeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
		])
		
		
	}
}

