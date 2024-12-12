import SwiftUI

/// Displays a grid of wallpaper artworks with favorite functionality
/// Supports both local and remote images with loading states
struct WallpaperGridView: View {
    let artworks: [ArtworkItem]
    let favoritesManager: FavoritesManager
    /// Optional callback for handling single tap on artwork
    var onTapGesture: ((ArtworkItem) -> Void)? = nil
    
    /// Grid layout configuration for two-column display
    private let gridItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    /// Calculates the width for each grid item based on screen size
    /// Accounts for padding and spacing between items
    private func calculateImageWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 16 * 3 // Left + Right + Middle spacing
        return (screenWidth - padding) / 2
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 16) {
                ForEach(artworks) { artwork in
                    Group {
                        switch artwork.source {
                        case .local(let name):
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .remote(let url):
                            CachedAsyncImage(url: url)
                        }
                    }
                    .frame(width: calculateImageWidth(), 
                           height: calculateImageWidth() * 0.67)
                    .clipped()
                    .cornerRadius(8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onTapGesture?(artwork)
                    }
                    .onTapGesture(count: 2) {
                        favoritesManager.toggleFavorite(id: artwork.id)
                    }
                    .overlay(alignment: .topTrailing) {
                        if favoritesManager.isFavorite(id: artwork.id) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(8)
                        }
                    }
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    WallpaperGridView(
        artworks: ArtworkItem.sampleArtworks(),
        favoritesManager: FavoritesManager()
    )
} 
