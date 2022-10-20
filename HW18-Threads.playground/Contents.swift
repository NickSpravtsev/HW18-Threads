import PlaygroundSupport
import Foundation

let storage = ChipStorage()
let generationThread = GeneratingThread(with: storage)
let workThread = WorkThread(with: storage, and: generationThread)
generationThread.start()
workThread.start()
