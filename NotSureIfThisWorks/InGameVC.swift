//
//  InGameVC.swift
//  NotSureIfThisWorks
//
//  Created by Philippe Rivard on 1/27/16.
//  Copyright © 2016 Philippe Rivard. All rights reserved.
//

import UIKit

class InGameVC: UIViewController {
    
    @IBOutlet weak var meLabel: UILabel!
    
    @IBOutlet weak var opponentLabel: UILabel!

    @IBOutlet weak var aButton: UIButton!
    
    @IBOutlet weak var bButton: UIButton!
    
    @IBOutlet weak var cButton: UIButton!
    
    @IBOutlet weak var dButton: UIButton!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var myScoreLabel: UILabel!
    
    @IBOutlet weak var outcomeLabel: UILabel!
    
    
    @IBOutlet weak var opponentScoreLabel: UILabel!
    var questionArray = [Question]()
    var myScore = 0
    var numberOfQuestions = 0
    var rand: Int?
    var isHost: Bool?
    var hostName: String?
    
    weak var timer: NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        parseQuestionsCSV()
        DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inQueue").setValue(true)
        aButton.hidden = true
        bButton.hidden = true
        cButton.hidden = true
        dButton.hidden = true
        questionTextView.hidden = true
        myScoreLabel.hidden = true
        opponentScoreLabel.hidden = true
        meLabel.hidden = true
        opponentLabel.hidden = true
        outcomeLabel.hidden = true
        
        if isHost == true {
            DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(hostName).childByAppendingPath("opponent").observeEventType(.Value, withBlock: { snapshot in
                if snapshot.value as? String != "" {
                    self.playGame()
                }
            })
        }
        else {
            playGame()
        }
        
        
        
        if DataService.ds.REF_BASE.authData.uid == "63f1400f-5d06-4fa5-9074-af4067b88a39" {
            
            //display my score
            DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").observeEventType(.Value, withBlock: { snapshot in
                print(snapshot.value as? String)
                self.myScoreLabel.text = snapshot.value as? String
                
            })
            //display opponent score
            DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inGame").childByAppendingPath("myScore").observeEventType(.Value, withBlock: { snapshot in
                self.opponentScoreLabel.text = snapshot.value as? String
                
            })
            
            DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inQueue").observeEventType(.Value, withBlock: { snapshot in
                if snapshot.value as? Bool == true {
                    self.playGame()
                  
                }
                
            })
        }
        else {
            
            //display my score
            DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").observeEventType(.Value, withBlock: { snapshot in
                self.myScoreLabel.text = snapshot.value as? String
                print(snapshot.value as? String)
                
            })
            //display opponent score
            DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inGame").childByAppendingPath("myScore").observeEventType(.Value, withBlock: { snapshot in
                self.opponentScoreLabel.text = snapshot.value as? String
                print(snapshot.value as? String)
            })
            
            DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inQueue").observeEventType(.Value, withBlock: { snapshot in
                if snapshot.value as? Bool == false {
                    self.playGame()
                    print("queer")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayQuestion() {
        rand = Int(arc4random_uniform(UInt32(questionArray.count)))
        if numberOfQuestions == 3 {
            endGame()
            print("fag")
            timer?.invalidate()
        }
        enableButtons()
        numberOfQuestions += 1
        print(numberOfQuestions)
        
        questionTextView.text = questionArray[rand!].question
        if questionArray[rand!].answerA.hasPrefix("!") {
            aButton.setTitle(String(questionArray[rand!].answerA.characters.dropFirst()), forState: .Normal)
            
        }
        else {
            aButton.setTitle(questionArray[rand!].answerA, forState: .Normal)
        }
        
        if questionArray[rand!].answerB.hasPrefix("!") {
            bButton.setTitle(String(questionArray[rand!].answerB.characters.dropFirst()), forState: .Normal)
        }
        else {
            bButton.setTitle(questionArray[rand!].answerB, forState: .Normal)
        }
        
        if questionArray[rand!].answerC.hasPrefix("!") {
            cButton.setTitle(String(questionArray[rand!].answerC.characters.dropFirst()), forState: .Normal)
        }
        else {
            cButton.setTitle(questionArray[rand!].answerC, forState: .Normal)
        }
        
        if questionArray[rand!].answerD.hasPrefix("!") {
            dButton.setTitle(String(questionArray[rand!].answerD.characters.dropFirst()), forState: .Normal)
        }
        else {
            dButton.setTitle(questionArray[rand!].answerD, forState: .Normal)
        }
        
    }
    
    func playGame() {
        
        
        displayQuestion()
        aButton.hidden = false
        bButton.hidden = false
        cButton.hidden = false
        dButton.hidden = false
        questionTextView.hidden = false
        myScoreLabel.hidden = false
        opponentScoreLabel.hidden = false
        meLabel.hidden = false
        opponentLabel.hidden = false

        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "displayQuestion", userInfo: nil, repeats: true)
        
        
    }
    func parseQuestionsCSV() {
        let path = NSBundle.mainBundle().pathForResource("QuestionList", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let question = row["question"]!
                let answerA = row["answerA"]!
                let answerB = row["answerB"]!
                let answerC = row["answerC"]!
                let answerD = row["answerD"]!
                let questionFinished = Question(question: question, answerA: answerA, answerB: answerB, answerC: answerC, answerD: answerD)
                questionArray.append(questionFinished)
            }
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func onAButtonPressed(sender: AnyObject) {
        disableButtons()
        if DataService.ds.REF_BASE.authData.uid == "63f1400f-5d06-4fa5-9074-af4067b88a39" {
            if questionArray[rand!].answerA.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
            }
        }
        else {
            if questionArray[rand!].answerA.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
                
            }
        }
    }
    
    @IBAction func onBButtonPressed(sender: AnyObject) {
        disableButtons()
        if DataService.ds.REF_BASE.authData.uid == "63f1400f-5d06-4fa5-9074-af4067b88a39" {
            if questionArray[rand!].answerB.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
            }
        }
        else {
            if questionArray[rand!].answerB.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
                
            }
        }
    }
    
    @IBAction func onCButtonPressed(sender: AnyObject) {
        disableButtons()
        if DataService.ds.REF_BASE.authData.uid == "63f1400f-5d06-4fa5-9074-af4067b88a39" {
            if questionArray[rand!].answerC.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
            }
        }
        else {
            if questionArray[rand!].answerC.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
                
            }
        }
    }
    
    @IBAction func onDButtonPressed(sender: AnyObject) {
        disableButtons()
        if DataService.ds.REF_BASE.authData.uid == "63f1400f-5d06-4fa5-9074-af4067b88a39" {
            if questionArray[rand!].answerD.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("7524bac2-2247-4f6d-8361-fab1dbd622e4").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
            }
        }
        else {
            if questionArray[rand!].answerD.hasPrefix("!") {
                myScore += 1
                DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").setValue(String(myScore))
                DataService.ds.REF_USERS.childByAppendingPath("63f1400f-5d06-4fa5-9074-af4067b88a39").childByAppendingPath("inGame").childByAppendingPath("opponentScore").setValue(String(myScore))
                
            }
        }
    }
    
    func disableButtons() {
        aButton.enabled = false
        bButton.enabled = false
        cButton.enabled = false
        dButton.enabled = false
    }
    
    func enableButtons() {
        aButton.enabled = true
        bButton.enabled = true
        cButton.enabled = true
        dButton.enabled = true
    }
    
    func endGame() {
        var myScore: Int?
        var opponentScore: Int?
        
        aButton.hidden = true
        bButton.hidden = true
        cButton.hidden = true
        dButton.hidden = true
        questionTextView.hidden = true
        myScoreLabel.hidden = true
        opponentScoreLabel.hidden = true
        meLabel.hidden = true
        opponentLabel.hidden = true
        outcomeLabel.hidden = false
        
       // DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("myScore").observeEventType(.Value, withBlock: { snapshot in
           // myScore = snapshot.value as! Int
            
        //})
        //DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("inGame").childByAppendingPath("opponentScore").observeEventType(.Value, withBlock: { snapshot in
          //  opponentScore = snapshot.value as! Int
            
       // })
        
        //if myScore > opponentScore {
           // DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("wins").setValue("1")
           // outcomeLabel.text = "You Won!"
        //}
        /*else if myScore < opponentScore {
            DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("losses").setValue("1")
            outcomeLabel.text = "Loser!"
        }
        
        else {
            outcomeLabel.text = "Tie!"
        }
        
        numberOfQuestions = 0*/
    }
    
    
    
}
