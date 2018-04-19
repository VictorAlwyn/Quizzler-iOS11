//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestion = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = allQuestion.list[0].question
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }else if sender.tag == 2{
            pickedAnswer = false
        }
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        scoreLabel.text = "score : \(score)"
        progressLabel.text = "\(questionNumber) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        questionNumber = questionNumber + 1
        if questionNumber < 13 {
        questionLabel.text = allQuestion.list[questionNumber].question
        }else{
            let alert = UIAlertController(title: "Amazing", message: "you finish all the question", preferredStyle: .alert)
            
            let reset = UIAlertAction(title: "Reset", style: .default, handler: { (alert) in
                self.startOver()
            })
            
            alert.addAction(reset)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correct = allQuestion.list[questionNumber].answer
        
        if correct == pickedAnswer {
            ProgressHUD.showSuccess("correct")
            score = score + 1
        }else{
            ProgressHUD.showError("wrong!")
        }
        
    }
    
    
    func startOver() {
       score = 0
        questionNumber = 0
        updateUI()
        questionLabel.text = allQuestion.list[0].question
    }
    

    
}
