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
    
    var allEntries: NSArray!
    var currentCorrectAnswerIndex: Int = 0
    
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
        
        let path = NSBundle.mainBundle().pathForResource("content", ofType: "json")
        let jsonData: NSData = NSData(contentsOfFile: path!)!
        
        
        do {
            
            allEntries = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        } catch {
            print(allEntries)
        }
        print(allEntries)
    }
    
    func loadQuestion(index: Int) {
        
        let entry: NSDictionary = allEntries.objectAtIndex(index) as! NSDictionary
        let question: NSString = entry.objectForKey("question") as! NSString
        let arr: NSMutableArray = entry.objectForKey("answers") as! NSMutableArray
        
        print(question)
        print(arr)
        
        labelQuestion.text = question as String
        
        let indices: [Int] = [0, 1, 2, 3]
        let newSequence = shuffle(indices)
        var i: Int = 0
        for (i = 0; i < newSequence.count; i++) {
            
            let index = newSequence[i]
            if (index == 0) {
                
                currentCorrectAnswerIndex = i
            }
            
            let answer = arr.objectAtIndex(index) as! NSString
            switch(i) {
                
            case 0:
                buttonA.setTitle(answer as String, forState: .Normal)
                break;
            case 1:
                buttonB.setTitle(answer as String, forState: .Normal)
                break;
            case 2:
                buttonC.setTitle(answer as String, forState: .Normal)
                break;
            case 3:
                buttonD.setTitle(answer as String, forState: .Normal)
                break;
            default:
                break;
            }
        }
    }
    
    // Shuffle method
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        
        let count = list.count
        for i in 0..<(count - 1) {
            
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&list[i], &list[j])
        }
        
        return list
    }
    
    // Actions

    @IBAction func pressedButtonA(sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonC.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.enabled = false
        buttonB.enabled = false
        buttonC.enabled = false
        buttonD.enabled = false
    }

    @IBAction func pressedButtonB(sender: UIButton) {
        buttonA.alpha = 0.3
        buttonC.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.enabled = false
        buttonB.enabled = false
        buttonC.enabled = false
        buttonD.enabled = false
    }
    
    @IBAction func presedButtonC(sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonD.alpha = 0.3
        
        buttonA.enabled = false
        buttonB.enabled = false
        buttonC.enabled = false
        buttonD.enabled = false
    }
    
    @IBAction func pressedButtonD(sender: AnyObject) {
        buttonA.alpha = 0.3
        buttonB.alpha = 0.3
        buttonC.alpha = 0.3
        
        buttonA.enabled = false
        buttonB.enabled = false
        buttonC.enabled = false
        buttonD.enabled = false
    }
    
    @IBAction func pressedButtonNext(sender: AnyObject) {
    }
}

