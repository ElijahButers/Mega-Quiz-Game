//
//  ViewController.swift
//  Mega.Quiz.Game
//
//  Created by User on 2/9/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import UIKit

// Shuffle method

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelFeedback: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    var allEntries: NSArray!
    var currentCorrectAnswerIndex: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadAllQuestionsAndAnswers()
        loadQuestion(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAllQuestionsAndAnswers() {
        
        let path = Bundle.main.path(forResource: "content", ofType: "json")
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        
        do {
            
            allEntries = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        } catch {
            print(allEntries)
        }
        print(allEntries)
    }
    
    func loadQuestion(_ index: Int) {
        
        let entry: NSDictionary = allEntries.object(at: index) as! NSDictionary
        let question: NSString = entry.object(forKey:"question") as! NSString
        let arr: NSMutableArray = entry.object(forKey:"answers") as! NSMutableArray
        
        print(question)
        print(arr)
        
        labelQuestion.text = question as String
        
        let indices: [Int] = [0, 1, 2, 3]
        let newSequence = indices.shuffled()
        
        for i in (0..<newSequence.count) {
            
            let index = newSequence[i]
            if (index == 0) {
                
                currentCorrectAnswerIndex = i
            }
            
            let answer = arr.object(at: index) as! NSString
            switch(i) {
                
            case 0:
                buttonA.setTitle(answer as String, for: UIControlState())
                break;
            case 1:
                buttonB.setTitle(answer as String, for: UIControlState())
                break;
            case 2:
                buttonC.setTitle(answer as String, for: UIControlState())
                break;
            case 3:
                buttonD.setTitle(answer as String, for: UIControlState())
                break;
            default:
                break;
            }
        }
        
        resetAnswerButtons()
    }
    
    // Check answer method
    
    func checkAnswer(_ answerNumber: Int) {
        
        if(answerNumber == currentCorrectAnswerIndex) {
            
            labelFeedback.text = "Correct!"
            labelFeedback.textColor = UIColor.green
            score = score + 1
        } else {
            labelFeedback.text = "Wrong Answer"
            labelFeedback.textColor = UIColor.red
        }
        
        buttonNext.isEnabled = true
        //buttonNext.isEnabled = false
    }
    
    // Reset answer buttons
    
    func resetAnswerButtons() {
        
        buttonA.alpha = 1.0
        buttonB.alpha = 1.0
        buttonC.alpha = 1.0
        buttonD.alpha = 1.0
        
        buttonA.isEnabled = true
        buttonB.isEnabled = true
        buttonC.isEnabled = true
        buttonD.isEnabled = true
    }
    
    // Actions

    @IBAction func pressedButtonA(_ sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonC.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.isEnabled = false
        buttonB.isEnabled = false
        buttonC.isEnabled = false
        buttonD.isEnabled = false
        
        checkAnswer(0)
    }

    @IBAction func pressedButtonB(_ sender: UIButton) {
        buttonA.alpha = 0.3
        buttonC.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.isEnabled = false
        buttonB.isEnabled = false
        buttonC.isEnabled = false
        buttonD.isEnabled = false
        
        checkAnswer(1)
    }
    
    @IBAction func presedButtonC(_ sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.isEnabled = false
        buttonB.isEnabled = false
        buttonC.isEnabled = false
        buttonD.isEnabled = false
        
        checkAnswer(2)
    }
    
    @IBAction func pressedButtonD(_ sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonC.alpha = 0.3
        
        buttonA.isEnabled = false
        buttonB.isEnabled = false
        buttonC.isEnabled = false
        buttonD.isEnabled = false
        
        checkAnswer(3)
    }
    
    @IBAction func pressedButtonNext(_ sender: AnyObject) {
        
        let randomNumber = Int(arc4random_uniform(UInt32(allEntries.count)))
        loadQuestion(randomNumber)
    }
}

