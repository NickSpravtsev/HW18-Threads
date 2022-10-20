import PlaygroundSupport
import Foundation

public class ChipStorage {
    let storageQueue = DispatchQueue(label: "Storage queue", attributes: .concurrent)
    var chips = [Chip]()

    public init() {}

    func addToStorage(chip: Chip) {
        storageQueue.async(flags: .barrier) {
            self.chips.append(chip)
            print("Chip added into storage")
        }
    }

    func getChip() -> Chip? {
        guard chips.count > 0 else { return nil }

        var chip: Chip?
        storageQueue.async(flags: .barrier) {
            chip = self.chips.remove(at: self.chips.count - 1)
        }
        print("Chip given for soldering from storage")
        return chip
    }
}
