//
//  ExerciseCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 30.09.2021.
//

import UIKit
import SDWebImage
import Kingfisher

class ExerciseCollectionViewCell: UICollectionViewCell {
	static let identifier = "ExerciseCell"
	
	
	
	var exerciseData: Exercise!
	{
		didSet{
			//set name of an exercise
			exerciseName.text = exerciseData?.Name
	
			//set image of exercise
			let url = URL(string: exerciseData?.ImagePath ?? "")!
            let processor = DownsamplingImageProcessor(size: exerciseImageView.bounds.size)
			exerciseImageView.kf.setImage(
				with: url,
				options: [
                    .processor(processor),
					.transition(.fade(0.4)),
                    .cacheOriginalImage,
                    .onlyLoadFirstFrame
				])
	
		}
	}

	
	//MARK: - UI components
	private var exerciseName: UILabel = {
		var label = UILabel()
		label.text = "Exercise"
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
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
	
		addSubview(exerciseName)
		addSubview(exerciseImageView)
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
extension ExerciseCollectionViewCell{
	private func setConstraints(){
		NSLayoutConstraint.activate([
			exerciseImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			exerciseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			exerciseImageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
			exerciseImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
		])
	
		NSLayoutConstraint.activate([
			exerciseName.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
			exerciseName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			exerciseName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			exerciseName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
	
		])
	
	}
}
