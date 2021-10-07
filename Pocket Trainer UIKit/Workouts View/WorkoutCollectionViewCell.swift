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
	
	var showDays: Bool = false{
		didSet{
			
			
		}
	}
	
	//MARK: - UI components
	private var workoutName: UILabel = {
		var label = UILabel()
		label.text = "Workout"
		
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		return label
	}()
	
	private var workoutImageView: UIImageView = {
		var image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	//initiating UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.layer.cornerRadius = 20.0
		contentView.layer.borderColor = UIColor.gray.cgColor
		contentView.layer.borderWidth = 4.0
		
		addSubview(workoutName)
		addSubview(workoutImageView)
		
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
	
	//MARK: - Layout
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// why in the damn Odin's name this has to be done here
		
		workoutImageView.frame = CGRect(x: 20,
									  y: (contentView.bounds.height/5)/2,
								   width: (contentView.bounds.height/5)*4,
								   height: (contentView.bounds.height/5)*4)
		workoutName.frame = CGRect(x: ((contentView.bounds.height/5)*4) + 30,
								  y: contentView.bounds.height/6,
									width: (contentView.bounds.width/4)*2,
								  height: (contentView.bounds.height/6)*5)
		
		
	}
	
	//MARK: - I hate UIKit
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}
