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

var myDict: [String: Any] = ["success": "true"]
var myDicAllFiles:[Any] = []
var item = 0
var valSuccess = true

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
    var myError: [String] = []
    url = url.appendingPathComponent("contents")
    do {
        let xmlString = try String(contentsOf: url)
        let xml = SWXMLHash.parse(xmlString)
        guard let parsedMom = MomXML(xml: xml) else {
            myError.append("Failed to parse \(url)")
            break
        }
        //myError.add("file loaded")
        
        // same count of entity and element
        if(parsedMom.model.entities.count != parsedMom.model.elements.count){
            myError.append("number entities is not equals number element")
        }
        
        // Here check mom xml is correct
        if (!parsedMom.model.check()){
            myError.append("model is not checked")
        }
        
        // there is entity, element
        if (parsedMom.model.entities.count == 0){
            myError.append("No entity was found")
        }else {
            //check attribute found
            parsedMom.model.entities.forEach{
                if($0.attributes.count == 0 ){
                    myError.append("No attribute was found in '\($0.name)'")
                }
            }
        }
        
        if (parsedMom.model.elements.count == 0){
            myError.append("No elements was found")
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
            myError.append("element name not correspond in entity name")
        }
        
        //Convert inverse
        guard let myXML = MomXML(xml: SWXMLHash.parse(parsedMom.xml)) else {
            myError.append("Failed to parse inverse \(url)")
            break
        }
        
        if (!myXML.model.check()){
            myError.append("model is not checked from inverse methode")
        }
        
    } catch {
        myError.append("Failed to read \(url): \(error)")
        exit(1)
    }
    var myDictFile: [String:Any] = [:]
    let filename = filePath.components(separatedBy: "/")
    myDictFile["name"] = filename[filename.count-1]
    if(myError.count != 0){
        valSuccess = false
        if(myError.count > 0) {
            myDictFile["error"] = myError
            myDictFile["success"] = false
        }
        myDicAllFiles.append(myDictFile)
    } else {
        myDictFile["message"] = "CoreData model is correct"
        myDictFile["success"] = true
        myDicAllFiles.append(myDictFile)
    }

}
if (myDict.count > 0) {
    myDict["success"] = valSuccess
    myDict["model"] = myDicAllFiles
    if let jsonData = try? JSONSerialization.data( withJSONObject: myDict, options: []) {
        let stringValue = String(data: jsonData, encoding: .utf8)
        print(stringValue!)
    }
}


exit(0)
