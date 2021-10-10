//
//  ExerciseDetailViewController.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 30.09.2021.
//

import UIKit
import SDWebImage

class ExerciseDetailViewController: UIViewController {
	
	//MARK: - Data
	var exercise: Exercise!
	private var musclesToShow = [MuscleGroup]()

	
	
	//MARK: - UI Elements
	private var exerciseImageView: ScaledHeightImageView {
		let image = ScaledHeightImageView()
		image.sd_setImage(with: URL(string: exercise.ImagePath ?? ""))
		image.layer.cornerRadius = 16.0
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		image.backgroundColor = .clear
		return image
	}
	private var descriptionTitleLabel: UILabel {
		let label = UILabel()
		label.text = "Описание"
		
		label.font = label.font.withSize(25)
		label.textColor = UIColor.lightGray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	private var exerciseDescriptionLabel: UILabel {
		let label = UILabel()
		label.text = exercise.Description
		label.numberOfLines = 0
		
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private lazy var contentView: UIView = {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		return contentView
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	private lazy var musclesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 16
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	
	
	//MARK: - DID LOAD
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(named: "Background")
		makeBarTitle()
		
		configureSubviews()
		setupConstraints()
		fetchMuscleNames()
		
		
	}
	
	
	
	//MARK: - functions
	
	private func fetchMuscleNames(){
		getMuscleGroups(complete: { muscles in
			self.musclesToShow = muscles.filter({ muscle in
				self.exercise.MuscleGroups.contains(where: {$0.MuscleGroupID == muscle.MuscleGroupID})
			})
			self.makeMuscleList()
		})
	}
	
	private func makeMuscleList(){
		for musc in self.musclesToShow {
			let label = UILabelPadding()
			label.layer.borderColor = UIColor.lightGray.cgColor
			label.layer.borderWidth = 3.0
			label.layer.cornerRadius = 14.0
			//label.layer.bounds.size = CGSize(width: label.bounds.size.width + 5, height: label.bounds.size.height + 5)
			label.text = musc.Name
			musclesStackView.addArrangedSubview(label)
			
		}
		//ImageMusclesStackView.addArrangedSubview(musclesStackView)
	}
	
	private func configureSubviews() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(stackView)
		
		stackView.addArrangedSubview(exerciseImageView)
		stackView.addArrangedSubview(musclesStackView)
		stackView.addArrangedSubview(descriptionTitleLabel)
		stackView.addArrangedSubview(exerciseDescriptionLabel)
		
		
		
	}
	
	
	
	//since UINavigationBarTitle cant be multiline, this shit has to be UIView
	func makeBarTitle(){
		let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
		label.backgroundColor = UIColor.clear
		label.numberOfLines = 0
		label.textAlignment = NSTextAlignment.center
		label.text = exercise.Name
		label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
		self.navigationItem.largeTitleDisplayMode = .always
		self.navigationItem.titleView = label
	}
	
	
	
	
	
}


//MARK: - Constraints
extension ExerciseDetailViewController{
	private func setupConstraints() {
		//scrollView constraints
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
		
		//content in scroll view constraints
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
		])
		
		
		
		//stackview in contentView (maybe i could skip contentView and display stackView initially in scroll view but fuck that)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
		])
		
		
			
		
		//padding from scroll
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
			scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20)
			//stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
		])
		
		
		
		
	}
}


//MARK: - overrides for UI elements

//if only i could remember where i stole it
class UILabelPadding: UILabel {

	let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: padding))
	}

	override var intrinsicContentSize : CGSize {
		let superContentSize = super.intrinsicContentSize
		let width = superContentSize.width + padding.left + padding.right
		let heigth = superContentSize.height + padding.top + padding.bottom
		return CGSize(width: width, height: heigth)
	}



}


//https://stackoverflow.com/questions/41154784/how-to-resize-uiimageview-based-on-uiimages-size-ratio-in-swift-3
//https://stackoverflow.com/a/48937190
class ScaledHeightImageView: UIImageView {

	override var intrinsicContentSize: CGSize {

		if let myImage = self.image {
			let myImageWidth = myImage.size.width
			let myImageHeight = myImage.size.height
			let myViewWidth = self.frame.size.width
 
			let ratio = myViewWidth/myImageWidth
			let scaledHeight = myImageHeight * ratio

			return CGSize(width: myViewWidth, height: scaledHeight)
		}

		return CGSize(width: 450, height: 450)
	}

}
