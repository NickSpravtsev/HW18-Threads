import Foundation

public class WorkThread: Thread {
    var storage: ChipStorage

    public init(with storage: ChipStorage, and generatingThread: GeneratingThread) {
        self.storage = storage
        super.init()
    }

    public override func main() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if !(self.storage.isProductionRunning ?? true) && self.storage.chips.isEmpty {
                timer.invalidate()
            }
            if let chip = self.storage.getChip() {
                chip.sodering()
                print("Chip soldered")
            }
        }
        RunLoop.current.run()
        print("Work Thread exit")
    }
}
