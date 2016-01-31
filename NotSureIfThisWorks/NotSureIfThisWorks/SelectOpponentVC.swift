//
//  SelectOpponentVC.swift
//  NotSureIfThisWorks
//
//  Created by Oli Eydt on 2016-01-18.
//  Copyright © 2016 Philippe Rivard. All rights reserved.
//
import UIKit
import Foundation
class SelectOpponentVC: UIViewController {
    
    @IBOutlet var player1Btn: UIButton!
    
    @IBOutlet weak var player1OnlineImg: UIImageView!
    
    @IBOutlet weak var mailImg: UIImageView!
    
    var player2: String?
    var tempBool: Bool = true
    weak var timer : NSTimer?
    weak var constantTimer: NSTimer?
    var isHost: Bool?
    var hostName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("online").setValue(true)
        
       // DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("newMessage").observeEventType(.Value, withBlock: { snapshot in
            //if snapshot.value as? Bool == true {
          //      self.mailImg.hidden = false
         //   }
          //  else {
           //     self.mailImg.hidden = true
          //  }
      //  })
        
       // timer = NSTimer.scheduledTimerWithTimeInterval(12, target: self, selector: "isLoggedIn", userInfo: nil, repeats: false)
        
      //  DataService.ds.REF_USERS.observeEventType(.ChildAdded, withBlock: { snapshot in
          //  if DataService.ds.REF_BASE.authData.uid != snapshot.key {
          //      self.player1Btn.setTitle(snapshot.value.objectForKey("name") as? String, forState: .Normal)
              //  if snapshot.value.objectForKey("online") as? Bool == true {
              //      self.player1OnlineImg.image = UIImage(named: "greendot")
              //  } else{
              //      self.player1OnlineImg.image = UIImage(named: "reddot")
               // }
          //  }
            
       // })
        
        DataService.ds.REF_USERS.observeEventType(.ChildChanged, withBlock: { snapshot in
            if(DataService.ds.REF_BASE.authData.uid != snapshot.key){
                self.player1Btn.setTitle(snapshot.value.objectForKey("name") as? String, forState: .Normal)
                if snapshot.value.objectForKey("online") as? Bool == true {
                    self.player1OnlineImg.image = UIImage(named: "greendot")
                } else{
                    self.player1OnlineImg.image = UIImage(named: "reddot")
                }
            }
            
        })
        
        
        
        
        
        
         player1Btn.setTitle(NSUserDefaults.standardUserDefaults().stringForKey("UserEmail"), forState: .Normal)
        player1OnlineImg.image = UIImage(named: "greendot")
        
        //player2Btn.setTitle("oli", forState: .Normal)
        
        /*    DataService.ds.REF_USERS.observeEventType(.ChildAdded, withBlock: { snapshot in
        //print(snapshot.value.objectForKey("online")!)
        //print(snapshot.value.objectForKey("name")!)
        if self.tempBool == true {
        print("gros")
        self.player1Btn.setTitle(snapshot.value.objectForKey("name") as? String, forState: .Normal)
        if snapshot.value.objectForKey("online") as? Bool == true {
        print("gros1")
        self.player1OnlineImg.image = UIImage(named: "greendot")
        }
        else {
        self.player1OnlineImg.image = UIImage(named: "reddot")
        }
        self.tempBool = false
        }
        //STUFF IS NOT UPDATING AUTOMATICALLY IN THE APP WHEN WE DO THIS. THIS IS BECAUSE WE ONLY LOOK FOR IT ONCE
        else if self.tempBool == false {
        print("gros")
        self.player2Btn.setTitle(snapshot.value.objectForKey("name") as? String, forState: .Normal)
        if snapshot.value.objectForKey("online") as? Bool == true {
        self.player2OnlineImg.image = UIImage(named: "greendot")
        print("gros2")
        }
        else {
        self.player2OnlineImg.image = UIImage(named: "reddot")
        }
        }
        
        //DataService.ds.REF_USERS.removeAllObservers()
        
        self.constantTimer = NSTimer.scheduledTimerWithTimeInterval(12, target: self, selector: "isOnlineConstant", userInfo: nil, repeats: true)
        
        
        })
        
        //DataService.ds.REF_USERS.childByAppendingPath("oli").childByAppendingPath("online").observeEventType(.Value, withBlock: { snapshot in
        // if snapshot.value as? Bool == true {
        //    self.player2OnlineImg.image = UIImage(named: "greendot")
        //}
        
        // else {
        //   self.player2OnlineImg.image = UIImage(named: "reddot")
        //}
        
        //}, withCancelBlock: { error in
        //      print(error.description)
        //})
        */
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /*  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if timer == nil
        {
            // var tempBool : Bool = true
            DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("online").setValue(true)
            /*if(DataService.ds.REF_BASE.authData.uid == "4dfb52d5-9ed6-449f-9074-ee822148c7ca"){
            player1OnlineImg.image = UIImage(named: "greendot")
            } else{
            //  player2OnlineImg.image = UIImage(named: "greendot")
            }*/
            
            timer = NSTimer.scheduledTimerWithTimeInterval(12, target: self, selector: "isLoggedIn", userInfo: nil, repeats: false)
        } else{
            //  var tempBool : Bool = false
            timer!.invalidate()
            timer = nil
            timer = NSTimer.scheduledTimerWithTimeInterval(12, target: self, selector: "isLoggedIn", userInfo: nil, repeats: false)
            
            
        }
        super.touchesBegan(touches, withEvent:event)
    }*/
    
    /*func isOnlineConstant(){
    self.tempBool = true
    DataService.ds.REF_USERS.removeAllObservers()
    DataService.ds.REF_USERS.observeEventType(.ChildAdded, withBlock: { snapshot in
    
    //print(snapshot.value.objectForKey("online")!)
    //print(snapshot.value.objectForKey("name")!)
    if self.tempBool == true {
    print("gros")
    if snapshot.value.objectForKey("online") as? Bool == true {
    self.player1OnlineImg.image = UIImage(named: "greendot")
    }
    else {
    self.player1OnlineImg.image = UIImage(named: "reddot")
    }
    self.tempBool = false
    }
    //STUFF IS NOT UPDATING AUTOMATICALLY IN THE APP WHEN WE DO THIS. THIS IS BECAUSE WE ONLY LOOK FOR IT ONCE
    else if self.tempBool == false {
    print("gros")
    if snapshot.value.objectForKey("online") as? Bool == true {
    print("gros11")
    self.player2OnlineImg.image = UIImage(named: "greendot")
    }
    else {
    self.player2OnlineImg.image = UIImage(named: "reddot")
    }
    }
    
    })
    }*/
    
    
    func isLoggedIn() {
        DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("online").setValue(false)
        /*  if(DataService.ds.REF_BASE.authData.uid == "4dfb52d5-9ed6-449f-9074-ee822148c7ca"){
        player1OnlineImg.image = UIImage(named: "reddot")
        } else{
        //  player2OnlineImg.image = UIImage(named: "reddot")
        }*/
    }
    
    func messageRead() {
        DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("newMessage").setValue(false)
        
    }
    
    @IBAction func onPlayer1BtnPressed(sender: AnyObject) {
        var counter = 0
        var counter2 = 0
        var counter3 = 0
        
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").observeEventType(.ChildAdded, withBlock: { snapshot in
            if snapshot.childSnapshotForPath("opponent").value as? String == "" {
                
                if (counter == 0) && (DataService.ds.REF_BASE.authData.uid != snapshot.key) {
                    counter += 1
                    
                
                    self.isHost = false
                    self.hostName = snapshot.key
                    DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(snapshot.key).childByAppendingPath("opponent").setValue(DataService.ds.REF_BASE.authData.uid)
                    DataService.ds.REF_BASE.childByAppendingPath("currentGames").removeAllObservers()
                
                    self.performSegueWithIdentifier("InGameVC", sender: nil)
                }
            }
        })
        
        
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").observeEventType(.ChildAdded, withBlock: { snapshot in
            counter2 += 1
            if snapshot.childSnapshotForPath("opponent").value as? String != "" {
                counter3 += 1
                print(counter2)
                
                if counter3 == counter2 {
                    print("nig")
                    self.createGame()
                    self.performSegueWithIdentifier("InGameVC", sender: nil)
                    DataService.ds.REF_BASE.childByAppendingPath("currentGames").removeAllObservers()
                }
            }
        })
        
        
       
        
        /*var alanisawesome = ["full_name": "Alan Turing", "date_of_birth": "June 23, 1912"]
        var gracehop = ["full_name": "Grace Hopper", "date_of_birth": "December 9, 1906"]
        
        var usersRef = ref.childByAppendingPath("users")
        
        var users = ["alanisawesome": alanisawesome, "gracehop": gracehop]
        usersRef.setValue(users)*/
    }
    /*@IBAction func onPlayer2BtnPressed(sender: AnyObject) {
    if DataService.ds.REF_BASE.authData.uid == "cdbc1330-bc3f-4faa-9d4e-369259b2e98f" {
    performSegueWithIdentifier("MyMessagesVC", sender: nil)
    }
    else {
    
    performSegueWithIdentifier("MessageWriteVC", sender: nil)
    }
    }*/
    
    func createGame() {
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("opponent").setValue("")
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("questionRandNumber").setValue("")
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("myScore").setValue("")
        DataService.ds.REF_BASE.childByAppendingPath("currentGames").childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("opponentScore").setValue("")
        self.isHost = true
        self.hostName = DataService.ds.REF_BASE.authData.uid
    }
    
    @IBAction func onBackBtnPressed(sender: AnyObject) {
     //   DataService.ds.REF_USERS.childByAppendingPath(DataService.ds.REF_BASE.authData.uid).childByAppendingPath("online").setValue(false)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InGameVC" {
            if let InGameVC = segue.destinationViewController as? InGameVC {
                InGameVC.isHost = isHost
                InGameVC.hostName = hostName
            }
        }
    }
    
}