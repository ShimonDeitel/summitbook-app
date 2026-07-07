import XCTest
@testable import SummitBook

@MainActor
final class SummitBookTests: XCTestCase {

    func testSeedDataBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.entries.count, Store.freeLimit)
    }

    func testAddEntryIncreasesCount() {
        let store = Store()
        let before = store.entries.count
        store.add(SummitBookEntry(title: "Test", date: Date(), elevation: "a", difficulty: "b"))
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testDeleteEntryDecreasesCount() {
        let store = Store()
        let entry = SummitBookEntry(title: "ToDelete", date: Date(), elevation: "a", difficulty: "b")
        store.add(entry)
        let before = store.entries.count
        store.delete(entry)
        XCTAssertEqual(store.entries.count, before - 1)
    }

    func testUpdateEntryModifiesExisting() {
        let store = Store()
        let entry = SummitBookEntry(title: "Original", date: Date(), elevation: "a", difficulty: "b")
        store.add(entry)
        var updated = entry
        updated.title = "Updated"
        store.update(updated)
        XCTAssertEqual(store.entries.first(where: { $0.id == entry.id })?.title, "Updated")
    }

    func testCanAddWhenUnderLimitAndFree() {
        let store = Store()
        store.entries = Array(repeating: SummitBookEntry(title: "x", date: Date(), elevation: "", difficulty: ""), count: Store.freeLimit - 1)
        XCTAssertTrue(store.canAdd(isPro: false))
    }

    func testCannotAddWhenAtLimitAndFree() {
        let store = Store()
        store.entries = Array(repeating: SummitBookEntry(title: "x", date: Date(), elevation: "", difficulty: ""), count: Store.freeLimit)
        XCTAssertFalse(store.canAdd(isPro: false))
    }

    func testCanAlwaysAddWhenPro() {
        let store = Store()
        store.entries = Array(repeating: SummitBookEntry(title: "x", date: Date(), elevation: "", difficulty: ""), count: Store.freeLimit + 5)
        XCTAssertTrue(store.canAdd(isPro: true))
    }

    func testIsAtFreeLimit() {
        let store = Store()
        store.entries = Array(repeating: SummitBookEntry(title: "x", date: Date(), elevation: "", difficulty: ""), count: Store.freeLimit)
        XCTAssertTrue(store.isAtFreeLimit)
    }
}
