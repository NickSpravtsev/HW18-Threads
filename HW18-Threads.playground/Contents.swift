import Foundation

class GeneratingThread: Thread {
    let timePeriod = 2
    let generatingPeriod = 20

    override func main() {
        var limiter = 0

        Timer.scheduledTimer(withTimeInterval: TimeInterval(timePeriod), repeats: true) { timer in
            let chip = Chip.make()
            // add chip to the storage
            limiter += Int(timer.timeInterval)

            if limiter >= self.generatingPeriod {
                timer.invalidate()
            }
        }
    }
}

class WorkThread: Thread {

}
