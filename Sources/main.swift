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
    print("Invalid usage. Missing path to storyboard files")
    exit(1)
}

let argument = CommandLine.arguments[1]
var filePaths: [String] = []
let suffix = ".xcdatamodel"
if argument.hasSuffix(suffix) {
    filePaths = [argument]
} else if let s = findFile(rootPath: argument, suffix: suffix) {
    filePaths = s
}

for filePath in filePaths {
    var url = URL(fileURLWithPath: filePath)
    url = url.appendingPathComponent("contents")
    do {
        let xmlString = try String(contentsOf: url)
        let xml = SWXMLHash.parse(xmlString)
        guard let parsedMom = MomXML(xml: xml) else {
            print("Failed to parse \(url)")
            exit(1)
        }
        print("---- file loaded")
        
        // same count of entity and element
        if(parsedMom.model.entities.count == parsedMom.model.elements.count){
            print("+++ number entites is equals number element")
        }else {
            print("--- number entites is not equals number element")
        }
        
        // Here check mom xml is correct
        if (parsedMom.model.check()){
            print("is check")
        }
        
        // there is entity, element
        if (parsedMom.model.entities.count == 0){
            print("No entity was found")
        }else {
            //check attribute found
            parsedMom.model.entities.forEach{
                if($0.attributes.count == 0 ){
                     print("No attribut was found")
                }
            }
        }
        
        if (parsedMom.model.elements.count == 0){
            print("No elements was found")
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
            print("element name not correspond in entity name")
        }else {
            print("some element name correspond in some entity name")
        }
        
        //Convert inverse
        guard let myXML = MomXML(xml: SWXMLHash.parse(parsedMom.xml)) else {
            print("Failed to parse \(url)")
            exit(1)
        }
        
        if (myXML.model.check()){
            print("is check")
        }
        
    } catch {
        print("Failed to read \(url): \(error)")
        exit(1)
    }
}

exit(0)
