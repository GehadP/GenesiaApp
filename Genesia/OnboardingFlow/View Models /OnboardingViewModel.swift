//
//  OnboardingViewModel.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import Foundation

final class OnboardingViewModel:ObservableObject {
  var userChoices = UserDataCollection()
  let avatars = ["onboading1", "onboading2", "onboading3"]
  
  func setUserInterests(interests:[String]) {
      userChoices.interests = interests
  }
  
  func saveAIModel() {
    let aiModel = AIModel()
    aiModel.aiAge = userChoices.aiAge
    aiModel.aiName = userChoices.aiName
    aiModel.aiGender = userChoices.aiGender
    aiModel.selectedAvatar = userChoices.selectedAvatar
    InMemoryPersistance.saveModel(model: aiModel)
  }

}

final class UserDataCollection:ObservableObject {
  var username:String = ""
  var userPronouns:String = "He/Him"
  var dateOfBirth:Date = .now
  var interests:[String] = []
  var selectedAvatar:String?
  var aiName:String = ""
  var aiGender:String = "Female"
  var aiAge:Int = 18
  
  func getAIModel() -> AIModel {
    let model = AIModel()
    model.aiAge = aiAge
    model.aiName = aiName
    model.selectedAvatar = selectedAvatar
    model.aiGender = aiGender
    return model
  }
}


final class AIModel:Identifiable,Hashable,ObservableObject{
  static func == (lhs: AIModel, rhs: AIModel) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  let id:UUID = UUID()
  var aiName:String = ""
  var aiGender:String = "Female"
  var aiAge:Int = 18
  var selectedAvatar:String?
  @Published var isChatPinned = false
}




final class InMemoryPersistance {
  
  static private var aiModels:[AIModel] = []
  
  static func saveModel(model: AIModel) {
    aiModels.append(model)
  }
  
  static func getAIModels() -> [AIModel] {
    return aiModels
  }
  
  static func clearData() {
    aiModels = []
  }
  
  static func deleteAIModel(modelID:UUID) {
    aiModels.removeAll {$0.id == modelID}
  }
  
  static func pinModel(modelID:UUID,pinned:Bool) {
    aiModels = aiModels.map{ model in
      let newModel = model
      newModel.isChatPinned = false
      return newModel
    }
    aiModels.filter {$0.id == modelID}.first?.isChatPinned = pinned
    guard let isChatPinnedItem = (aiModels.first { $0.isChatPinned }) else { return }
    deleteAIModel(modelID: isChatPinnedItem.id)
    aiModels.insert(isChatPinnedItem, at: 0)
  }
}


final class LandingFlowViewModel:ObservableObject {
  var userChoices = UserDataCollection()
  let avatars = ["person1", "person2", "person3","inboading1"]
  func setUserInterests(interests:[String]) {
      userChoices.interests = interests
  }
  func saveAIModel() {
    let aiModel = AIModel()
    aiModel.aiAge = userChoices.aiAge
    aiModel.aiName = userChoices.aiName
    aiModel.aiGender = userChoices.aiGender
    aiModel.selectedAvatar = userChoices.selectedAvatar
    InMemoryPersistance.saveModel(model: aiModel)
  }
    func clear() {
        self.userChoices = UserDataCollection()
        InMemoryPersistance.clearData()
    }
}
