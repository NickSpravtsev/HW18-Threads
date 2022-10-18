import PlaygroundSupport
import Foundation

class ChipStorage {
    let storageQueue = DispatchQueue(label: "Storage queue", attributes: .concurrent)
    var chips = [Chip]()

    func addToStorage(chip: Chip) {
        storageQueue.async(flags: .barrier) {
            self.chips.append(chip)
        }
    }

    func getChip() -> Chip? {
        guard chips.count > 0 else { return nil }
        var chip: Chip?
        storageQueue.async(flags: .barrier) {
            chip = self.chips.remove(at: self.chips.count - 1)
        }
        return chip
    }
}

class GeneratingThread: Thread {
    let timePeriod = 2
    let generatingPeriod = 20
    var storage: ChipStorage

    override func main() {
        var limiter = 0

        Timer.scheduledTimer(withTimeInterval: TimeInterval(timePeriod), repeats: true) { timer in
            let chip = Chip.make()
            self.storage.addToStorage(chip: chip)

            limiter += Int(timer.timeInterval)
            if limiter >= self.generatingPeriod {
                timer.invalidate()
            }
        }
    }

    init(with storage: ChipStorage) {
        self.storage = storage
        super.init()
    }
}

class WorkThread: Thread {

}
