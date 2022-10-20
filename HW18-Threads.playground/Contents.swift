import PlaygroundSupport
import Foundation

let storage = ChipStorage()
let generationThread = GeneratingThread(with: storage)
let workThread = WorkThread(with: storage)
generationThread.start()
workThread.start()
