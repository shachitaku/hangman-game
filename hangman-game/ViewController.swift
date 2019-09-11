//
//  ViewController.swift
//  hangman-game
//
//  Created by Takumi Kimura on 2018/12/01.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//



//ピッカーじゃなくて、ボタン式にしたほうが良い

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var guessingWord : String = ""
    var mappedWord : Array = [""]
    var count = 0
    @IBOutlet var label: UILabel!
    @IBOutlet var guessingField: UITextField!
    @IBOutlet var letterPickerView: UIPickerView!
    let alphabetList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Delegate設定
        letterPickerView.delegate = self
        letterPickerView.dataSource = self
    
        createWords()
        
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return alphabetList.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return alphabetList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        // 処理
    }
    
    @IBAction func show(){
        label.text = guessingWord
    }
    
    
    func createWords(){
        let mappedWord = guessingWord.map { String($0) }
        let guessingWordLength = mappedWord.count
        
        for i in 0..<guessingWordLength {
        let TestView = UIView.init(frame: CGRect.init(x: 30+i*30, y: 200, width: 20, height: 2))
            // 30 , 60 , 90, 120...
        let bgColor = UIColor.black
        TestView.backgroundColor = bgColor
        self.view.addSubview(TestView)
        }
        
        //even better way!
        self.mappedWord = guessingWord.map { String($0) }
        // example output ["h", "e", "l", "l", "o"]
        
    }


    @IBAction func selfDismiss(sender: Any?){
        
    }
    
    @IBAction func checkWord(){
        
        
        //カウンター貯めるためのやつ
        let selectedLetter = alphabetList[letterPickerView.selectedRow(inComponent: 0)]
        // print(selectedLetter) -> a
        
        let letterIndex = mappedWord.index(of: selectedLetter)
        
        if letterIndex == nil {
            count += 1
            label.text! = String(count)
            
            let correspondingLabel = self.view.viewWithTag(99+count) as? UILabel
            correspondingLabel?.textColor? = UIColor.red
            
        }
        //ここまでカウンター用
        
        //１０回するのは、複数回重なってるやつ用
        var i = 0
        while i < 10 {

        //both same
        // let first = guessingWord[guessingWord.startIndex]
        //let first = guessingWord.prefix(1)
        
        //選択したアルファベット
        let selectedLetter = alphabetList[letterPickerView.selectedRow(inComponent: 0)]
        // print(selectedLetter) -> a
        
        let letterIndex = mappedWord.index(of: selectedLetter)
        
        if letterIndex != nil {
            let correspondingLabel = self.view.viewWithTag(letterIndex!+27) as? UILabel
            correspondingLabel?.text = mappedWord[letterIndex!]
            correspondingLabel?.textColor? = UIColor.red
            
            mappedWord.remove(at: letterIndex!)
            mappedWord.insert("done", at: letterIndex!)
            
        } else {
        let alphabetNumber = alphabetList.index(of: selectedLetter)
        let correspondingLabel = self.view.viewWithTag(alphabetNumber!+1) as? UILabel
        correspondingLabel?.textColor? = UIColor.red
        }
            
            i += 1
    }
        
        //祝杯用
        let dones = Array(repeating: "done", count: guessingWord.count)
        if mappedWord == dones {
            label.textColor = UIColor.red
            label.text = "Congratulations!!"
        }
    }
}


extension String {
    
    public func doesInclude(structuredBy chars: String) -> Bool {
        let characterSet = NSMutableCharacterSet()
        characterSet.addCharacters(in: chars)
        return self.trimmingCharacters(in: characterSet as CharacterSet).count <= 0
    }
    
    // こういうことも出来るんだよというメモ
    //        if guessingWord.doesInclude(structuredBy: "abcdefghijklmnopqrstuvwxyz") == true {
    //   print("ok")
    
   
}

