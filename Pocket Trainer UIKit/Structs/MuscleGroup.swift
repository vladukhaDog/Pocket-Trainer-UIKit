//
//  MuscleGroup.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//


class MuscleGroup: Codable {
	var MuscleGroupID: Int
	var Name: String?
	var ImagePath: String?
	
	init(MuscleGroupID: Int, Name: String?, ImagePath: String?) {
		self.MuscleGroupID = MuscleGroupID
		self.Name = Name ?? nil
		self.ImagePath = ImagePath ?? nil
	}
}
