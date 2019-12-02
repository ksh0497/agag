//
//  ViewController.swift
//  Fruit XML Parsing ksh
//
//  Created by D7703_04 on 2019. 12. 2..
//  Copyright © 2019년 K. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]  // [key:value]
    var elements:[[String:String]] = [] // Dictionary의 배열
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        // optional binding 처리
        // let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml")
        
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        let pizzaURL = NSURL(string: strURL)
        
        //  if path != nil{
        if pizzaURL != nil{
            //  let myParser = XMLParser(contentsOf: path!)
            let myParser = XMLParser(contentsOf: pizzaURL! as URL)
            if myParser != nil{
                // XMLParserDelegate와 UIViewController 연결
                myParser?.delegate = self
                
                // Parsing 시작
                if (myParser?.parse())!{
                    print(elements)
            } else {
                print("File Error!")
            }
        } else {
            print("File Error!")
        }
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        // 공백 및 white char 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            item[currentElement] = data
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if elementName == "item"{
            elements.append(item)
        }
    }
}

