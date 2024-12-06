import Foundation

struct ArtworkItem: Identifiable {
    let id = UUID()
    let imageUrl: URL
    let title: String
    
    static func sampleArtworks() -> [ArtworkItem] {
        [
            // Nature Category
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?auto=format&fit=crop&w=1000&q=80")!,
                title: "Snowy Peaks"
            ),
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=80")!,
                title: "Tropical Paradise"
            ),
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1511497584788-876760111969?auto=format&fit=crop&w=1000&q=80")!,
                title: "Misty Forest"
            ),
            
            // Abstract Category
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1567095761054-7a02e69e5c43?auto=format&fit=crop&w=1000&q=80")!,
                title: "Colorful Smoke"
            ),
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1550537687-c91072c4792d?auto=format&fit=crop&w=1000&q=80")!,
                title: "Wave Patterns"
            ),
            
            // Architecture
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1545569341-9eb8b30979d9?auto=format&fit=crop&w=1000&q=80")!,
                title: "Ancient Temple"
            ),
            ArtworkItem(
                imageUrl: URL(string: "https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=1000&q=80")!,
                title: "City Lights"
            )
        ]
    }

    static func verifyUrls() {
        let artworks = sampleArtworks()
        for artwork in artworks {
            URLSession.shared.dataTask(with: artwork.imageUrl) { data, response, error in
                if let error = error {
                    print("DEBUG: Error loading \(artwork.title): \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse {
                    print("DEBUG: Status code for \(artwork.title): \(httpResponse.statusCode)")
                }
            }.resume()
        }
    }
} 