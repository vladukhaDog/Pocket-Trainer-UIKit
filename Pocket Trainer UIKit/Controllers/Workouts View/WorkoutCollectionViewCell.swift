//
//  WorkoutCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 06.10.2021.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
	//MARK: - Vars and Data
	static let identifier = "WorkoutCell"
	
	var workoutData: Workout? {
		didSet{
			workoutName.text = workoutData?.Name
			workoutImageView.sd_setImage(with: URL(string: workoutData?.ImagePath ?? ""))
		}
	}
	
	
	
	//MARK: - UI components
	private var workoutName: UILabel = {
		var label = UILabel()
		label.text = "Workout"
		
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var workoutImageView: UIImageView = {
		var image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	//initiating UI
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
	
	//MARK: - functions
	
	private func setupViews(){
		contentView.layer.cornerRadius = 20.0
		contentView.backgroundColor = UIColor(named: "Block")
		//contentView.layer.borderColor = UIColor.gray.cgColor
		//contentView.layer.borderWidth = 4.0
		
		addSubview(workoutImageView)
		addSubview(workoutName)
	}
	
	//MARK: - Layout

	
	//MARK: - I hate UIKit
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}


//MARK: - constraints
extension WorkoutCollectionViewCell{
	private func setConstraints(){
		NSLayoutConstraint.activate([
			workoutImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			workoutImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			workoutImageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
			workoutImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
		])
	
		NSLayoutConstraint.activate([
			workoutName.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10),
			workoutName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			workoutName.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			workoutName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
	
		])
	
	}
}
