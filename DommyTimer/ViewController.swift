//
//  ViewController.swift
//  DommyTimer
//
//  Created by 御堂 大嗣 on 2018/12/18.
//  Copyright © 2018 御堂 大嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let timeInterval = 0.01
    let timeFormat = ".02f"
    let strStart = "Start"
    let strStop = "Stop"
    let strReset = "Reset"
    let strLap = "Lap"
    let defaultTime = "00:00:00.00"
    
    var timer = Timer()
    var counter = 0.00
    var isPlaying = false
    var displayingLap = false
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetLapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.textColor = UIColor.orange
    }

    @IBAction func startStopButton(_ sender: UIButton) {
        if !isPlaying {
            start()
        } else {
            stop()
        }
    }
    
    @IBAction func resetLapButton(_ sender: Any) {
        if isPlaying || displayingLap{
            lap()
        } else {
            reset()
        }
    }
    
    func start(){
        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(ViewController.updateCounter),
            userInfo: nil,
            repeats: true
        )
        isPlaying = true
        startStopButton.setTitle(strStop, for: .normal)
        resetLapButton.setTitle(strLap, for: .normal)
    }
    
    func stop(){
        timer.invalidate()
        isPlaying = false
        startStopButton.setTitle(strStart, for: .normal)
        if !displayingLap {
            resetLapButton.setTitle(strReset, for: .normal)
        }
    }
    
    func lap(){
        displayingLap = true
        updateTimer()
        if !isPlaying {
            resetLapButton.setTitle(strReset, for: .normal)
            displayingLap = false
        }
    }
    
    func reset(){
        counter = 0
        updateTimer()
    }
    
    @objc func updateCounter(){
        counter += timeInterval
        if !displayingLap {
            updateTimer()
        }
    }
    
    func updateTimer(){
        let intSeconds = Int(counter)
        let seconds = intSeconds % 60
        let minutes = intSeconds / 60 % 60
        let hours = minutes / 60 / 60
        let strTime = String(format: "%02d", hours) + ":"
            + String(format: "%02d", minutes) + ":"
            + String(format: "%05.2f", counter - Double(intSeconds) + Double(seconds))
        timerLabel.text = strTime
    }
}

