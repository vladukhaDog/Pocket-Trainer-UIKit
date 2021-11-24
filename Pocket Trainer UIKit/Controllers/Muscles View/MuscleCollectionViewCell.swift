//
//  MuscleCollectionViewCell.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 29.09.2021.
//

import UIKit
import SDWebImage
import Kingfisher

class MuscleCollectionViewCell: UICollectionViewCell {
    
	//MARK: - Vars and Data
	static let identifier = "MuscleCell"
	
	var muscleData: MuscleGroup? {
		didSet{
			muscleName.text = muscleData?.Name
			
			let url = URL(string: muscleData?.ImagePath ?? "")
			muscleImageView.kf.setImage(
				with: url,
				options: [
					.transition(.fade(0.4))
				])
		}
	}
	
	//MARK: - UI components
	private var muscleName: UILabel = {
		var label = UILabel()
		label.text = "Muscle"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var muscleImageView: UIImageView = {
		var image = UIImageView()
		image.sizeToFit()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	//initiating UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
		setConstraints()
		
	}
	
	private func setupViews(){
		contentView.layer.cornerRadius = 20.0
		contentView.backgroundColor = UIColor(named: "Block")
		
		addSubview(muscleName)
		addSubview(muscleImageView)
	}
	
    override var isSelected: Bool{
        didSet{
            
            if self.isSelected {
                
                contentView.backgroundColor = UIColor.gray
            } else {
                contentView.backgroundColor = UIColor(named: "Block")
            }
        }
    }
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	


}

//MARK: - constraints
extension MuscleCollectionViewCell{
	private func setConstraints(){
		NSLayoutConstraint.activate([
			muscleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			muscleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			muscleImageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
			muscleImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
		])
	
		NSLayoutConstraint.activate([
			muscleName.leadingAnchor.constraint(equalTo: muscleImageView.trailingAnchor, constant: 10),
			muscleName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			muscleName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			muscleName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
	
		])
	
	}
}

