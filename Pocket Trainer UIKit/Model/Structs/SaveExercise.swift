//
//  SaveExercise.swift
//  Pocket Trainer
//
//  Created by vladukha on 16.09.2021.
//

import Foundation

class SavedExercise: Codable {
	var id = UUID()
	var Exercise: ExerciseSavedData
	var date: Date
	var Weights: [Int]
	

	
	init(Exercise: ExerciseSavedData, date: Date, Weights: [Int]) {
		self.Exercise = Exercise
		self.date = date
		self.Weights = Weights
	}
	
}
/// MARK: новый такой же но лучше класс, потому что апи написано макакой и приходится делать так
class ExerciseSavedData: Codable {
	/**
	Айди упражнения в тренировочном дне
	
	*/
	var ExerciseID: Int
	/**
	Количество подходов
	
	*/
	var SetNumber: Int {
		return RepsNumber.count
	}
	/**
	Количество повторений в подходе
	*/
	var RepsNumber: [Int]
	
	init(ExerciseID: Int, RepsNumber: [Int]) {
		self.ExerciseID = ExerciseID
		self.RepsNumber = RepsNumber
	}
}
