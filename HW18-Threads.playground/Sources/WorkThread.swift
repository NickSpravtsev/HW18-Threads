import PlaygroundSupport
import Foundation

public class WorkThread: Thread {
    var storage: ChipStorage
    var generatingThread: GeneratingThread

    public init(with storage: ChipStorage, and generatingThread: GeneratingThread) {
        self.storage = storage
        self.generatingThread = generatingThread
        super.init()
    }

    public override func main() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.generatingThread.isFinished && self.storage.chips.isEmpty {
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
