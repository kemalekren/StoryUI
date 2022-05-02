//
//  StoryView.swift
//  StoryUI (iOS)
//
//  Created by Tolga İskender on 28.04.2022.
//

import SwiftUI

public struct StoryView: View {
    @StateObject private var storyData = StoryViewModel()
    
    @Binding private var isPresented: Bool
    
    private var stories: [StoryUIModel]
    private var selectedIndex: Int
    
    /// Stories and isPresented requeired, selectedIndex is optional default: 0
    /// - Parameters:
    ///   - stories: all stories to show
    ///   - selectedIndex: current story index selected by user
    ///   - isPresented: to hide and show for closing storyView
    public init(stories: [StoryUIModel], selectedIndex: Int = 0, isPresented: Binding<Bool>) {
        self.stories = stories
        self.selectedIndex = selectedIndex
        self._isPresented = isPresented
    }
    
    public var body: some View {
        if isPresented {
            TabView(selection: $storyData.currentStoryUser) {
                ForEach($storyData.stories) { $model in
                    StoryDetailView(model: $model,
                                    isPresented: $isPresented)
                    .environmentObject(storyData)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .onAppear() {
                startStory()
            }
        }
    }
    
    private func startStory() {
        storyData.stories = stories
        storyData.stories[selectedIndex].isSeen = true
        storyData.currentStoryUser = stories[selectedIndex].id
    }
}

