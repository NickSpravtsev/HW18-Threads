import PlaygroundSupport
import Foundation

public class ChipStorage {
    var isProductionRunning: Bool?
    let storageQueue = DispatchQueue(label: "Storage queue", attributes: .concurrent)
    var chips = [Chip]()

    public init() {}

    func addToStorage(chip: Chip) {
        storageQueue.async(flags: .barrier) {
            self.chips.append(chip)
        }
    }

    func getChip() -> Chip? {
        guard chips.count > 0 else { return nil }

        var chip: Chip?
        storageQueue.sync(flags: .barrier) {
            chip = self.chips.remove(at: self.chips.count - 1)
        }

        return chip
    }
}
