//
//  Exercise.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

class Exercise: Codable {
	var ExerciseId: Int
	var Name: String
	var Description: String
	var ImagePath: String?
	var MuscleGroups: [MuscleGroup]
	
	init(ExerciseId: Int, Name: String, Description: String, ImagePath: String?, MuscleGroups: [MuscleGroup]) {
		self.ExerciseId = ExerciseId
		self.Name = Name
		self.Description = Description
		self.ImagePath = ImagePath
		self.MuscleGroups = MuscleGroups
	}
	
}

