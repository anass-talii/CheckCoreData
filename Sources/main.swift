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
        if (parsedMom.model.entities.count == 3){
            // there is attribute in entity
            print("---------- Entities :")
            parsedMom.model.entities.forEach {
                print("\($0.name)")
                $0.attributes.forEach { print("\($0.name) : \($0.attributeType)") }
            }
        }
        // there is  element
        if (parsedMom.model.elements.count == 3){
            print("---------- Elements :")
            print(parsedMom.model.elements[0].name)
            print(parsedMom.model.elements[1].name)
            print(parsedMom.model.elements[2].name)
            parsedMom.model.elements.forEach {
                print("\($0.name)")
            }

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
