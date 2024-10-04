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
  
}
