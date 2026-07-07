import Foundation

struct SummitBookEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var elevation: String
    var difficulty: String
    var notes: String = ""
}
