//
//  ViewController.swift
//  Axie Win Counter
//
//  Created by Ke'an Martin Consolacion on 7/28/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var winCounterLabel: UILabel!
    @IBOutlet weak var loseCounterLabel: UILabel!
    @IBOutlet weak var winStepper: UIStepper!
    @IBOutlet weak var loseStepper: UIStepper!
    @IBOutlet weak var energyLabel: UILabel!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func winStepperChanged(_ sender: UIStepper) {
        winCounterLabel.text = String(Int(winStepper.value))
        updateEnergy()
    }
    
    @IBAction func loseStepperChanged(_ sender: Any) {
        loseCounterLabel.text = String(Int(loseStepper.value))
        updateEnergy()
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        winStepper.value = 0
        loseStepper.value = 0
        winCounterLabel.text = String(Int(winStepper.value))
        loseCounterLabel.text = String(Int(loseStepper.value))
        energyLabel.text = "Energy: 20/20"
        playSound()
    }
    
    private func updateEnergy(){
        energyLabel.text = "Energy: \(20 - (Int(winStepper.value) + Int(loseStepper.value)))/20"
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ring", withExtension: "wav") else {
            print("file not found")
            return
        }
        do {
            print("")
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

