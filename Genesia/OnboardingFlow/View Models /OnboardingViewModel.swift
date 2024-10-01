//
//  OnboardingViewModel.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import Foundation

final class OnboardingViewModel:ObservableObject {
  var userChoices = UserDataCollection()
  var interests = InterestsModel.getTags()
  let avatars = ["onboading1", "onboading2", "onboading3"]
  var aiPersonalities = AIPersonalityModel.getPersonalities()
  
  func setUserInterests(interests:[String]) {
      userChoices.interests = interests
  }
  
  func saveAIModel() {
    let aiModel = AIModel()
    aiModel.aiAge = userChoices.aiAge
    aiModel.aiName = userChoices.aiName
    aiModel.aiGender = userChoices.aiGender
    aiModel.selectedAvatar = userChoices.selectedAvatar
    aiModel.selectedPersonality = userChoices.selectedPersonality
    InMemoryPersistance.saveModel(model: aiModel)
  }
  
  func clear() {
      self.userChoices = UserDataCollection()
      self.interests = InterestsModel.getTags()
      InMemoryPersistance.clearData()
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
  @Published var selectedPersonality:String = AIPersonalityModel.getPersonalities().first ?? ""
  
  func getAIModel() -> AIModel {
    let model = AIModel()
    model.aiAge = aiAge
    model.aiName = aiName
    model.selectedAvatar = selectedAvatar
    model.aiGender = aiGender
    model.selectedPersonality = selectedPersonality
    return model
  }
}

final class InterestsModel:Codable {
  var title:String = ""
  var isSelected:Bool = false
  
  init(title: String, isSelected: Bool = false ) {
    self.title = title
    self.isSelected = isSelected
  }
  
  static func getTags() -> [InterestsModel] {
    [InterestsModel(title: "🎨 Art and Creativity"),
            .init(title: "📚 Literature")
            ,.init(title: "🎥 Movies and TV Shows"),
            .init(title: "💃🏻 Dancing")
            ,.init(title: "🐶 Pets and Animals"),
            .init(title: "🌱 Gardening"),
            .init(title: "🌍 Volunteering"),
            .init(title: "💻 Technology"),
            .init(title: "👗 Fashion"),
            .init(title: "✈️ Travel"),
            .init(title: "🎵 Music"),
            .init(title: "⚽️ Sports"),
            .init(title: "🎮 Gaming"),
            .init(title: "💼 Career"),
            .init(title: "🍳 Cooking"),
            .init(title: "💪 Fitness"),
            .init(title: "☕️ Coffee"),
            .init(title: "💭 Philosophy/Existential questions"),
            .init(title: "🎭 Theater and Performing Arts"),
            .init(title: "🌍Environmental Sustainability")]
  }
}


struct AIPersonalityModel {
  static func getPersonalities() -> [String] {
    return ["😉\nFlirty & Relaxed",
            "😏\nFlirty & Toxic",
            "😜\nFlirty & Funny",
            "🥰\nRomantic & Positive",
            "😎\nDominant & Confident",
            "🤗\nShy & Supportive",
            "🤩\nFunny & Creative",
            "🤓\nFunny & Nerd"
    ]
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
  var selectedPersonality:String = AIPersonalityModel.getPersonalities().first ?? ""
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
  var interests = InterestsModel.getTags()
  let avatars = ["person1", "person2", "person3","inboading1"]
  var aiPersonalities = AIPersonalityModel.getPersonalities()
  
  func setUserInterests(interests:[String]) {
      userChoices.interests = interests
  }
  
  func saveAIModel() {
    let aiModel = AIModel()
    aiModel.aiAge = userChoices.aiAge
    aiModel.aiName = userChoices.aiName
    aiModel.aiGender = userChoices.aiGender
    aiModel.selectedAvatar = userChoices.selectedAvatar
    aiModel.selectedPersonality = userChoices.selectedPersonality
    InMemoryPersistance.saveModel(model: aiModel)
  }
  
  func clear() {
      self.userChoices = UserDataCollection()
      self.interests = InterestsModel.getTags()
      InMemoryPersistance.clearData()
  }
}
