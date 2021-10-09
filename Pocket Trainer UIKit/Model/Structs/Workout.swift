//
//  Workout.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

class Workout: Codable, Identifiable {
	var ID: Int
	var Name: String
	var ImagePath: String?
	var WorkoutDays: [WorkoutDay]
	
	init(ID: Int, Name: String, ImagePath: String?, WorkoutDays: [WorkoutDay]){
		self.ID = ID
		self.Name = Name
		self.ImagePath = ImagePath
		self.WorkoutDays = WorkoutDays
	}
	
	
	//class WorkoutData: Codable{
	//	var WorkoutDayID: Int
	//	init(WorkoutDayID: Int) {
	//		self.WorkoutDayID = WorkoutDayID
	//	}
	//}
}
