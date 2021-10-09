//
//  Requester.swift
//  Pocket Trainer UIKit
//
//  Created by vladukha on 13.09.2021.
//

import Alamofire


let Url = "https://skylice.ru/pocket-trainer-api/"



func getExercises(complete: @escaping ([Exercise])->()) {
	AF.request("\(Url)getexercises.php").response {response in
		guard let data = response.data else { return }
		do {
			let exercises = try JSONDecoder().decode([Exercise].self, from: data)
			complete(exercises)
			
		} catch let error {
			
			print(error)
		}
	}
}

func getMuscleGroups(complete: @escaping ([MuscleGroup])->()) {
	AF.request("\(Url)getmusclegroups.php").response {response in
		guard let data = response.data else { return }
		do {
			let muscleGroups = try JSONDecoder().decode([MuscleGroup].self, from: data)
			complete(muscleGroups)
			
		} catch let error {
			
			print(error)
		}
	}
}

func getWorkouts(complete: @escaping ([Workout])->()) {
	AF.request("\(Url)getworkouts.php").response {response in
		guard let data = response.data else { return }
		do {
			let workouts = try JSONDecoder().decode([Workout].self, from: data)
			complete(workouts)
			
		} catch let error {
			
			print(error)
		}
	}
}


func getWorkoutDays(complete: @escaping ([WorkoutDay])->()) {
	AF.request("\(Url)getworkoutdays.php").response {response in
		guard let data = response.data else { return }
		do {
			let workoutDay = try JSONDecoder().decode([WorkoutDay].self, from: data)
			complete(workoutDay)
			
		} catch let error {
			
			print(error)
		}
	}
}


