//
//  ViewController.swift
//  Mega.Quiz.Game
//
//  Created by User on 2/9/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelFeedback: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Actions

    @IBAction func pressedButtonA(sender: AnyObject) {
    }

    @IBAction func pressedButtonB(sender: UIButton) {
    }
    
    @IBAction func presedButtonC(sender: AnyObject) {
    }
    
    @IBAction func pressedButtonD(sender: AnyObject) {
    }
    
    @IBAction func pressedButtonNext(sender: AnyObject) {
    }
}

