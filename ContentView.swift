//
//  ContentView.swift
//  Genie
//
//  Created by Tam Tran on 12/5/24.
//

import SwiftUI

/// Main view controller that manages the tab-based navigation
/// and coordinates between the wallpaper grid and detail views
struct ContentView: View {
    // State management
    private let artworks = ArtworkItem.sampleArtworks()
    @State private var favoritesManager = FavoritesManager()
    @State private var selectedArtwork: ArtworkItem?
    @State private var isShowingDetail = false
    
    var body: some View {
        TabView {
            // All wallpapers tab
            NavigationStack {
                WallpaperGridView(
                    artworks: artworks,
                    favoritesManager: favoritesManager,
                    onTapGesture: { artwork in
                        selectedArtwork = artwork
                        isShowingDetail = true
                    }
                )
                .navigationTitle("Wallpapers")
            }
            .tabItem {
                Label("All", systemImage: "photo.stack")
            }
            
            // Favorites tab
            NavigationStack {
                WallpaperGridView(
                    artworks: artworks.filter { favoritesManager.isFavorite(id: $0.id) },
                    favoritesManager: favoritesManager,
                    onTapGesture: { artwork in
                        selectedArtwork = artwork
                        isShowingDetail = true
                    }
                )
                .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
        // Modal presentation of artwork detail
        .sheet(isPresented: $isShowingDetail, content: {
            if let selectedArtwork = selectedArtwork {
                ArtworkDetailView(
                    artwork: selectedArtwork,
                    isPresented: $isShowingDetail
                )
            }
        })
    }
}

#Preview {
    ContentView()
}
