//
//  ContentView.swift
//  Genie
//
//  Created by Tam Tran on 12/5/24.
//

import SwiftUI

// Main view controller that displays a grid of artwork images
struct ContentView: View {
    // Sample artwork data for the grid display
    private let artworks = ArtworkItem.sampleArtworks()
    
    // Fixed two-column grid layout
    private let gridItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    // State variables to manage the detail view presentation
    @State private var selectedArtwork: ArtworkItem?
    @State private var isShowingDetail = false
    
    // Calculate image width based on screen width
    private func calculateImageWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 16 * 3 // Left + Right + Middle spacing
        return (screenWidth - padding) / 2
    }
    
    var body: some View {
        let imageWidth = calculateImageWidth()
        let imageHeight = imageWidth * 0.67 // Landscape aspect ratio (2:3)
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(artworks) { artwork in
                        VStack(spacing: 8) {
                            AsyncImage(url: artwork.imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: imageWidth, height: imageHeight)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: imageWidth, height: imageHeight)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: imageWidth, height: imageHeight)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .shadow(radius: 4)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                print("DEBUG: Tapped on \(artwork.title)")
                                selectedArtwork = artwork
                                isShowingDetail = true
                            }
                            
                            Text(artwork.title)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Gallery")
        }
        .overlay {
            if isShowingDetail, let selectedArtwork = selectedArtwork {
                ArtworkDetailView(
                    artwork: selectedArtwork,
                    isPresented: $isShowingDetail
                )
                .transition(.opacity)
            }
        }
    }
}

#Preview {
    ContentView()
}
