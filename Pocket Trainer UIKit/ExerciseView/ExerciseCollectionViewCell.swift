//
//  ExerciseCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 30.09.2021.
//

import UIKit
import SDWebImage

class ExerciseCollectionViewCell: UICollectionViewCell {
	static let identifier = "ExerciseCell"
	
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
	
	//filling Data in view
	var exerciseData: Exercise? {
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
		return label
	}()
	
	private var exerciseImageView: UIImageView = {
		var image = UIImageView()
		image.sizeToFit()
		image.layer.cornerRadius = 8.0
		image.clipsToBounds = true
		
		return image
	}()
	

	//initing how cell is portrayed
	override init(frame: CGRect) {
		super.init(frame: frame)
		
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
	
	
	//MARK: - layout of UI elements
	override func layoutSubviews() {
		super.layoutSubviews()
		
		exerciseName.frame = CGRect(x: (contentView.bounds.width/4) + 8,
								  y: contentView.bounds.height/6,
									width: (contentView.bounds.width/4)*2.5,
								  height: (contentView.bounds.height/3) * 2)
		exerciseImageView.frame = CGRect(x: 20,
									  y: contentView.bounds.height/7,
								   width: contentView.bounds.height - 20,
								   height: contentView.bounds.height - 20)
		
		
	}
	
	//MARK: - I hate UIKit
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}
