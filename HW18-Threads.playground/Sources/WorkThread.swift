import PlaygroundSupport
import Foundation

public class WorkThread: Thread {
    var storage: ChipStorage

    public init(with storage: ChipStorage) {
        self.storage = storage
        super.init()
    }

    public override func main() {
        while self.storage.isProductionRunning ?? true || !self.storage.chips.isEmpty {
            if let chip = self.storage.getChip() {
                chip.sodering()
                print("Chip soldered")
            }
        }
        print("Work Thread exit")
    }
}
