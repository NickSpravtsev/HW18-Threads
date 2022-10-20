import PlaygroundSupport
import Foundation

public class GeneratingThread: Thread {
    let timePeriod = 2
    let generatingPeriod = 20
    var storage: ChipStorage

    public init(with storage: ChipStorage) {
        self.storage = storage
        super.init()
    }

    public override func main() {
        var limiter = 0

        Timer.scheduledTimer(withTimeInterval: TimeInterval(timePeriod), repeats: true) { timer in
            let chip = Chip.make()
            print("Chip made")
            self.storage.addToStorage(chip: chip)
            limiter += Int(timer.timeInterval)

            if limiter >= self.generatingPeriod {
                timer.invalidate()
            }
        }
        RunLoop.current.run()
        print("Generating Thread exit")
    }
}
