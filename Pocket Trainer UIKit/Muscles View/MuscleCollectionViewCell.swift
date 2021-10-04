//
//  MuscleCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit
import SDWebImage

class MuscleCollectionViewCell: UICollectionViewCell {
    
	//MARK: - Vars and Data
	static let identifier = "MuscleCell"
	
	var muscleData: MuscleGroup? {
		didSet{
			muscleName.text = muscleData?.Name
			muscleImageView.sd_setImage(with: URL(string: muscleData?.ImagePath ?? ""))
		}
	}
	
	//MARK: - UI components
	private var muscleName: UILabel = {
		var label = UILabel()
		label.text = "Muscle"
		return label
	}()
	
	private var muscleImageView: UIImageView = {
		var image = UIImageView()
		image.sizeToFit()
		return image
	}()
	
	//initiating UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.layer.cornerRadius = 20.0
		contentView.layer.borderColor = UIColor.gray.cgColor
		contentView.layer.borderWidth = 4.0
		
		addSubview(muscleName)
		addSubview(muscleImageView)
		
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
		muscleName.frame = CGRect(x: (contentView.bounds.width/4) + 8,
								  y: contentView.bounds.height/3,
								  width: (contentView.bounds.width/4)*2.5,
								  height: contentView.bounds.height/3)
		muscleImageView.frame = CGRect(x: 5,
									  y: contentView.bounds.height/6,
								   width: contentView.bounds.height - 20,
								   height: contentView.bounds.height - 20)
		
		
	}
	
	//MARK: - I hate UIKit
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	


}

