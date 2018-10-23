//
//  ViewController.swift
//  Bullseye
//
//  Created by Kastel, Lynette on 8/31/17.
//  Copyright © 2017 LynetteKastel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        
        // Alter the slider control
        // Returns an optional, so force unwrap it (!)
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        
        // Access the set up slider and give it an image
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        // Set highlighted state
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        // Customize the colors of the slider using images (left/right of thumb)
        // 1. Add insets (a way to add spacing)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        // 2. Set up the left image to use. Then make it resizeable.
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage?.resizableImage(withCapInsets: insets)
        
        // 3. Attach the image to the slider 
        // Use the resizeable image of the track image to the left of the slider thumb for the normal state.
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        // 2. Set up the right image to use. Then make it resizeable.
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizeable = trackRightImage?.resizableImage(withCapInsets: insets)
        
        // 3. Attach the image to the slider
        // Use the resizeable image of the track image to the right of the slider thumb for the normal state.
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)

    }


    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lroundf(sender.value)    // Slider values are floats.  We need an integer.
    }
    
    @IBAction func showAlert(_ sender: AnyObject) {
        //print("The value of the slider currently is: \(currentValue)\nThe target value is: \(targetValue)")
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good guess"
        } else {
            title = "Not even close..."
        }
        
        let message = "The value of the slider is: \(currentValue)\nThe target value is \(targetValue)\nYou scored \(points) points"
        
        score += points
        
        // 1. Create an alert controller (4 steps, 2 classes)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 2. Set up an alert action
        
        // NOTE: The handler param in the UIAlertAction below is replaced by a trailing closure (code block)
        //       in which we call startNewRound() & updateLabels()
        //   By referencing the VC (self) in the closure, we're creating a retain cycle (memory leak).
        //   To deal with this, pass in a capture list [weak self] to capture self (VC) and make it
        //   a weak reference (vs strong). This also means that self, since it is now weak, will become an
        //   optional (use ?'s with self in the closure).
        let actionItem = UIAlertAction(title: "OK", style: .default) { [weak self]
            action in
            
            self?.startNewRound()
            self?.updateLabels()
        }
        
        // 3. Add the action to the alert
        alertController.addAction(actionItem)
        
        // 4. Present the alert
        present(alertController, animated: true, completion: nil)
        
        //startNewRound()
        //updateLabels()
    }
  
    func startNewGame() {
        // Reset the score and round
        score = 0
        round = 0
        
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        
        // Set up a new target value making it random
        targetValue = Int(arc4random_uniform(100)) + 1
        
        // Reset current value and slider
        currentValue = 50
        slider.value = Float(currentValue)     // cannot assign an int to a float
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

