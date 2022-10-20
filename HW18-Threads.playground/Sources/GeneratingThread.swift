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
        storage.isProductionRunning = true
        var limiter = 0
        var chipNumber = 1

        Timer.scheduledTimer(withTimeInterval: TimeInterval(timePeriod), repeats: true) { timer in
            let chip = Chip.make()
            print("Chip №\(chipNumber) made")
            self.storage.addToStorage(chip: chip)
            limiter += Int(timer.timeInterval)
            chipNumber += 1

            if limiter >= self.generatingPeriod {
                timer.invalidate()
            }
        }
        RunLoop.current.run()
        storage.isProductionRunning = false
        print("Generating Thread exit")
    }
}
