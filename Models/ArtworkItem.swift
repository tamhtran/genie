import Foundation

/// A model representing a wallpaper artwork that can be displayed and favorited
/// Supports both local and remote image sources
struct ArtworkItem: Identifiable {
    let id: String
    let source: ImageSource
    let title: String
    
    /// Defines the source of an artwork image
    /// - local: Images bundled with the app
    /// - remote: Images fetched from a URL
    enum ImageSource {
        case local(name: String)
        case remote(url: URL)
    }
    
    /// Provides sample artwork data for development and preview purposes
    /// Contains a mix of remote Unsplash images and local bundled images
    /// Categories: Nature, Abstract, Architecture, and Local wallpapers
    static func sampleArtworks() -> [ArtworkItem] {
        [
            // Nature Category - High-quality landscape photography
            ArtworkItem(
                id: "nature-1",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?auto=format&fit=crop&w=1000&q=80")!),
                title: "Snowy Peaks"
            ),
            ArtworkItem(
                id: "nature-2",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=80")!),
                title: "Tropical Paradise"
            ),
            ArtworkItem(
                id: "nature-3",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1511497584788-876760111969?auto=format&fit=crop&w=1000&q=80")!),
                title: "Misty Forest"
            ),
            
            // Abstract Category
            ArtworkItem(
                id: "abstract-1",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1567095761054-7a02e69e5c43?auto=format&fit=crop&w=1000&q=80")!),
                title: "Colorful Smoke"
            ),
            ArtworkItem(
                id: "abstract-2",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1550537687-c91072c4792d?auto=format&fit=crop&w=1000&q=80")!),
                title: "Wave Patterns"
            ),
            
            // Architecture
            ArtworkItem(
                id: "architecture-1",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1545569341-9eb8b30979d9?auto=format&fit=crop&w=1000&q=80")!),
                title: "Ancient Temple"
            ),
            ArtworkItem(
                id: "architecture-2",
                source: .remote(url: URL(string: "https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=1000&q=80")!),
                title: "City Lights"
            ),
            
            // Local wallpapers
            ArtworkItem(
                id: "local-1",
                source: .local(name: "wallpaper1"),
                title: "Wallpaper 1"
            ),
            ArtworkItem(
                id: "local-2",
                source: .local(name: "wallpaper2"),
                title: "Wallpaper 2"
            )
        ]
    }
} 