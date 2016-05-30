//
//  ViewController.swift
//  Quiz
//
//  Created by John Cook on 5/29/16.
//  Copyright © 2016 John Cook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel:    UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint:    NSLayoutConstraint!
    @IBOutlet var answerLabel:          UILabel!
    
    let questions:  [String] = ["From what is cognac made?",
                                "What is 7 + 7?",
                                "What is the capital of Vermont?"]
    let answers:    [String] = ["Grapes",
                                "14",
                                "Montpelier"]
    var currentQuestionIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // set initial alpha of label
        nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex = currentQuestionIndex+1;
        if (currentQuestionIndex == questions.count) {
            currentQuestionIndex = 0
        }
        let question = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text   = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        // animate alpha and center x constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5,
                                   delay: 0,
                                   options: [.CurveEaseOut],
                                   animations: {
                                    self.currentQuestionLabel.alpha = 0
                                    self.nextQuestionLabel.alpha    = 1
                                    self.view.layoutIfNeeded()
        },
                                   completion: { _ in
                                    swap(&self.currentQuestionLabel,
                                    &self.nextQuestionLabel)
                                    swap(&self.currentQuestionLabelCenterXConstraint,
                                    &self.nextQuestionLabelCenterXConstraint)
                                    
                                    self.updateOffScreenLabel()
                                    
        })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
}

