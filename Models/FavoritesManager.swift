import SwiftUI
import Observation

/// Manages the state of favorited wallpapers throughout the app
/// Uses the new Observation framework for reactive updates
@Observable final class FavoritesManager {
    /// Set of artwork IDs that have been marked as favorites
    /// Using a Set for O(1) lookup performance
    private(set) var favoriteIds: Set<String> = []
    
    /// Toggles the favorite state of an artwork
    /// - Parameter id: The unique identifier of the artwork
    func toggleFavorite(id: String) {
        if favoriteIds.contains(id) {
            favoriteIds.remove(id)
        } else {
            favoriteIds.insert(id)
        }
    }
    
    /// Checks if an artwork is marked as favorite
    /// - Parameter id: The unique identifier of the artwork
    /// - Returns: True if the artwork is favorited
    func isFavorite(id: String) -> Bool {
        favoriteIds.contains(id)
    }
} 