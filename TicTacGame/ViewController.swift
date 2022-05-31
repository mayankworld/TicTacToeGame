//
//  ViewController.swift
//  TicTacGame
//
//  Created by Mayank on 27/05/22.
//

import UIKit
enum UserTurn{
    case cross
    case nought
}

class ViewController: UIViewController {
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    
    @IBOutlet weak var lblWinPlayerMessage: UILabel!
    
  
    var firstMove =   UserTurn.cross
    var currentMove =  UserTurn.cross
    
    var arrButtons = [UIButton]()
    var finalMove: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwipeGesture()
        becomeFirstResponder()
        updateResult()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arrButtons.append(btn1)
        arrButtons.append(btn2)
        arrButtons.append(btn3)
        arrButtons.append(btn4)
        arrButtons.append(btn5)
        arrButtons.append(btn6)
        arrButtons.append(btn7)
        arrButtons.append(btn8)
        arrButtons.append(btn9)
    }
    
    
    @IBAction func ActionTapBtn(_ sender: UIButton) {
        
        if (sender.currentTitle == "" || sender.currentTitle == nil) && lblWinPlayerMessage.text == "" {
            var title = ""
            if currentMove == .nought{
                title = "X"
                currentMove = .cross
            }else{
                title = "O"
                currentMove = .nought
            }
            
            for btn in arrButtons {
                if btn == sender {
                   
                    btn.setTitle(title, for: .normal)
                    btn.setTitleColor(.black, for: .normal)
                   
                }
            }
            
            if checkResult("X") {
                lblWinPlayerMessage.text = "Yipeee! User X wins."
                UserXScore = UserXScore + 1
                updateResult()
                return
            }
            
            if checkResult("O") {
                lblWinPlayerMessage.text = "Yipeee! User O wins."
               UserOScore = UserOScore + 1
                updateResult()
                return
            }
            
            if checkEvenState() {
                lblWinPlayerMessage.text = "Even state."
                return
            }
            
            finalMove = sender
        }
    }
   
    func CheckGameOver() -> Bool {
        for btn in arrButtons {
            
            if btn.currentTitle == "" {
                return false
            }
            
        }
        return true
    }
    
    
    func gamereset() {
        for btn in arrButtons {
            btn.setTitle("", for: .normal)
           
        }
        firstMove =   UserTurn.cross
        currentMove =  UserTurn.cross
        lblWinPlayerMessage.text = ""
        
    }
    
    func undoLastMove() {
        if finalMove?.currentTitle != "" {
            finalMove?.setTitle("", for: .normal)
            currentMove = currentMove == .cross ? .nought : .cross
        }
       
    }
    
    
    func checkResult(_ s: String) -> Bool {
        if checkSymbol(btn1, s) && checkSymbol(btn2, s) && checkSymbol(btn3, s) {
            return  true
        }
        if checkSymbol(btn4, s) && checkSymbol(btn5, s) && checkSymbol(btn6, s) {
            return  true
        }
        if checkSymbol(btn7, s) && checkSymbol(btn8, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        if checkSymbol(btn1, s) && checkSymbol(btn4, s) && checkSymbol(btn7, s) {
            return  true
        }
        if checkSymbol(btn2, s) && checkSymbol(btn5, s) && checkSymbol(btn8, s) {
            return  true
        }
        if checkSymbol(btn3, s) && checkSymbol(btn6, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        
        if checkSymbol(btn1, s) && checkSymbol(btn2, s) && checkSymbol(btn3, s) {
            return  true
        }
        if checkSymbol(btn4, s) && checkSymbol(btn5, s) && checkSymbol(btn6, s) {
            return  true
        }
        if checkSymbol(btn7, s) && checkSymbol(btn8, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        
        if checkSymbol(btn1, s) && checkSymbol(btn5, s) && checkSymbol(btn9, s) {
            return  true
        }
        if checkSymbol(btn3, s) && checkSymbol(btn5   , s) && checkSymbol(btn7, s) {
            return  true
        }
        
        return false
    }
    
    func checkSymbol(_ btn: UIButton,_ symbol: String) -> Bool {
        return btn.title(for: .normal) == symbol
    }
    
    func checkEvenState() -> Bool{
        var count = 0
        for btn in arrButtons {
            if btn.currentTitle?.count ?? 0 > 0 {
                count += 1
            }
        }
        return count == arrButtons.count
    }
    
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Tic Tac Toc Game", message: message, preferredStyle: .alert)
        
        let btnOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.gamereset()
        }
        alert.addAction(btnOk)
        self.present(alert, animated: true) {
            
        }
    }
    
    
    func updateResult() {
        lblPlayerO.text = "\(UserOScore)"
        lblPlayerX.text = "\(UserXScore)"
    }
    
}

extension ViewController {
    func SwipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let _ = gesture as? UISwipeGestureRecognizer {
            
            
            let alert = UIAlertController(title: "Tic Tac Toc Game", message: "Do you want to reset game?", preferredStyle: .alert)
            
            let btnOk = UIAlertAction(title: "Yes", style: .destructive) { _ in
                self.gamereset()
            }
            let btnCancel = UIAlertAction(title: "No", style: .cancel) { _ in
              
            }
            alert.addAction(btnOk)
            alert.addAction(btnCancel)
            self.present(alert, animated: true) {
                
            }
        }
    }
    
}

//Check motion
extension ViewController {
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            self.undoLastMove()
        }
    }
}

extension ViewController {
    var UserXScore: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "x")
        }
        get {
            return UserDefaults.standard.value(forKey: "x") as? Int ?? 0
        }
    }
    var UserOScore: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "o")
        }
        get {
            return UserDefaults.standard.value(forKey: "o") as? Int ?? 0
        }
    }
}
