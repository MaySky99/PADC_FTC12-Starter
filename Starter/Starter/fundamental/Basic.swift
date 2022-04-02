//
//  Basic.swift
//  Starter
//
//  Created by Cruise on 2/2/22.
//

import Foundation

var colorList = ["red","blue","green"]
var regionList : Set = ["yangon","mandalay","naypyitaw"]
var townshipList :[String : [String]] = ["yangon" : ["yankin","insein","dagon"]]

var doOnNext:(String)->String = {_ -> (String) in ""}

func main(){
    
    var name = "May"
    name = "Sky"
    debugPrint(name)

    colorList.append("orange")
    
    let township = townshipList["yangon"] ?? []
    debugPrint(township)
    
    for color in colorList{
        debugPrint(color)
    }
    
    var indexForWhile = 0
    while indexForWhile < 3 {
        debugPrint(colorList[indexForWhile])
        indexForWhile += 1
    }
    
    var indexForRepeatWhile = 0
    repeat{
        debugPrint(indexForRepeatWhile)
        indexForRepeatWhile += 1
    }while indexForRepeatWhile < 3
    
    doOnNext = { name -> (String) in
        debugPrint("Hello \(name)")
        return "Hello \(name)"
    }

    decrease(doDecrease: {
        
    }, total: 10)
}

func increment( amount:Int )-> () -> Int {
    func doProcess() -> Int{
        return amount
    }
    return doProcess
}

func decrease(doDecrease:()-> Void,total:Int)-> Void{
    debugPrint("decrease")
}
