
//
//  DataBase.swift
//  Pocket Trainer
//
//  Created by vladukha on 11.10.2021.
//

import Foundation
import CoreData

/**
 ошибки выдаваемые базой данных
 */
enum dbError: Error {
	case noEntryById(UUID)
}


class DataBase{
	
	// MARK: - Core Data stack

	private lazy var persistentContainer: NSPersistentContainer = {
	   
		let container = NSPersistentContainer(name: "Pocket_Trainer_UIKit")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	// MARK: - Core Data Saving support

	private func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
	
	//MARK: - db manipulations
	
	/**
	 Возвращает из базы упражнения по указанной дате
	 - Parameter recipient: Дата по которой искать упражнения
	 */
	func getExercisesByDate(_ date: Date) -> [SavedExercise]{
		
		let calendar = Calendar.current
		
		//Get today's beginning & end
		let dateFrom = calendar.startOfDay(for: date)
		let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)

		// Set predicate as date being today's date
		//let fromPredicate = NSPredicate(format: "%@ >= %@", date as NSDate, dateFrom as NSDate)
		//let toPredicate = NSPredicate(format: "%@ < %@", date as NSDate, dateTo! as NSDate)
		//let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
		//fetchRequest.predicate = datePredicate
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedExercise")
		fetchRequest.predicate = NSPredicate(format: "date >= %@ && date <= %@",
											 dateFrom as CVarArg,
											 dateTo! as CVarArg)
		
		if let savedExercises = try? viewContext.fetch(fetchRequest) as? [SavedExercise],
		   !savedExercises.isEmpty{
			return savedExercises
		}
		
		return [SavedExercise]()
		
		
		//if(Storage.fileExists("Exercises.json", in: .documents)){
		//	let temp = Storage.retrieve("Exercises.json", from: .documents, as: [SavedExercise].self)
		//	return temp.filter { Calendar.current.isDate($0.date, inSameDayAs: date)}
		//}else{
		//	return [SavedExercise]()
		//}
	}
	
	/**
	 Добавляет упражнение в базу
	 - Parameter recipient:SavedExercise который будет добавлен в базу
	 */
	
//ExerciseID: exercisesFiltered[indexPath.row].ExerciseId, date: date, Weights: [], RepsNumber: []
	func addExerciseToDB(exerciseID: Int, date: Date, weights: [Int], repsNumber: [Int]){
		
		let exerciseToSave = SavedExercise(context: viewContext)
		//exerciseToSave = exercise
		//print(exerciseToSave)
		
		exerciseToSave.id = UUID()
		exerciseToSave.weights = weights
		exerciseToSave.date = date
		exerciseToSave.exerciseID = Int32(exerciseID)
		exerciseToSave.repsNumber = repsNumber
		do{
			try viewContext.save()
		} catch let error{
			print("Error in adding an exercise: \(error.localizedDescription)")
		}
		
		
		//var temp = [SavedExercise]()
		//if(Storage.fileExists("Exercises.json", in: .documents)){
		//temp = Storage.retrieve("Exercises.json", from: .documents, as: [SavedExercise].self)
		//}
		//temp.append(exercise)
		//Storage.store(temp, to: .documents, as: "Exercises.json")
		
		
	}
	
	/**
	 Изменяет существующую запись в базе данных по совпадению .id
	 - Parameter recipient: измененный SavedExercise
	 - Throws: `dbError.noEntryById(UUID)`
				Если в базе не было найдено записи по id
	 */
	func edit(_ exercise: SavedExercise) throws{
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedExercise")
		fetchRequest.predicate = NSPredicate(format: "id == %@", exercise.id as CVarArg)
		
		
		if let exercises = try? viewContext.fetch(fetchRequest) as? [SavedExercise] {
			
			guard let toEdit = exercises.first else {throw dbError.noEntryById(exercise.id)}
			
			
			toEdit.repsNumber = exercise.repsNumber
			toEdit.weights = exercise.weights
			
			do{
				try viewContext.save()
			} catch let error{
				print("Error in adding an exercise: \(error.localizedDescription)")
			}
		}
		
		
		
		//var temp = Storage.retrieve("Exercises.json", from: .documents, as: [SavedExercise].self)
		//guard let indexInDB = temp.firstIndex(where: {$0.id == exercise.id}) else {
		//	throw dbError.noEntryById(exercise.id)
		//}
		//
		//temp[indexInDB] = exercise
		//Storage.store(temp, to: .documents, as: "Exercises.json")
		
	}
	
	/**
	 удаляет существующую запись в базе данных по совпадению .id
	 - Parameter recipient: SavedExercise который нужно удалить, ищет по .id
	 - Throws: `dbError.noEntryById(UUID)`
				Если в базе не было найдено записи по id
	 */
	func remove(_ exercise: SavedExercise) throws{
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedExercise")
		fetchRequest.predicate = NSPredicate(format: "id == %@", exercise.id as CVarArg)
		
		if let exercises = try? viewContext.fetch(fetchRequest) as? [SavedExercise] {
			
			guard let toDelete = exercises.first else {throw dbError.noEntryById(exercise.id)}
			
			viewContext.delete(toDelete)
			
			do{
				try viewContext.save()
			} catch let error{
				print("Error in adding an exercise: \(error.localizedDescription)")
			}
		}
		
		
		
		
		
		//var temp = Storage.retrieve("Exercises.json", from: .documents, as: [SavedExercise].self)
		//guard let indexInDB = temp.firstIndex(where: {$0.id == exercise.id}) else {
		//	throw dbError.noEntryById(exercise.id)
		//}
		//temp.remove(at: indexInDB)
		//Storage.store(temp, to: .documents, as: "Exercises.json")
		
		
	}
	
	/**
	 Полностью очищает базу
	 */
	
	func clear(){
		Storage.clear(.documents)
	}
	
}


