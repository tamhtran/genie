import SwiftUI

/// Manages in-memory caching of remote images using NSCache
final class ImageCache {
    static let shared = ImageCache()
    
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100 // Maximum number of images to cache
        return cache
    }()
    
    private init() {}
    
    func insert(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    func get(_ url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
} 