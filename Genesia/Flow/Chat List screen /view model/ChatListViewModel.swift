//
//  ChatListViewModel.swift
//  Genesia
//
//  Created by Gehad Gamal on 02/10/2024.
//
import SwiftUI

final class ChatListViewModel:ObservableObject {
  @Published var aiModels:[AIModel] = []
  
  init() {
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func deleteAIModel(modelID:UUID) {
    InMemoryPersistance.deleteAIModel(modelID: modelID)
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func pinModel(modelID:UUID,pinned:Bool) {
    InMemoryPersistance.pinModel(modelID: modelID, pinned: pinned)
    aiModels = InMemoryPersistance.getAIModels()
  }
}
