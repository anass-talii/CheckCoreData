//
//  main.swift
//  JSONToCoreData
//
//  Created by Anass TALII on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation
#if IMPORT
    import MomXML
    import SWXMLHash
#endif
if CommandLine.arguments.count == 1 {
    print("Invalid usage. Missing path to .xcadatamodel files")
    exit(1)
}


var myDict: NSMutableDictionary = [:]
var item = 0

for var cmd in (1..<CommandLine.arguments.count) {
    let argument = CommandLine.arguments[cmd]
    var filePaths: [String] = []
    let suffix = ".xcdatamodel"
    if argument.hasSuffix(suffix) {
        filePaths = [argument]
    } else if let s = findFile(rootPath: argument, suffix: suffix) {
        filePaths = s
    }
    
    for filePath in filePaths {
        var url = URL(fileURLWithPath: filePath)
        var myError = NSMutableArray()
        url = url.appendingPathComponent("contents")
        do {
            let xmlString = try String(contentsOf: url)
            let xml = SWXMLHash.parse(xmlString)
            guard let parsedMom = MomXML(xml: xml) else {
                myError.add("Failed to parse \(url)")
                exit(1)
            }
            //myError.add("file loaded")
            
            // same count of entity and element
            if(parsedMom.model.entities.count != parsedMom.model.elements.count){
                myError.add("number entites is not equals number element")
            }
            
            // Here check mom xml is correct
            if (!parsedMom.model.check()){
                myError.add("model is not checked")
            }
            
            // there is entity, element
            if (parsedMom.model.entities.count == 0){
                myError.add("No entity was found")
            }else {
                //check attribute found
                parsedMom.model.entities.forEach{
                    if($0.attributes.count == 0 ){
                        myError.add("entity \($0.name) No was found")
                    }
                }
            }
            
            if (parsedMom.model.elements.count == 0){
                myError.add("No elements was found")
            }
            
            // there is  elements name equal entities name
            var find = 0
            for i in 0 ... parsedMom.model.elements.count-1 {
                for j in 0 ... parsedMom.model.entities.count-1 {
                    if (parsedMom.model.elements[i].name == parsedMom.model.entities[j].name){
                        find = find + 1
                    }
                }
            }
            if(find != parsedMom.model.elements.count)
            {
                myError.add("element name not correspond in entity name")
            }
            
            //Convert inverse
            guard let myXML = MomXML(xml: SWXMLHash.parse(parsedMom.xml)) else {
                myError.add("Failed to parse inverse \(url)")
                exit(1)
            }
            
            if (!myXML.model.check()){
                myError.add("model is not checked from inverse methode")
            }
            
        } catch {
            myError.add("Failed to read \(url): \(error)")
            exit(1)
        }
        if(myError.count != 0){
            myDict.setValue(myError, forKey: String(item))
            item += item
        }
    }
}
if (myDict.count > 0) {
    if let jsonData = try? JSONSerialization.data( withJSONObject: myDict, options: []) {
        let stringValue = String(data: jsonData, encoding: .ascii)
        print(stringValue!)
    }
}


exit(0)
