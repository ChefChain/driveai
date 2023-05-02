import Foundation

struct Car: Codable, Identifiable {
    let id: Int
    let make: String
    let model: String
    let year: Int
    let price: Double
    let imageUrl: String
}
