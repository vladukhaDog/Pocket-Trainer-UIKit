//
//  WorkoutDay.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

class WorkoutDay: Codable {
	var WorkoutDayID: Int
	var Name:String?
	/**
	Массив упражнений и их повторен
	*/
	var Exercises: [ExerciseData]?
	
	
	
	init(WorkoutDayID: Int, Name: String?, Exercises: [ExerciseData]?) {
		self.WorkoutDayID = WorkoutDayID
		self.Name = Name
		self.Exercises = Exercises
	}
}

class ExerciseData: Codable {
	/**
	Айди упражнения в тренировочном дне
	
	*/
	var ExerciseID: Int
	/**
	Количество подходов
	
	*/
	var SetNumber: Int
	/**
	Количество повторений в подходе
	*/
	var RepsNumber: Int
	
	init(ExerciseID: Int, SetNumber: Int, RepsNumber: Int) {
		self.ExerciseID = ExerciseID
		self.SetNumber = SetNumber
		self.RepsNumber = RepsNumber
	}
}
