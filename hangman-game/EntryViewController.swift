//
//  ViewController.swift
//  hangman-game
//
//  Created by Takumi Kimura on 2018/12/01.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    
    // テキストフィールド
    @IBOutlet weak var gameWord: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    // segue
    @IBAction func startGame(sender: AnyObject?){
        self.performSegue(withIdentifier: "toGame", sender: self.gameWord.text)
    }
    
    // このメソッドで渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            let viewController:ViewController = segue.destination as! ViewController
            viewController.guessingWord = sender as! String
        }
        
    }
    
}

