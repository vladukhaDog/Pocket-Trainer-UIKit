//
//  WorkoutExerciseCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit
import Kingfisher

class WorkoutExerciseCollectionViewCell: UICollectionViewCell {
	static let identifier = "WorkoutExerciseCell"
	
	var exerciseData: ExerciseData!
	{
		didSet{
			repsLabel.text = String(exerciseData.RepsNumber)
			setsLabel.text = String(exerciseData.SetNumber)
		}
	}
	
	
	var exercise: Exercise!
	{
		didSet{
			//set name of an exercise
			exerciseNameLabel.text = exercise?.Name
	
			//set image of exercise
			let url = URL(string: exercise?.ImagePath ?? "")
			exerciseImageView.kf.setImage(
				with: url,
				options: [
					.transition(.fade(0.4)),
					
				])
	
		}
	}

	
	//MARK: - UI components
	
	private var exerciseNameLabel: UILabel = {
		let label = UILabel()
		label.text = "Exercise"
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var setsLabel: UILabel = {
		let label = UILabel()
		label.text = "Sets"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var repsLabel: UILabel = {
		let label = UILabel()
		label.text = "Reps"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var byLabel: UILabel = {
		let label = UILabel()
		label.text = "по"
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
	private var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 5
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
	
		setupViews()
		setConstraints()
	
	}
	
	
	//MARK: - functions
	
	private func setupViews(){
		contentView.layer.cornerRadius = 20.0
		contentView.backgroundColor = UIColor(named: "Block")
		//contentView.layer.borderColor = UIColor.gray.cgColor
		//contentView.layer.borderWidth = 4.0
	
		addSubview(exerciseNameLabel)
		addSubview(exerciseImageView)
		addSubview(stackView)
		stackView.addArrangedSubview(repsLabel)
		stackView.addArrangedSubview(byLabel)
		stackView.addArrangedSubview(setsLabel)
		
		
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

//MARK: - constraints
extension WorkoutExerciseCollectionViewCell{
	private func setConstraints(){
		NSLayoutConstraint.activate([
			exerciseImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			exerciseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			exerciseImageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
			exerciseImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
		])
	
		NSLayoutConstraint.activate([
			//stackView.leadingAnchor.constraint(equalTo: exerciseNameLabel.trailingAnchor, constant: 10),
			stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
	
		])
		
		NSLayoutConstraint.activate([
			exerciseNameLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
			exerciseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			exerciseNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			exerciseNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
	
		])
		
		
	
	}
}
