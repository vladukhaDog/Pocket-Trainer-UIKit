//
//  WorkoutExerciseCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 11.10.2021.
//

import UIKit

class WorkoutExerciseCollectionViewCell: UICollectionViewCell {
	static let identifier = "WorkoutExerciseCell"
	
	//MARK: - functions
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	//downloads data from url and sets it as image
	//SDWebImage is not used since it animates gifs with no way of stopping them in regular UIImageView
	func fillImageFromUrl(url: URL, imageView: UIImageView){
		getData(from: url) { data, response, error in
				guard let data = data, error == nil else { return }
			DispatchQueue.main.async() {
					imageView.image = UIImage(data: data)
				}
			}
	}
	
	var exerciseData: Exercise!
	{
		didSet{
			//set name of an exercise
			exerciseName.text = exerciseData?.Name
	
			//set image of exercise
			let url = URL(string: exerciseData?.ImagePath ?? "")!
			fillImageFromUrl(url: url, imageView: exerciseImageView)
	
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
	
	private func setupViews(){
		contentView.layer.cornerRadius = 20.0
		contentView.layer.borderColor = UIColor.gray.cgColor
		contentView.layer.borderWidth = 4.0
	
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
extension WorkoutExerciseCollectionViewCell{
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
