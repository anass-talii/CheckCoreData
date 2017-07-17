#!/usr/bin/env xcrun swift -F Carthage/Build/Mac


// ----------------------------
//
// MomAttribute+Equatable.swift
//
// ----------------------------

//
//  MomAttribute+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomAttribute: Equatable {
    public static func == (lhs: MomAttribute, rhs: MomAttribute) -> Bool {
        return lhs.name == rhs.name && lhs.isOptional == rhs.isOptional && lhs.isTransient == rhs.isTransient && lhs.attributeType.rawValue == rhs.attributeType.rawValue
    }
}


// ----------------------------
//
// MomElement+Equatable.swift
//
// ----------------------------

//
//  MomElement+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomElement: Equatable {
    public static func == (lhs: MomElement, rhs: MomElement) -> Bool {
        return lhs.name == rhs.name && lhs.positionX == rhs.positionX && lhs.positionY == rhs.positionY && lhs.width == rhs.width && lhs.height == rhs.height
    }
}


// ----------------------------
//
// MomEntity+Equatable.swift
//
// ----------------------------

//
//  MomEntity+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomEntity: Equatable {

    public static func == (lhs: MomEntity, rhs: MomEntity) -> Bool {
        if lhs.name == rhs.name {
            if lhs.attributes.count != rhs.attributes.count {
                return false
            }
            if lhs.relationship.count != rhs.relationship.count {
                return false
            }
            let lattributes = lhs.attributes.sorted { $0.name < $1.name }
            let rattributes = rhs.attributes.sorted { $0.name < $1.name }
            if lattributes != rattributes {
                return false
            }
            let lrelationship = lhs.relationship.sorted { $0.name < $1.name }
            let rrelationship = rhs.relationship.sorted { $0.name < $1.name }
            if lrelationship != rrelationship {
                return false
            }
            if lhs.userInfo != rhs.userInfo {
                return false
            }
            return true
        }
        return false
    }
}


// ----------------------------
//
// MomModel+Equatable.swift
//
// ----------------------------

//
//  MomModel+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomModel: Equatable {

    public static func == (lhs: MomModel, rhs: MomModel) -> Bool {
        if lhs.entities.count != rhs.entities.count {
            return false
        }
        if lhs.elements.count != rhs.elements.count {
            return false
        }
        return lhs.entities.sorted { $0.name < $1.name } == rhs.entities.sorted { $0.name < $1.name } &&
            lhs.elements.sorted { $0.name < $1.name } == rhs.elements.sorted { $0.name < $1.name }
    }
}


// ----------------------------
//
// MomRelationship+Equatable.swift
//
// ----------------------------

//
//  MomRelationship+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomRelationship: Equatable {
    public static func == (lhs: MomRelationship, rhs: MomRelationship) -> Bool {
        return lhs.name == rhs.name && lhs.isToMany == rhs.isToMany && lhs.isOrdered == rhs.isOrdered
            && lhs.isOptional == rhs.isOptional && lhs.destinationEntity == rhs.destinationEntity
            && lhs.deletionRule == rhs.deletionRule && lhs.syncable == rhs.syncable
            && lhs.inverseName == rhs.inverseName && lhs.inverseEntity == rhs.inverseEntity
            && lhs.maxCount == rhs.maxCount && lhs.minCount == rhs.minCount
    }
}


// ----------------------------
//
// MomUserInfo+Equatable.swift
//
// ----------------------------

//
//  MomUserInfo+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomUserInfo: Equatable {

    public static func == (lhs: MomUserInfo, rhs: MomUserInfo) -> Bool {
        if lhs.entries.count != rhs.entries.count {
            return false
        }
        return lhs.entries.sorted { $0.key < $1.key } == rhs.entries.sorted { $0.key < $1.key }
    }
}

extension MomUserInfoEntry: Equatable {
    public static func == (lhs: MomUserInfoEntry, rhs: MomUserInfoEntry) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}


// ----------------------------
//
// MomXML+Equatable.swift
//
// ----------------------------

//
//  MomXML+Equatable.swift
//  MomXML
//
//  Created by anass talii on 12/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomXML: Equatable {
    public static func == (lhs: MomXML, rhs: MomXML) -> Bool {
        return lhs.model == rhs.model
    }
}


// ----------------------------
//
// NSAttributeDescription+MomXML.swift
//
// ----------------------------

//
//  NSAttributeDescription+MomXML.swift
//  MomXML
//
//  Created by anass TALII on 09/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension NSAttributeDescription {

    public var mom: MomAttribute {
       var mom = MomAttribute(name: self.name, attributeType: self.attributeType.mom)

        if let defaultValue = self.defaultValue as? NSObject {
            mom.defaultValueString = defaultValue.description
        }
        mom.isOptional = self.isOptional
        mom.isTransient = self.isTransient
        mom.isIndexed = self.isIndexed

       return mom
    }

    public var momAttributeType: MomAttribute.AttributeType {
        return self.attributeType.mom
    }
}

extension NSAttributeType {

    public var mom: MomAttribute.AttributeType {
        switch self {
        case .binaryDataAttributeType:
            return .binary
        case .booleanAttributeType:
            return .boolean
        case .dateAttributeType:
            return .date
        case .decimalAttributeType:
            return .decimal
        case .doubleAttributeType:
            return .double
        case .floatAttributeType:
            return .float
        case .integer16AttributeType:
            return .integer16
        case .integer32AttributeType:
            return .integer32
        case .integer64AttributeType:
            return .integer64
        case .stringAttributeType:
            return .string
        case .transformableAttributeType:
            return .transformable
        case .undefinedAttributeType:
            return .undefined
        case .objectIDAttributeType:
            return .objectID
        }
    }

}


// ----------------------------
//
// NSEntityDescription+MomXML.swift
//
// ----------------------------

//
//  NSEntityDescription+MomXML.swift
//  MomXML
//
//  Created by anass TALII on 09/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension NSEntityDescription {

    public var mom: MomEntity {
        var mom = MomEntity(name: self.name!, representedClassName: self.name!)

        mom.attributes = self.attributesByName.values.map { $0.mom }
        mom.relationship = self.relationshipsByName.values.map { $0.mom }

        if let userInfo = self.userInfo {
            mom.userInfo = MomUserInfo(userInfo: userInfo)
        }

        return mom
    }

    public var momElement: MomElement {
        return MomElement(name: self.name!)
    }

}


// ----------------------------
//
// NSManagedObjectModel+MomXML.swift
//
// ----------------------------

//
//  NSManagedObjectModel+MomXML.swift
//  MomXML
//
//  Created by anass talii on 09/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension NSManagedObjectModel {

    public var mom: MomModel {
        var mom = MomModel()

        mom.entities = self.entities.map { $0.mom }
        mom.elements = self.entities.map { $0.momElement }

        return mom
    }

    public var momXml: MomXML {
        var xml = MomXML()
        xml.model = self.mom
        return xml
    }

}


// ----------------------------
//
// NSRelationshipDescription+MomXML.swift
//
// ----------------------------

//
//  NSRelationshipDescription+MomXML.swift
//  MomXML
//
//  Created by anass talii on 09/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension NSRelationshipDescription {

    public var mom: MomRelationship {
        let destination = self.destinationEntity!.name!
        var mom = MomRelationship(name:  self.name, destinationEntity: destination)

        if self.maxCount > 0 {
            mom.maxCount = self.maxCount
        }
        if self.minCount > 0 {
            mom.minCount = self.minCount
        }
        mom.isToMany = self.isToMany
        mom.isOrdered = self.isOrdered
        mom.isOptional = self.isOptional

        mom.deletionRule = self.deleteRule.mom

        if let userInfo = self.userInfo {
            mom.userInfo = MomUserInfo(userInfo: userInfo)
        }

        if let inverseRelationship = self.inverseRelationship {
            mom.inverseName =  inverseRelationship.name

            if self.destinationEntity != nil {
                let destination = self.destinationEntity!.name!
                mom.inverseEntity = destination
            }
        }

        return mom
    }

}

extension NSDeleteRule {

    public var mom: MomRelationship.DeletionRule {
        switch self {
        case .noActionDeleteRule:
            return .noAction
        case .nullifyDeleteRule:
            return .nullify
        case .cascadeDeleteRule:
            return .cascade
        case .denyDeleteRule:
            return .deny
        }
    }
}


// ----------------------------
//
// MomAttribute+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomAttribute: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element, element.name == "attribute" else {
            return nil
        }
        guard let name = element.attribute(by: "name")?.text,
        let attributeTypeString = element.attribute(by: "attributeType")?.text,
        let attributeType = AttributeType(rawValue: attributeTypeString) else {
            return nil
        }
        self.init(name: name, attributeType: attributeType)

        self.isOptional = xml.element?.attribute(by: "optional")?.text.toBool ?? false
        self.usesScalarValueType = xml.element?.attribute(by: "usesScalarValueType")?.text.toBool ?? false
        self.isIndexed = xml.element?.attribute(by: "indexed")?.text.toBool ?? false
        self.isTransient = xml.element?.attribute(by: "transient")?.text.toBool ?? false
        self.syncable = xml.element?.attribute(by: "syncable")?.text.toBool ?? false

        self.defaultValueString = xml.element?.attribute(by: "defaultValueString")?.text
        self.defaultDateTimeInterval = xml.element?.attribute(by: "defaultDateTimeInterval")?.text
        self.minValueString = xml.element?.attribute(by: "minValueString")?.text
        self.maxValueString = xml.element?.attribute(by: "maxValueString")?.text
    }

}


// ----------------------------
//
// MomElement+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomElement: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element, element.name == "element" else {
            return nil
        }
        guard let name = element.attribute(by: "name")?.text,
            let positionX = element.attribute(by: "positionX")?.text.toInt,
            let positionY = element.attribute(by: "positionY")?.text.toInt,
            let width = element.attribute(by: "width")?.text.toInt,
            let height = element.attribute(by: "height")?.text.toInt else {
                return nil
        }
        self.init(name: name, positionX: positionX, positionY: positionY, width: width, height: height)
    }

}


// ----------------------------
//
// MomEntity+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomEntity: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element, element.name == "entity" else {
            return nil
        }
        guard let name = element.attribute(by: "name")?.text,
            let representedClassName = element.attribute(by: "representedClassName")?.text,
            let codeGenerationType = element.attribute(by: "codeGenerationType")?.text else {
                return nil
        }

        self.init(name: name, representedClassName: representedClassName, codeGenerationType: codeGenerationType)

        self.syncable = xml.element?.attribute(by: "syncable")?.text.toBool ?? false

        for xml in xml.children {
            if let object = MomAttribute(xml: xml) {
                self.attributes.append(object)
            } else if let object = MomRelationship(xml: xml) {
                self.relationship.append(object)
            } else if let object = MomUserInfo(xml: xml) {
               userInfo = object
            }
        }

    }
}


// ----------------------------
//
// MomModel+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomModel: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element, element.name == "model" else {
            return nil
        }

        type = element.attribute(by: "type")?.text ?? type
        documentVersion = element.attribute(by: "documentVersion")?.text ?? documentVersion
        lastSavedToolsVersion = element.attribute(by: "lastSavedToolsVersion")?.text ?? lastSavedToolsVersion
        minimumToolsVersion = element.attribute(by: "minimumToolsVersion")?.text ?? minimumToolsVersion
        userDefinedModelVersionIdentifier = element.attribute(by: "userDefinedModelVersionIdentifier")?.text ?? userDefinedModelVersionIdentifier

        for xml in xml.children {
            if let entity = MomEntity(xml: xml) {
                self.entities.append(entity)
            } else if xml.element?.name == "elements" {
                for xml in xml.children {
                    if let element = MomElement(xml: xml) {
                        self.elements.append(element)
                    }
                }
            }
        }
    }

}


// ----------------------------
//
// MomRelationship+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomRelationship: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element, element.name == "relationship" else {
            return nil
        }

        guard let name = element.attribute(by: "name")?.text,
            let destinationEntity = element.attribute(by: "destinationEntity")?.text else {
                return nil
        }
        self.init(name: name, destinationEntity: destinationEntity)

        self.syncable = xml.element?.attribute(by: "syncable")?.text.toBool ?? false
        self.isOptional = xml.element?.attribute(by: "optional")?.text.toBool ?? false
        self.isToMany = xml.element?.attribute(by: "toMany")?.text.toBool ?? false
        self.isOrdered = xml.element?.attribute(by: "ordered")?.text.toBool ?? false

        if let text = xml.element?.attribute(by: "ordered")?.text, let rule = DeletionRule(rawValue: text) {
            self.deletionRule = rule
        }

        self.maxCount = xml.element?.attribute(by: "maxCount")?.text.toInt
        self.minCount = xml.element?.attribute(by: "minCount")?.text.toInt

        self.inverseName = xml.element?.attribute(by: "inverseName")?.text
        self.inverseEntity = xml.element?.attribute(by: "inverseEntity")?.text

        for xml in xml.children {
            if let object = MomUserInfo(xml: xml) {
                userInfo = object
            }
        }
    }

}


// ----------------------------
//
// MomUserInfo+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomUserInfo: XMLObject {

    public init?(xml: XML) {
        guard let name = xml.element?.name, name == "userInfo" else {
            return nil
        }

        for child in xml.children {
            if let entry = MomUserInfoEntry(xml: child) {
                self.entries.append(entry)
            }
        }
    }

}

extension MomUserInfoEntry: XMLObject {

    public init?(xml: XML) {
        guard let element = xml.element else {
            return nil
        }
        guard let key = element.attribute(by: "key")?.text,
            let value = element.attribute(by: "value")?.text else {
                return nil
        }
        self.init(key: key, value: value)
    }

}


// ----------------------------
//
// MomXML+XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomXML: XMLObject {

    public init?(xml: XML) {
        var hasModel = false
        for child in xml.children {
            if let model = MomModel(xml: child) {
                self.model = model
                hasModel = true
            }
        }
        if !hasModel {
            return nil
        }
        // TODO parse root attributes
    }

}


// ----------------------------
//
// MomAttribute+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomAttribute: XMLConvertible {

    public var xml: String {
        var output = "<attribute name=\"\(name)\" attributeType=\"\(attributeType.xml)\""

        output += " optional=\"\(isOptional.xml)\""

        if usesScalarValueType {
            output += " usesScalarValueType=\"\(usesScalarValueType.xml)\""
        }
        if isIndexed {
            output += " indexed=\"\(isIndexed.xml)\""
        }
        if isTransient {
            output += " transient=\"\(isTransient.xml)\""
        }

        if let defaultValueString = defaultValueString {
            output += " defaultValueString=\"\(defaultValueString)\""
        }
        if let defaultDateTimeInterval = defaultDateTimeInterval {
            output += " defaultDateTimeInterval=\"\(defaultDateTimeInterval)\""
        }
        if let minValueString = minValueString {
            output += " minValueString=\"\(minValueString)\""
        }
        if let maxValueString = maxValueString {
            output += " maxValueString=\"\(maxValueString)\""
        }

        output += " syncable=\"\(syncable.xml)\"/>"

        return output
    }

}

extension MomAttribute.AttributeType: XMLConvertible {

    public var xml: String {
        return self.rawValue
    }
}


// ----------------------------
//
// MomElement+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomElement: XMLConvertible {

    public var xml: String {
        return "<element name=\"\(name)\" positionX=\"\(positionX)\" positionY=\"\(positionY)\" width=\"\(width)\" height=\"\(height)\"/>"
    }

}


// ----------------------------
//
// MomEntity+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomEntity: XMLConvertible {

    public var xml: String {
        var output = "<entity name=\"\(name)\" representedClassName=\"\(representedClassName)\" syncable=\"\(syncable.xml)\" codeGenerationType=\"\(codeGenerationType)\">
"
        for attribute in attributes {
            output += attribute.xml
            output += "
"
        }
        for relation in relationship {
            output += relation.xml
            output += "
"
        }

        if !userInfo.isEmpty {
            output += userInfo.xml
            output += "
"
        }

        output += "</entity>"
        return output
    }
}


// ----------------------------
//
// MomModel+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomModel: XMLConvertible {

    public var xml: String {
        var output = "<model type=\"\(type)\" documentVersion=\"\(documentVersion)\""
        output += " lastSavedToolsVersion=\"\(lastSavedToolsVersion)\" systemVersion=\"\(systemVersion)\""
        output += " minimumToolsVersion=\"\(minimumToolsVersion)\" sourceLanguage=\"\(language)\""
        output += " userDefinedModelVersionIdentifier=\"\(userDefinedModelVersionIdentifier)\">
"

        for entity in entities {
            output += entity.xml
            output += "
"
        }

        if elements.isEmpty {
            output += "<elements/>"
        } else {
            output += " <elements>
"
            for element in elements {
                output += element.xml
                output += "
"
            }
            output += " </elements>
"
        }
        output += "</model>
"
        return output
    }

}


// ----------------------------
//
// MomRelationship+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomRelationship: XMLConvertible {

    public var xml: String {
        var output = "<relationship name=\"\(name)\" optional=\"\(isOptional.xml)\" toMany=\"\(isToMany.xml)\" ordered=\"\(isOrdered.xml)\" deletionRule=\"\(deletionRule.xml)\""
        if let maxCount = maxCount {
            output += " maxCount=\"\(maxCount)\""
        }
        if let minCount = minCount {
            output += " minCount=\"\(minCount)\""
        }
        output += " destinationEntity=\"\(destinationEntity)\""

        if let inverseName = inverseName, let inverseEntity = inverseEntity {
            output += " inverseName=\"\(inverseName)\" inverseEntity=\"\(inverseEntity)\""
        }

        output += " syncable=\"\(syncable.xml)\""

        if userInfo.isEmpty {
            output += "/>"
        } else {
            output += "
"
            output += userInfo.xml
            output += "
"
            output += "</relationship>"
        }

        return output
    }

}

extension MomRelationship.DeletionRule: XMLConvertible {

    public var xml: String {
        return self.rawValue
    }

}


// ----------------------------
//
// MomUserInfo+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

extension MomUserInfo: XMLConvertible {

    public var xml: String {
        var output = ""
        output += " <userInfo>
"
        for entry in entries {
            output += entry.xml
            output += "
"
        }
        output += " </userInfo>"

        return output
    }

}

extension MomUserInfoEntry: XMLConvertible {

    public var xml: String {
        return "<element key=\"\(key)\" value=\"\(value)\"/>"
    }

}


// ----------------------------
//
// MomXML+XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

extension MomXML: XMLConvertible {

    public var xml: String {
        var output = "<?xml version=\"\(version)\" encoding=\"\(encoding)\" standalone=\"\(standalone)\"?>
"
        output += model.xml
        return output
    }

}


// ----------------------------
//
// SWXMLHash+TypeConversion.swift
//
// ----------------------------

//
//  SWXMLHash+TypeConversion.swift
//  SWXMLHash
//
//  Created by Maciek Grzybowski on 29.02.2016.
//
//

// swiftlint:disable line_length
// swiftlint:disable file_length

import Foundation

// MARK: - XMLIndexerDeserializable

/// Provides XMLIndexer deserialization / type transformation support
public protocol XMLIndexerDeserializable {
    /// Method for deserializing elements from XMLIndexer
    static func deserialize(_ element: XMLIndexer) throws -> Self
}

/// Provides XMLIndexer deserialization / type transformation support
public extension XMLIndexerDeserializable {
    /**
    A default implementation that will throw an error if it is called

    - parameters:
        - element: the XMLIndexer to be deserialized
    - throws: an XMLDeserializationError.implementationIsMissing if no implementation is found
    - returns: this won't ever return because of the error being thrown
    */
    static func deserialize(_ element: XMLIndexer) throws -> Self {
        throw XMLDeserializationError.implementationIsMissing(
            method: "XMLIndexerDeserializable.deserialize(element: XMLIndexer)")
    }
}

// MARK: - XMLElementDeserializable

/// Provides XMLElement deserialization / type transformation support
public protocol XMLElementDeserializable {
    /// Method for deserializing elements from XMLElement
    static func deserialize(_ element: XMLElement) throws -> Self
}

/// Provides XMLElement deserialization / type transformation support
public extension XMLElementDeserializable {
    /**
    A default implementation that will throw an error if it is called

    - parameters:
        - element: the XMLElement to be deserialized
    - throws: an XMLDeserializationError.implementationIsMissing if no implementation is found
    - returns: this won't ever return because of the error being thrown
    */
    static func deserialize(_ element: XMLElement) throws -> Self {
        throw XMLDeserializationError.implementationIsMissing(
            method: "XMLElementDeserializable.deserialize(element: XMLElement)")
    }
}

// MARK: - XMLAttributeDeserializable

/// Provides XMLAttribute deserialization / type transformation support
public protocol XMLAttributeDeserializable {
    static func deserialize(_ attribute: XMLAttribute) throws -> Self
}

/// Provides XMLAttribute deserialization / type transformation support
public extension XMLAttributeDeserializable {
    /**
     A default implementation that will throw an error if it is called

     - parameters:
         - attribute: The XMLAttribute to be deserialized
     - throws: an XMLDeserializationError.implementationIsMissing if no implementation is found
     - returns: this won't ever return because of the error being thrown
     */
    static func deserialize(attribute: XMLAttribute) throws -> Self {
        throw XMLDeserializationError.implementationIsMissing(
            method: "XMLAttributeDeserializable(element: XMLAttribute)")
    }
}

// MARK: - XMLIndexer Extensions

public extension XMLIndexer {

    // MARK: - XMLAttributeDeserializable

    /**
     Attempts to deserialize the value of the specified attribute of the current XMLIndexer
     element to `T`

     - parameter attr: The attribute to deserialize
     - throws: an XMLDeserializationError if there is a problem with deserialization
     - returns: The deserialized `T` value
     */
    func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) throws -> T {
        switch self {
        case .element(let element):
            return try element.value(ofAttribute: attr)
        case .stream(let opStream):
            return try opStream.findElements().value(ofAttribute: attr)
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    /**
     Attempts to deserialize the value of the specified attribute of the current XMLIndexer
     element to `T?`

     - parameter attr: The attribute to deserialize
     - returns: The deserialized `T?` value, or nil if the attribute does not exist
     */
    func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) -> T? {
        switch self {
        case .element(let element):
            return element.value(ofAttribute: attr)
        case .stream(let opStream):
            return opStream.findElements().value(ofAttribute: attr)
        default:
            return nil
        }
    }

    /**
     Attempts to deserialize the value of the specified attribute of the current XMLIndexer
     element to `[T]`

     - parameter attr: The attribute to deserialize
     - throws: an XMLDeserializationError if there is a problem with deserialization
     - returns: The deserialized `[T]` value
     */
    func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) throws -> [T] {
        switch self {
        case .list(let elements):
            return try elements.map { try $0.value(ofAttribute: attr) }
        case .element(let element):
            return try [element].map { try $0.value(ofAttribute: attr) }
        case .stream(let opStream):
            return try opStream.findElements().value(ofAttribute: attr)
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    /**
     Attempts to deserialize the value of the specified attribute of the current XMLIndexer
     element to `[T]?`

     - parameter attr: The attribute to deserialize
     - throws: an XMLDeserializationError if there is a problem with deserialization
     - returns: The deserialized `[T]?` value
     */
    func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) throws -> [T]? {
        switch self {
        case .list(let elements):
            return try elements.map { try $0.value(ofAttribute: attr) }
        case .element(let element):
            return try [element].map { try $0.value(ofAttribute: attr) }
        case .stream(let opStream):
            return try opStream.findElements().value(ofAttribute: attr)
        default:
            return nil
        }
    }

    /**
     Attempts to deserialize the value of the specified attribute of the current XMLIndexer
     element to `[T?]`

     - parameter attr: The attribute to deserialize
     - throws: an XMLDeserializationError if there is a problem with deserialization
     - returns: The deserialized `[T?]` value
     */
    func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) throws -> [T?] {
        switch self {
        case .list(let elements):
            return elements.map { $0.value(ofAttribute: attr) }
        case .element(let element):
            return [element].map { $0.value(ofAttribute: attr) }
        case .stream(let opStream):
            return try opStream.findElements().value(ofAttribute: attr)
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    // MARK: - XMLElementDeserializable

    /**
    Attempts to deserialize the current XMLElement element to `T`

    - throws: an XMLDeserializationError.nodeIsInvalid if the current indexed level isn't an Element
    - returns: the deserialized `T` value
    */
    func value<T: XMLElementDeserializable>() throws -> T {
        switch self {
        case .element(let element):
            return try T.deserialize(element)
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    /**
    Attempts to deserialize the current XMLElement element to `T?`

    - returns: the deserialized `T?` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLElementDeserializable>() throws -> T? {
        switch self {
        case .element(let element):
            return try T.deserialize(element)
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return nil
        }
    }

    /**
    Attempts to deserialize the current XMLElement element to `[T]`

    - returns: the deserialized `[T]` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLElementDeserializable>() throws -> [T] {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize($0) }
        case .element(let element):
            return try [element].map { try T.deserialize($0) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return []
        }
    }

    /**
    Attempts to deserialize the current XMLElement element to `[T]?`

    - returns: the deserialized `[T]?` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLElementDeserializable>() throws -> [T]? {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize($0) }
        case .element(let element):
            return try [element].map { try T.deserialize($0) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return nil
        }
    }

    /**
    Attempts to deserialize the current XMLElement element to `[T?]`

    - returns: the deserialized `[T?]` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLElementDeserializable>() throws -> [T?] {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize($0) }
        case .element(let element):
            return try [element].map { try T.deserialize($0) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return []
        }
    }

    // MARK: - XMLIndexerDeserializable

    /**
    Attempts to deserialize the current XMLIndexer element to `T`

    - returns: the deserialized `T` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLIndexerDeserializable>() throws -> T {
        switch self {
        case .element:
            return try T.deserialize(self)
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    /**
    Attempts to deserialize the current XMLIndexer element to `T?`

    - returns: the deserialized `T?` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLIndexerDeserializable>() throws -> T? {
        switch self {
        case .element:
            return try T.deserialize(self)
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return nil
        }
    }

    /**
    Attempts to deserialize the current XMLIndexer element to `[T]`

    - returns: the deserialized `[T]` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T>() throws -> [T] where T: XMLIndexerDeserializable {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize( XMLIndexer($0) ) }
        case .element(let element):
            return try [element].map { try T.deserialize( XMLIndexer($0) ) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }

    /**
    Attempts to deserialize the current XMLIndexer element to `[T]?`

    - returns: the deserialized `[T]?` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLIndexerDeserializable>() throws -> [T]? {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize( XMLIndexer($0) ) }
        case .element(let element):
            return try [element].map { try T.deserialize( XMLIndexer($0) ) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            return nil
        }
    }

    /**
    Attempts to deserialize the current XMLIndexer element to `[T?]`

    - returns: the deserialized `[T?]` value
    - throws: an XMLDeserializationError is there is a problem with deserialization
    */
    func value<T: XMLIndexerDeserializable>() throws -> [T?] {
        switch self {
        case .list(let elements):
            return try elements.map { try T.deserialize( XMLIndexer($0) ) }
        case .element(let element):
            return try [element].map { try T.deserialize( XMLIndexer($0) ) }
        case .stream(let opStream):
            return try opStream.findElements().value()
        default:
            throw XMLDeserializationError.nodeIsInvalid(node: self)
        }
    }
}

// MARK: - XMLElement Extensions

extension XMLElement {

    /**
     Attempts to deserialize the specified attribute of the current XMLElement to `T`

     - parameter attr: The attribute to deserialize
     - throws: an XMLDeserializationError if there is a problem with deserialization
     - returns: The deserialized `T` value
     */
    public func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) throws -> T {
        if let attr = self.attribute(by: attr) {
            return try T.deserialize(attr)
        } else {
            throw XMLDeserializationError.attributeDoesNotExist(element: self, attribute: attr)
        }
    }

    /**
     Attempts to deserialize the specified attribute of the current XMLElement to `T?`

     - parameter attr: The attribute to deserialize
     - returns: The deserialized `T?` value, or nil if the attribute does not exist.
     */
    public func value<T: XMLAttributeDeserializable>(ofAttribute attr: String) -> T? {
        if let attr = self.attribute(by: attr) {
            return try? T.deserialize(attr)
        } else {
            return nil
        }
    }

    /**
     Gets the text associated with this element, or throws an exception if the text is empty

     - throws: XMLDeserializationError.nodeHasNoValue if the element text is empty
     - returns: The element text
     */
    internal func nonEmptyTextOrThrow() throws -> String {
        let textVal = text
        if !textVal.characters.isEmpty {
            return textVal
        }

        throw XMLDeserializationError.nodeHasNoValue
    }
}

// MARK: - XMLDeserializationError

/// The error that is thrown if there is a problem with deserialization
public enum XMLDeserializationError: Error, CustomStringConvertible {
    case implementationIsMissing(method: String)
    case nodeIsInvalid(node: XMLIndexer)
    case nodeHasNoValue
    case typeConversionFailed(type: String, element: XMLElement)
    case attributeDoesNotExist(element: XMLElement, attribute: String)
    case attributeDeserializationFailed(type: String, attribute: XMLAttribute)

// swiftlint:disable identifier_name
    @available(*, unavailable, renamed: "implementationIsMissing(method:)")
    public static func ImplementationIsMissing(method: String) -> XMLDeserializationError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "nodeHasNoValue(_:)")
    public static func NodeHasNoValue(_: IndexOps) -> XMLDeserializationError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "typeConversionFailed(_:)")
    public static func TypeConversionFailed(_: IndexingError) -> XMLDeserializationError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "attributeDoesNotExist(_:_:)")
    public static func AttributeDoesNotExist(_ attr: String, _ value: String) throws -> XMLDeserializationError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "attributeDeserializationFailed(_:_:)")
    public static func AttributeDeserializationFailed(_ attr: String, _ value: String) throws -> XMLDeserializationError {
        fatalError("unavailable")
    }
// swiftlint:enable identifier_name

    /// The text description for the error thrown
    public var description: String {
        switch self {
        case .implementationIsMissing(let method):
            return "This deserialization method is not implemented: \(method)"
        case .nodeIsInvalid(let node):
            return "This node is invalid: \(node)"
        case .nodeHasNoValue:
            return "This node is empty"
        case .typeConversionFailed(let type, let node):
            return "Can't convert node \(node) to value of type \(type)"
        case .attributeDoesNotExist(let element, let attribute):
            return "Element \(element) does not contain attribute: \(attribute)"
        case .attributeDeserializationFailed(let type, let attribute):
            return "Can't convert attribute \(attribute) to value of type \(type)"
        }
    }
}

// MARK: - Common types deserialization

extension String: XMLElementDeserializable, XMLAttributeDeserializable {
    /**
    Attempts to deserialize XML element content to a String

    - parameters:
        - element: the XMLElement to be deserialized
    - throws: an XMLDeserializationError.typeConversionFailed if the element cannot be deserialized
    - returns: the deserialized String value
    */
    public static func deserialize(_ element: XMLElement) -> String {
        return element.text
    }

    /**
     Attempts to deserialize XML Attribute content to a String

     - parameter attribute: the XMLAttribute to be deserialized
     - returns: the deserialized String value
     */
    public static func deserialize(_ attribute: XMLAttribute) -> String {
        return attribute.text
    }
}

extension Int: XMLElementDeserializable, XMLAttributeDeserializable {
    /**
    Attempts to deserialize XML element content to a Int

    - parameters:
        - element: the XMLElement to be deserialized
    - throws: an XMLDeserializationError.typeConversionFailed if the element cannot be deserialized
    - returns: the deserialized Int value
    */
    public static func deserialize(_ element: XMLElement) throws -> Int {
        guard let value = Int(try element.nonEmptyTextOrThrow()) else {
            throw XMLDeserializationError.typeConversionFailed(type: "Int", element: element)
        }
        return value
    }

    /**
     Attempts to deserialize XML attribute content to an Int

     - parameter attribute: The XMLAttribute to be deserialized
     - throws: an XMLDeserializationError.attributeDeserializationFailed if the attribute cannot be
               deserialized
     - returns: the deserialized Int value
     */
    public static func deserialize(_ attribute: XMLAttribute) throws -> Int {
        guard let value = Int(attribute.text) else {
            throw XMLDeserializationError.attributeDeserializationFailed(
                type: "Int", attribute: attribute)
        }
        return value
    }
}

extension Double: XMLElementDeserializable, XMLAttributeDeserializable {
    /**
    Attempts to deserialize XML element content to a Double

    - parameters:
        - element: the XMLElement to be deserialized
    - throws: an XMLDeserializationError.typeConversionFailed if the element cannot be deserialized
    - returns: the deserialized Double value
    */
    public static func deserialize(_ element: XMLElement) throws -> Double {
        guard let value = Double(try element.nonEmptyTextOrThrow()) else {
            throw XMLDeserializationError.typeConversionFailed(type: "Double", element: element)
        }
        return value
    }

    /**
     Attempts to deserialize XML attribute content to a Double

     - parameter attribute: The XMLAttribute to be deserialized
     - throws: an XMLDeserializationError.attributeDeserializationFailed if the attribute cannot be
               deserialized
     - returns: the deserialized Double value
     */
    public static func deserialize(_ attribute: XMLAttribute) throws -> Double {
        guard let value = Double(attribute.text) else {
            throw XMLDeserializationError.attributeDeserializationFailed(
                type: "Double", attribute: attribute)
        }
        return value
    }
}

extension Float: XMLElementDeserializable, XMLAttributeDeserializable {
    /**
    Attempts to deserialize XML element content to a Float

    - parameters:
        - element: the XMLElement to be deserialized
    - throws: an XMLDeserializationError.typeConversionFailed if the element cannot be deserialized
    - returns: the deserialized Float value
    */
    public static func deserialize(_ element: XMLElement) throws -> Float {
        guard let value = Float(try element.nonEmptyTextOrThrow()) else {
            throw XMLDeserializationError.typeConversionFailed(type: "Float", element: element)
        }
        return value
    }

    /**
     Attempts to deserialize XML attribute content to a Float

     - parameter attribute: The XMLAttribute to be deserialized
     - throws: an XMLDeserializationError.attributeDeserializationFailed if the attribute cannot be
               deserialized
     - returns: the deserialized Float value
     */
    public static func deserialize(_ attribute: XMLAttribute) throws -> Float {
        guard let value = Float(attribute.text) else {
            throw XMLDeserializationError.attributeDeserializationFailed(
                type: "Float", attribute: attribute)
        }
        return value
    }
}

extension Bool: XMLElementDeserializable, XMLAttributeDeserializable {
    // swiftlint:disable line_length
    /**
     Attempts to deserialize XML element content to a Bool. This uses NSString's 'boolValue'
     described [here](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/#//apple_ref/occ/instp/NSString/boolValue)

     - parameters:
        - element: the XMLElement to be deserialized
     - throws: an XMLDeserializationError.typeConversionFailed if the element cannot be deserialized
     - returns: the deserialized Bool value
     */
    public static func deserialize(_ element: XMLElement) throws -> Bool {
        let value = Bool(NSString(string: try element.nonEmptyTextOrThrow()).boolValue)
        return value
    }

    /**
     Attempts to deserialize XML attribute content to a Bool. This uses NSString's 'boolValue'
     described [here](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/#//apple_ref/occ/instp/NSString/boolValue)

     - parameter attribute: The XMLAttribute to be deserialized
     - throws: an XMLDeserializationError.attributeDeserializationFailed if the attribute cannot be
               deserialized
     - returns: the deserialized Bool value
     */
    public static func deserialize(_ attribute: XMLAttribute) throws -> Bool {
        let value = Bool(NSString(string: attribute.text).boolValue)
        return value
    }
    // swiftlint:enable line_length
}


// ----------------------------
//
// XMLObject.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation
import SWXMLHash

public typealias XML = XMLIndexer

public protocol XMLObject {

    init?(xml: XML)

}

extension String {

    var toInt: Int? {
        return Int(self)
    }
    var toBool: Bool? {
        return Bool(self)
    }
}


// ----------------------------
//
// MomAttribute.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomAttribute {

    public var name: String
    public var attributeType: AttributeType

    public var defaultValueString: String?
    public var defaultDateTimeInterval: String?
    public var minValueString: String?
    public var maxValueString: String?

    public var syncable: Bool = true
    public var isOptional: Bool = false
    public var isTransient: Bool = false
    public var isIndexed: Bool = true
    public var usesScalarValueType: Bool = false

    public init(name: String, attributeType: AttributeType, isOptional: Bool = false, isTransient: Bool = false) {
        self.name = name
        self.attributeType = attributeType
        self.isOptional = isOptional
        self.isTransient = isTransient
    }

    public enum AttributeType: String {
        case boolean = "Boolean"
        case string = "String"
        case date = "Date"
        case float = "Float"
        case decimal = "Decimal"
        case double = "Double"
        case binary = "Binary"
        case integer16 = "Integer 16"
        case integer32 = "Integer 32"
        case integer64 = "Integer 64"
        case transformable = "Transformable"
        case undefined = "Undefined"
        case objectID = "ObjectID"
    }

}


// ----------------------------
//
// MomElement.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomElement {

    public var name: String
    public var positionX: Int = 0
    public var positionY: Int = 0
    public var width: Int = 128
    public var height: Int = 128

    public init(name: String, positionX: Int = 0, positionY: Int = 0, width: Int = 0, height: Int = 0) {
        self.name = name
        self.positionX = positionX
        self.positionY = positionY
        self.width = width
        self.height = height
    }

}


// ----------------------------
//
// MomEntity.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomEntity {

    public var name: String
    public var representedClassName: String
    public var syncable: Bool = true
    public var codeGenerationType: String
    public var userInfo = MomUserInfo()

    //TODO public var elementID: String?
    //TODO public var versionHashModifier: String?

    public init(name: String, representedClassName: String? = nil, codeGenerationType: String = "class") {
        self.name = name
        self.representedClassName = representedClassName ?? name
        self.codeGenerationType = codeGenerationType
    }

    public var attributes: [MomAttribute] = []
    public var relationship: [MomRelationship] = []
    // TODO MomCompoundIndex
    // TODO MomUniquenessConstraint
}


// ----------------------------
//
// MomModel.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomModel {

    public var type = "com.apple.IDECoreDataModeler.DataModel"
    public var documentVersion = "1.0"
    public var lastSavedToolsVersion = "12141"
    public var systemVersion = "16E195"
    public var minimumToolsVersion = "Automatic"
    public var language = "Swift"
    public var userDefinedModelVersionIdentifier = ""

    public var entities: [MomEntity] = []
    public var elements: [MomElement] = []

    public init() {}
}

extension MomModel {

    public func check() -> Bool {
        if entities.count != elements.count {
            return false
        }
        let hasElementForEntity = entities.map { $0.name }.sorted() == elements.map { $0.name }.sorted()
        if !hasElementForEntity {
            return false
        }
        // XXX could check also inversed relationship coherences
        return true
    }

    public func moveElements() {
        // TODO move elements to not be at same place
    }

}


// ----------------------------
//
// MomRelationship.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomRelationship {

    var userInfo = MomUserInfo()

    var name: String
    var isOptional: Bool
    var isOrdered: Bool

    var isToMany: Bool
    var maxCount: Int?
    var minCount: Int?

    var deletionRule: DeletionRule = .nullify

    var destinationEntity: String

    var syncable: Bool = true

    var inverseName: String?
    var inverseEntity: String?

    public init(name: String, destinationEntity: String, isToMany: Bool = false, isOrdered: Bool = false, isOptional: Bool = false) {
        self.name = name
        self.isToMany = isToMany
        self.isOrdered = isOrdered
        self.isOptional = isOptional
        self.destinationEntity = destinationEntity
    }

}

extension MomRelationship {

    public enum DeletionRule: String {
        case cascade = "Cascade"
        case nullify = "Nulliffy"
        case noAction = "No Action"
        case deny = "Deny"
    }

}


// ----------------------------
//
// MomUserInfo.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public struct MomUserInfo {

    public var entries: [MomUserInfoEntry] = []

    public mutating func add(key: String, value: String) {
        entries.append(MomUserInfoEntry(key: key, value: value))
    }

    public var isEmpty: Bool {
        return entries.isEmpty
    }

    public init() {}

    public init(userInfo: [AnyHashable : Any]) {
        entries = userInfo.map { MomUserInfoEntry(key: "\($0.key)", value: "\($0.value)") }
    }
}

public struct MomUserInfoEntry {

    public var key: String
    public var value: String

}


// ----------------------------
//
// MomXML.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import Foundation

public struct MomXML {

    public var version = "1.0"
    public var encoding = "UTF-8"
    public var standalone = "yes"

    public var model = MomModel()

    public init() {}
}


// ----------------------------
//
// XMLConvertible.swift
//
// ----------------------------

//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 anass talii. All rights reserved.
//

import Foundation

public protocol XMLConvertible {
    var xml: String { get }
}

extension Bool: XMLConvertible {
    public var xml: String {
        return self ? "YES": "NO"
    }
}


// ----------------------------
//
// MomXMLTests.swift
//
// ----------------------------

//
//  MomXMLTests.swift
//  MomXMLTests
//
//  Created by anass talii on 07/06/2017.
//  Copyright © 2017 phimage. All rights reserved.
//

import XCTest
@testable import MomXML
import SWXMLHash

class MomXMLTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateReadEmpty() {
        let mom = MomXML()

        let xmlString = mom.xml
        XCTAssertFalse(xmlString.isEmpty)
        
        let xml = SWXMLHash.parse(xmlString)

        let parsedMom = MomXML(xml: xml)
        XCTAssertNotNil(parsedMom)

        /// XXX Before comparing maybe do an xmlLint or do a better xml compare
        XCTAssertEqual(parsedMom!.xml, xmlString)
    }
    // momXML; userinfo
    //entity ; Element; Attribut; model;  ; relationship ;
    func testMomEntityEmpty(){
        var momXML = MomXML()
        let entityPersonne = MomEntity(name: "Personne")
        let entityStatus = MomEntity(name: "Status")
        let entityFunction = MomEntity(name: "Function")
        
        let elementPersonne = MomElement.init(name: "Personne")
        let elementStatus = MomElement.init(name: "Status")
        let elementFunction = MomElement.init(name: "Function")

        momXML.model.entities.append(entityPersonne)
        momXML.model.entities.append(entityStatus)
        momXML.model.entities.append(entityFunction)
        
        momXML.model.elements.append(elementPersonne)
        momXML.model.elements.append(elementStatus)
        momXML.model.elements.append(elementFunction)
        
        let xmlString = momXML.xml
        print(xmlString)
        
        XCTAssertFalse(xmlString.isEmpty)
        
        let xml = SWXMLHash.parse(xmlString)
        
        let parsedMom = MomXML(xml: xml)
        XCTAssertNotNil(parsedMom)
    }
    func testEntityWithAttribut(){
        var momXML = MomXML()
        var entitySociete = MomEntity(name: "Societe")
        let attrFirstName = MomAttribute.init(name: "name", attributeType: MomAttribute.AttributeType.string)
        let attrlastName = MomAttribute.init(name: "adresse", attributeType: MomAttribute.AttributeType.string)
        let attrIdSociete = MomAttribute.init(name: "id", attributeType: MomAttribute.AttributeType.integer16)
        entitySociete.attributes.append(attrFirstName)
        entitySociete.attributes.append(attrlastName)
        entitySociete.attributes.append(attrIdSociete)
        
        var entityFournissieur = MomEntity(name: "Fournissieur")
        let attrFirstNameFournissieur = MomAttribute.init(name: "firstname", attributeType: MomAttribute.AttributeType.string)
        let attrlastNameFournissieur = MomAttribute.init(name: "lastname", attributeType: MomAttribute.AttributeType.string)
        let attrIdClient = MomAttribute.init(name: "id", attributeType: MomAttribute.AttributeType.integer16)
        entityFournissieur.attributes.append(attrFirstNameFournissieur)
        entityFournissieur.attributes.append(attrlastNameFournissieur)
        entityFournissieur.attributes.append(attrIdClient)
        
        let elementSociete = MomElement.init(name: "Societe")
        let elementFournissieur = MomElement.init(name: "Status")
        
        momXML.model.entities.append(entitySociete)
        momXML.model.entities.append(entityFournissieur)
        
        momXML.model.elements.append(elementSociete)
        momXML.model.elements.append(elementFournissieur)
        
        
        let xmlString = momXML.xml
        print(xmlString)
        
        XCTAssertFalse(xmlString.isEmpty)
        
        let xml = SWXMLHash.parse(xmlString)
        
        let parsedMom = MomXML(xml: xml)
        XCTAssertNotNil(parsedMom)
        
    }
    func testMomEntityWithRelation() {
        var momXML = MomXML()
        var entityClient = MomEntity(name: "Client")
        let attrFirstName = MomAttribute.init(name: "firstname", attributeType: MomAttribute.AttributeType.string)
        let attrlastName = MomAttribute.init(name: "lastname", attributeType: MomAttribute.AttributeType.string)
        let attrIdClient = MomAttribute.init(name: "id", attributeType: MomAttribute.AttributeType.integer16)
        entityClient.attributes.append(attrFirstName)
        entityClient.attributes.append(attrlastName)
        entityClient.attributes.append(attrIdClient)
        entityClient.userInfo.add(key: "name1", value: "valuename1")
        let myrelationshipClient = MomRelationship.init(name: "client_commande", destinationEntity: "Commande")
        entityClient.relationship.append(myrelationshipClient)
        
        
        var entityCommande = MomEntity(name: "Commande")
        let attrDate = MomAttribute.init(name: "date", attributeType: MomAttribute.AttributeType.date)
        let attrDescriptionCommande = MomAttribute.init(name: "descriptioncommande", attributeType: MomAttribute.AttributeType.string)
        let attrIdCommande = MomAttribute.init(name: "id", attributeType: MomAttribute.AttributeType.integer16)
        entityCommande.attributes.append(attrIdCommande)
        entityCommande.attributes.append(attrDate)
        entityCommande.attributes.append(attrDescriptionCommande)
        entityCommande.userInfo.add(key: "name2", value: "valuename2")
        let myrelationshipCommande = MomRelationship.init(name: "commande_client", destinationEntity: "Client")
        let myrelationshipCommande2 = MomRelationship.init(name: "commande_produit", destinationEntity: "Produit")
        entityCommande.relationship.append(myrelationshipCommande)
        entityCommande.relationship.append(myrelationshipCommande2)
        
        var entityProduit = MomEntity(name: "Produit")
        let attrName = MomAttribute.init(name: "name", attributeType: MomAttribute.AttributeType.string)
        let attrPrix = MomAttribute.init(name: "prix", attributeType: MomAttribute.AttributeType.double)
        let attrReference = MomAttribute.init(name: "reference", attributeType: MomAttribute.AttributeType.string)
        let attrIdProduit = MomAttribute.init(name: "id", attributeType: MomAttribute.AttributeType.integer16)
        entityProduit.attributes.append(attrIdProduit)
        entityProduit.attributes.append(attrName)
        entityProduit.attributes.append(attrPrix)
        entityProduit.attributes.append(attrReference)
        let myrelationshipProduit = MomRelationship.init(name: "produit_commande", destinationEntity: "Commande")
        entityProduit.relationship.append(myrelationshipProduit)
        
        let elementClient = MomElement.init(name: "Client", positionX: 106, positionY: -45, width: 128, height: 118)
        let elementProduit = MomElement.init(name: "Produit")
        let elementCommande = MomElement.init(name: "Commande")
        
        var momModel = MomModel()
        momModel.entities.append(entityClient)
        momModel.entities.append(entityProduit)
        momModel.entities.append(entityCommande)
        
        momModel.elements.append(elementClient)
        momModel.elements.append(elementCommande)
        momModel.elements.append(elementProduit)
        
        XCTAssertEqual(momModel.check(), true)
        momModel.moveElements()
        
        momXML.model = momModel
        
        let xmlString = momXML.xml
        print(xmlString)
        
        XCTAssertFalse(xmlString.isEmpty)
        
        let xml = SWXMLHash.parse(xmlString)
        
        let parsedMom = MomXML(xml: xml)
        XCTAssertNotNil(parsedMom)
    }
    
    func testEquatableAttribute(){
        //attribut
        let attrName = MomAttribute(name: "name", attributeType: .string)
        XCTAssertEqual(attrName, attrName)
        XCTAssertEqual(attrName, MomAttribute(name: "name", attributeType: .string))
        
        
        XCTAssertNotEqual(attrName, MomAttribute(name: "name", attributeType: .integer16), "attributeType different")
        XCTAssertNotEqual(attrName, MomAttribute(name: "name2", attributeType: .string), "name different")
        
        
        XCTAssertNotEqual(attrName, MomAttribute(name: "name", attributeType: .string, isOptional: true), "isOptional different")
    }
    
    func testEquatableElement(){
        //elements
        let elementClient = MomElement(name: "Client", positionX: 106, positionY: -45, width: 128, height: 118)
        XCTAssertEqual(elementClient, elementClient)
        XCTAssertEqual(elementClient, MomElement(name: "Client", positionX: 106, positionY: -45, width: 128, height: 118))
        
        
        XCTAssertNotEqual(elementClient, MomElement(name: "Client2", positionX: 106, positionY: -45, width: 128, height: 118), "name different")
        XCTAssertNotEqual(elementClient, MomElement(name: "Client", positionX: 588, positionY: -45, width: 128, height: 118), "positionX different")
        XCTAssertNotEqual(elementClient, MomElement(name: "Client", positionX: 106, positionY: 454, width: 128, height: 118), "positionY different")
        XCTAssertNotEqual(elementClient, MomElement(name: "Client", positionX: 106, positionY: -45, width: 44, height: 118), "width different")
        XCTAssertNotEqual(elementClient, MomElement(name: "Client", positionX: 106, positionY: -45, width: 128, height: 1), "height different")
    }

    func testEquatableRelationship(){
        //relationship
        let myrelationshipProduit = MomRelationship(name: "produit_commande", destinationEntity: "Commande")
        XCTAssertEqual(myrelationshipProduit, myrelationshipProduit)
        XCTAssertEqual(myrelationshipProduit, MomRelationship(name: "produit_commande", destinationEntity: "Commande"))
        
        
        XCTAssertNotEqual(myrelationshipProduit, MomRelationship(name: "produit_command", destinationEntity: "Commande"), "name different")

        var myrelationshipProduit2 = MomRelationship(name: "produit_commande", destinationEntity: "Commande")
        myrelationshipProduit2.deletionRule = .deny
        XCTAssertNotEqual(myrelationshipProduit2, myrelationshipProduit, "deletionRule different")
    }

    func testEquatable(){
        //entity
        var entityClient = MomEntity(name: "Client")
        let attrFirstName = MomAttribute(name: "firstname", attributeType: .string)
        let attrlastName = MomAttribute(name: "lastname", attributeType: .string)
        let attrIdClient = MomAttribute(name: "id", attributeType: .integer16)
        entityClient.attributes.append(attrFirstName)
        entityClient.attributes.append(attrlastName)
        entityClient.attributes.append(attrIdClient)
        entityClient.userInfo.add(key: "name1", value: "valuename1")
        let myrelationshipClient = MomRelationship(name: "client_commande", destinationEntity: "Commande")
        entityClient.relationship.append(myrelationshipClient)
        XCTAssertEqual(entityClient, entityClient)

        //model
        var momModel = MomModel()
        momModel.entities.append(entityClient)
        let elementClient = MomElement(name: "Client", positionX: 106, positionY: -45, width: 128, height: 118)
        momModel.elements.append(elementClient)
        XCTAssertEqual(momModel, momModel)
        //MomXML
        var momXML = MomXML()
        momXML.model.entities.append(entityClient)
        momXML.model.elements.append(elementClient)
        XCTAssertEqual(momXML, momXML)
        
        
        var momXML2 = MomXML()
        momXML2.model.entities.append(entityClient)
        momXML2.model.elements.append(elementClient)
        XCTAssertEqual(momXML, momXML2)
        
        let momXML3 = MomXML()
        XCTAssertNotEqual(momXML3, momXML)

        let momXML4 = MomXML()
        momXML2.model.entities.append(MomEntity(name: "Client4"))
        momXML2.model.elements.append(MomElement(name: "Client4", positionX: 106, positionY: -45, width: 128, height: 118))
        XCTAssertNotEqual(momXML4, momXML)
    }
    
    // MARK: test from files
    
    func testXMLToMomModel1() {
        if let url = Bundle(for: MomXMLTests.self).url(forResource: "model", withExtension: "xml") {
            do {
                let xmlString = try String(contentsOf: url)
                let xml = SWXMLHash.parse(xmlString)
                guard let parsedMom = MomXML(xml: xml) else {
                    XCTFail("Failed to parse xml")
                    return
                }
                let momModel = parsedMom.model
                //print(xml)
                //print("++++++++")
                //print(momModel.xml)
                let momEntities = momModel.entities
                let momElements = momModel.elements
                var entites: [MomEntity] = []
                var elements: [MomElement] = []
                
                for entity in momEntities {
                    entites.append(entity)
                    print(entity.name)
                    for attr in entity.attributes {
                        print("\(attr.name)  \(attr.attributeType)")
                    }
                    for attr in entity.relationship {
                        print("\(attr.name)  \(attr.destinationEntity)")
                    }
                }
                
                for element in momElements {
                    elements.append(element)
                    print(element.name)
                }
                XCTAssertEqual(momEntities.count, momElements.count)

                /// Important test, check that rendered data it's same as parsed data
                let xmlFromParsed = parsedMom.xml
                // print(xmlFromParsed)
                let recreatedMom = MomXML(xml: SWXMLHash.parse(xmlFromParsed))
                XCTAssertEqual(recreatedMom, parsedMom)
                
            } catch {
                XCTFail("Unable to read test file Model \(error)")
            }
        } else {
            XCTFail("Unable to get test file Model")
        }
    }
    func testXMLToMomModel2() {
        if let url = Bundle(for: MomXMLTests.self).url(forResource: "model2", withExtension: "xml") {
            do {
                let xmlString = try String(contentsOf: url)
                let xml = SWXMLHash.parse(xmlString)
                guard let parsedMom = MomXML(xml: xml) else {
                    XCTFail("Failed to parse xml")
                    return
                }
                let momModel = parsedMom.model
                let momEntities = momModel.entities
                let momElements = momModel.elements
                var entites: [MomEntity] = []
                var elements: [MomElement] = []
                
                for entity in momEntities {
                    entites.append(entity)
                    print(entity.name)
                    for attr in entity.attributes {
                        print("\(attr.name)  \(attr.attributeType)")
                    }
                    for attr in entity.relationship {
                        print("\(attr.name)  \(attr.destinationEntity)")
                    }
                }
                print("+++ elements :")
                for element in momElements {
                    elements.append(element)
                    print(element.name)
                }
                XCTAssertEqual(momEntities.count, momElements.count)
                
                /// Important test, check that rendered data it's same as parsed data
                let xmlFromParsed = parsedMom.xml
                // print(xmlFromParsed)
                let recreatedMom = MomXML(xml: SWXMLHash.parse(xmlFromParsed))
                XCTAssertEqual(recreatedMom, parsedMom)
            } catch {
                XCTFail("Unable to read test file Model \(error)")
            }
        } else {
            XCTFail("Unable to get test file Model")
        }
    }
    
    func testJsonToXML() {
        if let url = Bundle(for: MomXMLTests.self).url(forResource: "modelJsonToXML", withExtension: "xml") {
            do {
                let xmlString = try String(contentsOf: url)
                let xml = SWXMLHash.parse(xmlString)
                guard let parsedMom = MomXML(xml: xml) else {
                    XCTFail("Failed to parse xml")
                    return
                }
                let momModel = parsedMom.model
                let momEntities = momModel.entities
                let momElements = momModel.elements
                var entites: [MomEntity] = []
                var elements: [MomElement] = []
                
                for entity in momEntities {
                    entites.append(entity)
                    print(entity.name)
                    for attr in entity.attributes {
                        print("\(attr.name)  \(attr.attributeType)")
                    }
                    for attr in entity.relationship {
                        print("\(attr.name)  \(attr.destinationEntity)")
                    }
                }
                
                for element in momElements {
                    elements.append(element)
                    print(element.name)
                }
                XCTAssertEqual(momEntities.count, momElements.count)
                
                /// Important test, check that rendered data it's same as parsed data
                let xmlFromParsed = parsedMom.xml
                // print(xmlFromParsed)
                let recreatedMom = MomXML(xml: SWXMLHash.parse(xmlFromParsed))
                XCTAssertEqual(recreatedMom, parsedMom)
            } catch {
                XCTFail("Unable to read test file Model \(error)")
            }
        } else {
            XCTFail("Unable to get test file Model")
        }
    }

}


// ----------------------------
//
// Package.swift
//
// ----------------------------

import PackageDescription

let package = Package(
  name: "SWXMLHash"
)


// ----------------------------
//
// SWXMLHash.swift
//
// ----------------------------

//
//  SWXMLHash.swift
//
//  Copyright (c) 2014 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

// swiftlint exceptions:
// - Disabled file_length because there are a number of users that still pull the
//   source down as is and it makes pulling the code into a project easier.

// swiftlint:disable file_length

import Foundation

let rootElementName = "SWXMLHash_Root_Element"

/// Parser options
public class SWXMLHashOptions {
    internal init() {}

    /// determines whether to parse the XML with lazy parsing or not
    public var shouldProcessLazily = false

    /// determines whether to parse XML namespaces or not (forwards to
    /// `XMLParser.shouldProcessNamespaces`)
    public var shouldProcessNamespaces = false

    /// Matching element names, element values, attribute names, attribute values
    /// will be case insensitive. This will not affect parsing (data does not change)
    public var caseInsensitive = false
}

/// Simple XML parser
public class SWXMLHash {
    let options: SWXMLHashOptions

    private init(_ options: SWXMLHashOptions = SWXMLHashOptions()) {
        self.options = options
    }

    /**
    Method to configure how parsing works.

    - parameters:
        - configAction: a block that passes in an `SWXMLHashOptions` object with
        options to be set
    - returns: an `SWXMLHash` instance
    */
    class public func config(_ configAction: (SWXMLHashOptions) -> Void) -> SWXMLHash {
        let opts = SWXMLHashOptions()
        configAction(opts)
        return SWXMLHash(opts)
    }

    /**
    Begins parsing the passed in XML string.

    - parameters:
        - xml: an XML string. __Note__ that this is not a URL but a
        string containing XML.
    - returns: an `XMLIndexer` instance that can be iterated over
    */
    public func parse(_ xml: String) -> XMLIndexer {
        return parse(xml.data(using: String.Encoding.utf8)!)
    }

    /**
    Begins parsing the passed in XML string.

    - parameters:
        - data: a `Data` instance containing XML
        - returns: an `XMLIndexer` instance that can be iterated over
    */
    public func parse(_ data: Data) -> XMLIndexer {
        let parser: SimpleXmlParser = options.shouldProcessLazily
            ? LazyXMLParser(options)
            : FullXMLParser(options)
        return parser.parse(data)
    }

    /**
    Method to parse XML passed in as a string.

    - parameter xml: The XML to be parsed
    - returns: An XMLIndexer instance that is used to look up elements in the XML
    */
    class public func parse(_ xml: String) -> XMLIndexer {
        return SWXMLHash().parse(xml)
    }

    /**
    Method to parse XML passed in as a Data instance.

    - parameter data: The XML to be parsed
    - returns: An XMLIndexer instance that is used to look up elements in the XML
    */
    class public func parse(_ data: Data) -> XMLIndexer {
        return SWXMLHash().parse(data)
    }

    /**
    Method to lazily parse XML passed in as a string.

    - parameter xml: The XML to be parsed
    - returns: An XMLIndexer instance that is used to look up elements in the XML
    */
    class public func lazy(_ xml: String) -> XMLIndexer {
        return config { conf in conf.shouldProcessLazily = true }.parse(xml)
    }

    /**
    Method to lazily parse XML passed in as a Data instance.

    - parameter data: The XML to be parsed
    - returns: An XMLIndexer instance that is used to look up elements in the XML
    */
    class public func lazy(_ data: Data) -> XMLIndexer {
        return config { conf in conf.shouldProcessLazily = true }.parse(data)
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    mutating func drop() {
        _ = pop()
    }
    mutating func removeAll() {
        items.removeAll(keepingCapacity: false)
    }
    func top() -> T {
        return items[items.count - 1]
    }
}

protocol SimpleXmlParser {
    init(_ options: SWXMLHashOptions)
    func parse(_ data: Data) -> XMLIndexer
}

#if os(Linux)

extension XMLParserDelegate {

    func parserDidStartDocument(_ parser: Foundation.XMLParser) { }
    func parserDidEndDocument(_ parser: Foundation.XMLParser) { }

    func parser(_ parser: Foundation.XMLParser,
                foundNotationDeclarationWithName name: String,
                publicID: String?,
                systemID: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                foundUnparsedEntityDeclarationWithName name: String,
                publicID: String?,
                systemID: String?,
                notationName: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                foundAttributeDeclarationWithName attributeName: String,
                forElement elementName: String,
                type: String?,
                defaultValue: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                foundElementDeclarationWithName elementName: String,
                model: String) { }

    func parser(_ parser: Foundation.XMLParser,
                foundInternalEntityDeclarationWithName name: String,
                value: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                foundExternalEntityDeclarationWithName name: String,
                publicID: String?,
                systemID: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) { }

    func parser(_ parser: Foundation.XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) { }

    func parser(_ parser: Foundation.XMLParser,
                didStartMappingPrefix prefix: String,
                toURI namespaceURI: String) { }

    func parser(_ parser: Foundation.XMLParser, didEndMappingPrefix prefix: String) { }

    func parser(_ parser: Foundation.XMLParser, foundCharacters string: String) { }

    func parser(_ parser: Foundation.XMLParser,
                foundIgnorableWhitespace whitespaceString: String) { }

    func parser(_ parser: Foundation.XMLParser,
                foundProcessingInstructionWithTarget target: String,
                data: String?) { }

    func parser(_ parser: Foundation.XMLParser, foundComment comment: String) { }

    func parser(_ parser: Foundation.XMLParser, foundCDATA CDATABlock: Data) { }

    func parser(_ parser: Foundation.XMLParser,
                resolveExternalEntityName name: String,
                systemID: String?) -> Data? { return nil }

    func parser(_ parser: Foundation.XMLParser, parseErrorOccurred parseError: NSError) { }

    func parser(_ parser: Foundation.XMLParser,
                validationErrorOccurred validationError: NSError) { }
}

#endif

/// The implementation of XMLParserDelegate and where the lazy parsing actually happens.
class LazyXMLParser: NSObject, SimpleXmlParser, XMLParserDelegate {
    required init(_ options: SWXMLHashOptions) {
        self.options = options
        self.root.caseInsensitive = options.caseInsensitive
        super.init()
    }

    var root = XMLElement(name: rootElementName, caseInsensitive: false)
    var parentStack = Stack<XMLElement>()
    var elementStack = Stack<String>()

    var data: Data?
    var ops: [IndexOp] = []
    let options: SWXMLHashOptions

    func parse(_ data: Data) -> XMLIndexer {
        self.data = data
        return XMLIndexer(self)
    }

    func startParsing(_ ops: [IndexOp]) {
        // clear any prior runs of parse... expected that this won't be necessary,
        // but you never know
        parentStack.removeAll()
        root = XMLElement(name: rootElementName, caseInsensitive: options.caseInsensitive)
        parentStack.push(root)

        self.ops = ops
        let parser = Foundation.XMLParser(data: data!)
        parser.shouldProcessNamespaces = options.shouldProcessNamespaces
        parser.delegate = self
        _ = parser.parse()
    }

    func parser(_ parser: Foundation.XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String]) {

        elementStack.push(elementName)

        if !onMatch() {
            return
        }

        let currentNode = parentStack
            .top()
            .addElement(elementName, withAttributes: attributeDict, caseInsensitive: self.options.caseInsensitive)
        parentStack.push(currentNode)
    }

    func parser(_ parser: Foundation.XMLParser, foundCharacters string: String) {
        if !onMatch() {
            return
        }

        let current = parentStack.top()

        current.addText(string)
    }

    func parser(_ parser: Foundation.XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {

        let match = onMatch()

        elementStack.drop()

        if match {
            parentStack.drop()
        }
    }

    func onMatch() -> Bool {
        // we typically want to compare against the elementStack to see if it matches ops, *but*
        // if we're on the first element, we'll instead compare the other direction.
        if elementStack.items.count > ops.count {
            return elementStack.items.starts(with: ops.map { $0.key })
        } else {
            return ops.map { $0.key }.starts(with: elementStack.items)
        }
    }
}

/// The implementation of XMLParserDelegate and where the parsing actually happens.
class FullXMLParser: NSObject, SimpleXmlParser, XMLParserDelegate {
    required init(_ options: SWXMLHashOptions) {
        self.options = options
        self.root.caseInsensitive = options.caseInsensitive
        super.init()
    }

    var root = XMLElement(name: rootElementName, caseInsensitive: false)
    var parentStack = Stack<XMLElement>()
    let options: SWXMLHashOptions

    func parse(_ data: Data) -> XMLIndexer {
        // clear any prior runs of parse... expected that this won't be necessary,
        // but you never know
        parentStack.removeAll()

        parentStack.push(root)

        let parser = Foundation.XMLParser(data: data)
        parser.shouldProcessNamespaces = options.shouldProcessNamespaces
        parser.delegate = self
        _ = parser.parse()

        return XMLIndexer(root)
    }

    func parser(_ parser: Foundation.XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String]) {

        let currentNode = parentStack
            .top()
            .addElement(elementName, withAttributes: attributeDict, caseInsensitive: self.options.caseInsensitive)

        parentStack.push(currentNode)
    }

    func parser(_ parser: Foundation.XMLParser, foundCharacters string: String) {
        let current = parentStack.top()

        current.addText(string)
    }

    func parser(_ parser: Foundation.XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {

        parentStack.drop()
    }
}

/// Represents an indexed operation against a lazily parsed `XMLIndexer`
public class IndexOp {
    var index: Int
    let key: String

    init(_ key: String) {
        self.key = key
        self.index = -1
    }

    func toString() -> String {
        if index >= 0 {
            return key + " " + index.description
        }

        return key
    }
}

/// Represents a collection of `IndexOp` instances. Provides a means of iterating them
/// to find a match in a lazily parsed `XMLIndexer` instance.
public class IndexOps {
    var ops: [IndexOp] = []

    let parser: LazyXMLParser

    init(parser: LazyXMLParser) {
        self.parser = parser
    }

    func findElements() -> XMLIndexer {
        parser.startParsing(ops)
        let indexer = XMLIndexer(parser.root)
        var childIndex = indexer
        for op in ops {
            childIndex = childIndex[op.key]
            if op.index >= 0 {
                childIndex = childIndex[op.index]
            }
        }
        ops.removeAll(keepingCapacity: false)
        return childIndex
    }

    func stringify() -> String {
        var s = ""
        for op in ops {
            s += "[" + op.toString() + "]"
        }
        return s
    }
}

/// Error type that is thrown when an indexing or parsing operation fails.
public enum IndexingError: Error {
    case attribute(attr: String)
    case attributeValue(attr: String, value: String)
    case key(key: String)
    case index(idx: Int)
    case initialize(instance: AnyObject)
    case error

// swiftlint:disable identifier_name
    // unavailable
    @available(*, unavailable, renamed: "attribute(attr:)")
    public static func Attribute(attr: String) -> IndexingError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "attributeValue(attr:value:)")
    public static func AttributeValue(attr: String, value: String) -> IndexingError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "key(key:)")
    public static func Key(key: String) -> IndexingError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "index(idx:)")
    public static func Index(idx: Int) -> IndexingError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "initialize(instance:)")
    public static func Init(instance: AnyObject) -> IndexingError {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "error")
    public static var Error: IndexingError {
        fatalError("unavailable")
    }
// swiftlint:enable identifier_name
}

/// Returned from SWXMLHash, allows easy element lookup into XML data.
public enum XMLIndexer {
    case element(XMLElement)
    case list([XMLElement])
    case stream(IndexOps)
    case xmlError(IndexingError)

// swiftlint:disable identifier_name
    // unavailable
    @available(*, unavailable, renamed: "element(_:)")
    public static func Element(_: XMLElement) -> XMLIndexer {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "list(_:)")
    public static func List(_: [XMLElement]) -> XMLIndexer {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "stream(_:)")
    public static func Stream(_: IndexOps) -> XMLIndexer {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "xmlError(_:)")
    public static func XMLError(_: IndexingError) -> XMLIndexer {
        fatalError("unavailable")
    }
    @available(*, unavailable, renamed: "withAttribute(_:_:)")
    public static func withAttr(_ attr: String, _ value: String) throws -> XMLIndexer {
        fatalError("unavailable")
    }
// swiftlint:enable identifier_name

    /// The underlying XMLElement at the currently indexed level of XML.
    public var element: XMLElement? {
        switch self {
        case .element(let elem):
            return elem
        case .stream(let ops):
            let list = ops.findElements()
            return list.element
        default:
            return nil
        }
    }

    /// All elements at the currently indexed level
    public var all: [XMLIndexer] {
        switch self {
        case .list(let list):
            var xmlList = [XMLIndexer]()
            for elem in list {
                xmlList.append(XMLIndexer(elem))
            }
            return xmlList
        case .element(let elem):
            return [XMLIndexer(elem)]
        case .stream(let ops):
            let list = ops.findElements()
            return list.all
        default:
            return []
        }
    }

    /// All child elements from the currently indexed level
    public var children: [XMLIndexer] {
        var list = [XMLIndexer]()
        for elem in all.map({ $0.element! }).flatMap({ $0 }) {
            for elem in elem.xmlChildren {
                list.append(XMLIndexer(elem))
            }
        }
        return list
    }

    /**
    Allows for element lookup by matching attribute values.

    - parameters:
        - attr: should the name of the attribute to match on
        - value: should be the value of the attribute to match on
    - throws: an XMLIndexer.XMLError if an element with the specified attribute isn't found
    - returns: instance of XMLIndexer
    */
    public func withAttribute(_ attr: String, _ value: String) throws -> XMLIndexer {
        switch self {
        case .stream(let opStream):
            let match = opStream.findElements()
            return try match.withAttribute(attr, value)
        case .list(let list):
            if let elem = list.filter({
                return value.compare($0.attribute(by: attr)?.text, $0.caseInsensitive)
            }).first {
                return .element(elem)
            }
            throw IndexingError.attributeValue(attr: attr, value: value)
        case .element(let elem):
            if value.compare(elem.attribute(by: attr)?.text, elem.caseInsensitive) {
                return .element(elem)
            }
            throw IndexingError.attributeValue(attr: attr, value: value)
        default:
            throw IndexingError.attribute(attr: attr)
        }
    }

    /**
    Initializes the XMLIndexer

    - parameter _: should be an instance of XMLElement, but supports other values for error handling
    - throws: an Error if the object passed in isn't an XMLElement or LaxyXMLParser
    */
    public init(_ rawObject: AnyObject) throws {
        switch rawObject {
        case let value as XMLElement:
            self = .element(value)
        case let value as LazyXMLParser:
            self = .stream(IndexOps(parser: value))
        default:
            throw IndexingError.initialize(instance: rawObject)
        }
    }

    /**
    Initializes the XMLIndexer

    - parameter _: an instance of XMLElement
    */
    public init(_ elem: XMLElement) {
        self = .element(elem)
    }

    init(_ stream: LazyXMLParser) {
        self = .stream(IndexOps(parser: stream))
    }

    /**
    Find an XML element at the current level by element name

    - parameter key: The element name to index by
    - returns: instance of XMLIndexer to match the element (or elements) found by key
    - throws: Throws an XMLIndexingError.Key if no element was found
    */
    public func byKey(_ key: String) throws -> XMLIndexer {
        switch self {
        case .stream(let opStream):
            let op = IndexOp(key)
            opStream.ops.append(op)
            return .stream(opStream)
        case .element(let elem):
            let match = elem.xmlChildren.filter({
                return $0.name.compare(key, $0.caseInsensitive)
            })
            if !match.isEmpty {
                if match.count == 1 {
                    return .element(match[0])
                } else {
                    return .list(match)
                }
            }
            fallthrough
        default:
            throw IndexingError.key(key: key)
        }
    }

    /**
    Find an XML element at the current level by element name

    - parameter key: The element name to index by
    - returns: instance of XMLIndexer to match the element (or elements) found by
    */
    public subscript(key: String) -> XMLIndexer {
        do {
            return try self.byKey(key)
        } catch let error as IndexingError {
            return .xmlError(error)
        } catch {
            return .xmlError(IndexingError.key(key: key))
        }
    }

    /**
    Find an XML element by index within a list of XML Elements at the current level

    - parameter index: The 0-based index to index by
    - throws: XMLIndexer.XMLError if the index isn't found
    - returns: instance of XMLIndexer to match the element (or elements) found by index
    */
    public func byIndex(_ index: Int) throws -> XMLIndexer {
        switch self {
        case .stream(let opStream):
            opStream.ops[opStream.ops.count - 1].index = index
            return .stream(opStream)
        case .list(let list):
            if index <= list.count {
                return .element(list[index])
            }
            return .xmlError(IndexingError.index(idx: index))
        case .element(let elem):
            if index == 0 {
                return .element(elem)
            }
            fallthrough
        default:
            return .xmlError(IndexingError.index(idx: index))
        }
    }

    /**
    Find an XML element by index

    - parameter index: The 0-based index to index by
    - returns: instance of XMLIndexer to match the element (or elements) found by index
    */
    public subscript(index: Int) -> XMLIndexer {
        do {
            return try byIndex(index)
        } catch let error as IndexingError {
            return .xmlError(error)
        } catch {
            return .xmlError(IndexingError.index(idx: index))
        }
    }
}

/// XMLIndexer extensions

extension XMLIndexer: CustomStringConvertible {
    /// The XML representation of the XMLIndexer at the current level
    public var description: String {
        switch self {
        case .list(let list):
            return list.map { $0.description }.joined(separator: "")
        case .element(let elem):
            if elem.name == rootElementName {
                return elem.children.map { $0.description }.joined(separator: "")
            }

            return elem.description
        default:
            return ""
        }
    }
}

extension IndexingError: CustomStringConvertible {
    /// The description for the `IndexingError`.
    public var description: String {
        switch self {
        case .attribute(let attr):
            return "XML Attribute Error: Missing attribute [\"\(attr)\"]"
        case .attributeValue(let attr, let value):
            return "XML Attribute Error: Missing attribute [\"\(attr)\"] with value [\"\(value)\"]"
        case .key(let key):
            return "XML Element Error: Incorrect key [\"\(key)\"]"
        case .index(let index):
            return "XML Element Error: Incorrect index [\"\(index)\"]"
        case .initialize(let instance):
            return "XML Indexer Error: initialization with Object [\"\(instance)\"]"
        case .error:
            return "Unknown Error"
        }
    }
}

/// Models content for an XML doc, whether it is text or XML
public protocol XMLContent: CustomStringConvertible { }

/// Models a text element
public class TextElement: XMLContent {
    /// The underlying text value
    public let text: String
    init(text: String) {
        self.text = text
    }
}

public struct XMLAttribute {
    public let name: String
    public let text: String
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
}

/// Models an XML element, including name, text and attributes
public class XMLElement: XMLContent {
    /// The name of the element
    public let name: String

    public var caseInsensitive: Bool

    /// All attributes
    public var allAttributes = [String: XMLAttribute]()

    public func attribute(by name: String) -> XMLAttribute? {
        if caseInsensitive {
            return allAttributes.filter({ $0.key.compare(name, true) }).first?.value
        }
        return allAttributes[name]
    }

    /// The inner text of the element, if it exists
    public var text: String {
        return children
            .map({ $0 as? TextElement })
            .flatMap({ $0 })
            .reduce("", { $0 + $1.text })
    }

    /// The inner text of the element and its children
    public var recursiveText: String {
        return children.reduce("", {
            if let textElement = $1 as? TextElement {
                return $0 + textElement.text
            } else if let xmlElement = $1 as? XMLElement {
                return $0 + xmlElement.recursiveText
            } else {
                return $0
            }
        })
    }

    /// All child elements (text or XML)
    public var children = [XMLContent]()
    var count: Int = 0
    var index: Int

    var xmlChildren: [XMLElement] {
        return children.map { $0 as? XMLElement }.flatMap { $0 }
    }

    /**
    Initialize an XMLElement instance

    - parameters:
        - name: The name of the element to be initialized
        - index: The index of the element to be initialized
    */
    init(name: String, index: Int = 0, caseInsensitive: Bool) {
        self.name = name
        self.caseInsensitive = caseInsensitive
        self.index = index
    }

    /**
    Adds a new XMLElement underneath this instance of XMLElement

    - parameters:
        - name: The name of the new element to be added
        - withAttributes: The attributes dictionary for the element being added
    - returns: The XMLElement that has now been added
    */

    func addElement(_ name: String, withAttributes attributes: [String: String], caseInsensitive: Bool) -> XMLElement {
        let element = XMLElement(name: name, index: count, caseInsensitive: caseInsensitive)
        count += 1

        children.append(element)

        for (key, value) in attributes {
            element.allAttributes[key] = XMLAttribute(name: key, text: value)
        }

        return element
    }

    func addText(_ text: String) {
        let elem = TextElement(text: text)

        children.append(elem)
    }
}

extension TextElement: CustomStringConvertible {
    /// The text value for a `TextElement` instance.
    public var description: String {
        return text
    }
}

extension XMLAttribute: CustomStringConvertible {
    /// The textual representation of an `XMLAttribute` instance.
    public var description: String {
        return "\(name)=\"\(text)\""
    }
}

extension XMLElement: CustomStringConvertible {
    /// The tag, attributes and content for a `XMLElement` instance (<elem id="foo">content</elem>)
    public var description: String {
        var attributesString = allAttributes.map { $0.1.description }.joined(separator: " ")
        if !attributesString.isEmpty {
            attributesString = " " + attributesString
        }

        if !children.isEmpty {
            var xmlReturn = [String]()
            xmlReturn.append("<\(name)\(attributesString)>")
            for child in children {
                xmlReturn.append(child.description)
            }
            xmlReturn.append("</\(name)>")
            return xmlReturn.joined(separator: "")
        }

        return "<\(name)\(attributesString)>\(text)</\(name)>"
    }
}

// Workaround for "'XMLElement' is ambiguous for type lookup in this context" error on macOS.
//
// On macOS, `XMLElement` is defined in Foundation.
// So, the code referencing `XMLElement` generates above error.
// Following code allow to using `SWXMLhash.XMLElement` in client codes.
extension SWXMLHash {
    public typealias XMLElement = SWXMLHashXMLElement
}

public typealias SWXMLHashXMLElement = XMLElement

fileprivate extension String {
    func compare(_ str2: String?, _ insensitive: Bool) -> Bool {
        guard let str2 = str2 else { return false }
        let str1 = self
        if insensitive {
            return str1.caseInsensitiveCompare(str2) == .orderedSame
        }
        return str1 == str2
    }
}


// ----------------------------
//
// section-1.swift
//
// ----------------------------

// Playground - noun: a place where people can play

// swiftlint:disable force_unwrapping

import SWXMLHash
import Foundation

let xmlWithNamespace = "<root xmlns:h=\"http://www.w3.org/TR/html4/\"" +
"  xmlns:f=\"http://www.w3schools.com/furniture\">" +
"  <h:table>" +
"    <h:tr>" +
"      <h:td>Apples</h:td>" +
"      <h:td>Bananas</h:td>" +
"    </h:tr>" +
"  </h:table>" +
"  <f:table>" +
"    <f:name>African Coffee Table</f:name>" +
"    <f:width>80</f:width>" +
"    <f:length>120</f:length>" +
"  </f:table>" +
"</root>"

var xml = SWXMLHash.parse(xmlWithNamespace)

// one root element
let count = xml["root"].all.count

// "Apples"
xml["root"]["h:table"]["h:tr"]["h:td"][0].element!.text!

// enumerate all child elements (procedurally)
func enumerate(indexer: XMLIndexer, level: Int) {
    for child in indexer.children {
        let name = child.element!.name
        print("\(level) \(name)")

        enumerate(indexer: child, level: level + 1)
    }
}

enumerate(indexer: xml, level: 0)

// enumerate all child elements (functionally)
func reduceName(names: String, elem: XMLIndexer) -> String {
    return names + elem.element!.name + elem.children.reduce(", ", reduceName)
}

xml.children.reduce("elements: ", reduceName)

// custom types conversion
let booksXML = "<root>" +
"  <books>" +
"    <book>" +
"      <title>Book A</title>" +
"      <price>12.5</price>" +
"      <year>2015</year>" +
"    </book>" +
"    <book>" +
"      <title>Book B</title>" +
"      <price>10</price>" +
"      <year>1988</year>" +
"    </book>" +
"    <book>" +
"      <title>Book C</title>" +
"      <price>8.33</price>" +
"      <year>1990</year>" +
"      <amount>10</amount>" +
"    </book>" +
"  <books>" +
"</root>"

struct Book: XMLIndexerDeserializable {
    let title: String
    let price: Double
    let year: Int
    let amount: Int?

    static func deserialize(_ node: XMLIndexer) throws -> Book {
        return try Book(
            title: node["title"].value(),
            price: node["price"].value(),
            year: node["year"].value(),
            amount: node["amount"].value()
        )
    }
}

xml = SWXMLHash.parse(booksXML)

let books: [Book] = try xml["root"]["books"]["book"].value()


// ----------------------------
//
// LinuxMain.swift
//
// ----------------------------

import XCTest

@testable import SWXMLHashTests

XCTMain([
    testCase(LazyTypesConversionTests.allTests),
    testCase(LazyWhiteSpaceParsingTests.allTests),
    testCase(LazyXMLParsingTests.allTests),
    testCase(MixedTextWithXMLElementsTests.allTests),
    testCase(SWXMLHashConfigTests.allTests),
    testCase(TypeConversionArrayOfNonPrimitiveTypesTests.allTests),
    testCase(TypeConversionBasicTypesTests.allTests),
    testCase(TypeConversionComplexTypesTests.allTests),
    testCase(TypeConversionPrimitypeTypesTests.allTests),
    testCase(WhiteSpaceParsingTests.allTests),
    testCase(XMLParsingTests.allTests)
    ])


// ----------------------------
//
// LazyTypesConversionTests.swift
//
// ----------------------------

//
//  LazyTypesConversionTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try

class LazyTypesConversionTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithBasicTypes = "<root>" +
        "  <string>the string value</string>" +
        "  <int>100</int>" +
        "  <double>100.45</double>" +
        "  <float>44.12</float>" +
        "  <bool1>0</bool1>" +
        "  <bool2>true</bool2>" +
        "  <empty></empty>" +
        "  <basicItem>" +
        "    <name>the name of basic item</name>" +
        "    <price>99.14</price>" +
        "  </basicItem>" +
        "  <attribute int=\"1\"/>" +
    "</root>"

    override func setUp() {
        parser = SWXMLHash.config { cfg in cfg.shouldProcessLazily = true }.parse(xmlWithBasicTypes)
    }

    func testShouldConvertValueToNonOptional() {
        do {
            let value: String = try parser!["root"]["string"].value()
            XCTAssertEqual(value, "the string value")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertAttributeToNonOptional() {
        do {
            let value: Int = try parser!["root"]["attribute"].value(ofAttribute: "int")
            XCTAssertEqual(value, 1)
        } catch {
            XCTFail("\(error)")
        }
    }
}

extension LazyTypesConversionTests {
    static var allTests: [(String, (LazyTypesConversionTests) -> () throws -> Void)] {
        return [
            ("testShouldConvertValueToNonOptional", testShouldConvertValueToNonOptional),
            ("testShouldConvertAttributeToNonOptional", testShouldConvertAttributeToNonOptional)
        ]
    }
}


// ----------------------------
//
// LazyWhiteSpaceParsingTests.swift
//
// ----------------------------

//
//  LazyWhiteSpaceParsingTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import SWXMLHash
import XCTest

// swiftlint:disable line_length
// swiftlint:disable force_try

class LazyWhiteSpaceParsingTests: XCTestCase {
    var xml: XMLIndexer?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

#if SWIFT_PACKAGE
        let path = NSString.path(withComponents: NSString(string: #file).pathComponents.dropLast() + ["test.xml"])
#else
        let bundle = Bundle(for: WhiteSpaceParsingTests.self)
        let path = bundle.path(forResource: "test", ofType: "xml")!
#endif
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        xml = SWXMLHash.lazy(data)
    }

    // issue #6
    func testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace() {
        XCTAssertEqual(xml!["niotemplate"]["section"][0]["constraint"][1].element?.text, "H:|-15-[title]-15-|")
    }

    func testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace() {
#if os(Linux)
        print("Skip \(#function) on Linux")
#else
        XCTAssertEqual(xml!["niotemplate"]["other"].element?.text, "
        
  this
  has
  white
  space
        
    ")
#endif
    }
}

extension LazyWhiteSpaceParsingTests {
    static var allTests: [(String, (LazyWhiteSpaceParsingTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace", testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace),
            ("testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace", testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace)
        ]
    }
}


// ----------------------------
//
// LazyXMLParsingTests.swift
//
// ----------------------------

//
//  LazyXMLParsingTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable line_length

class LazyXMLParsingTests: XCTestCase {
    let xmlToParse = "<root><header>header mixed content<title>Test Title Header</title>more mixed content</header><catalog><book id=\"bk101\"><author>Gambardella, Matthew</author><title>XML Developer's Guide</title><genre>Computer</genre><price>44.95</price><publish_date>2000-10-01</publish_date><description>An in-depth look at creating applications with XML.</description></book><book id=\"bk102\"><author>Ralls, Kim</author><title>Midnight Rain</title><genre>Fantasy</genre><price>5.95</price><publish_date>2000-12-16</publish_date><description>A former architect battles corporate zombies, an evil sorceress, and her own childhood to become queen of the world.</description></book><book id=\"bk103\"><author>Corets, Eva</author><title>Maeve Ascendant</title><genre>Fantasy</genre><price>5.95</price><publish_date>2000-11-17</publish_date><description>After the collapse of a nanotechnology society in England, the young survivors lay the foundation for a new society.</description></book></catalog></root>"

    var xml: XMLIndexer?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        xml = SWXMLHash.config { config in config.shouldProcessLazily = true }.parse(xmlToParse)
    }

    func testShouldBeAbleToParseIndividualElements() {
        XCTAssertEqual(xml!["root"]["header"]["title"].element?.text, "Test Title Header")
    }

    func testShouldBeAbleToParseElementGroups() {
        XCTAssertEqual(xml!["root"]["catalog"]["book"][1]["author"].element?.text, "Ralls, Kim")
    }

    func testShouldBeAbleToParseAttributes() {
        XCTAssertEqual(xml!["root"]["catalog"]["book"][1].element?.attribute(by: "id")?.text, "bk102")
    }

    func testShouldBeAbleToLookUpElementsByNameAndAttribute() {
        do {
            let value = try xml!["root"]["catalog"]["book"].withAttribute("id", "bk102")["author"].element?.text
            XCTAssertEqual(value, "Ralls, Kim")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldBeAbleToIterateElementGroups() {
        let result = xml!["root"]["catalog"]["book"].all.map({ $0["genre"].element!.text }).joined(separator: ", ")
        XCTAssertEqual(result, "Computer, Fantasy, Fantasy")
    }

    func testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound() {
        XCTAssertEqual(xml!["root"]["header"]["title"].all.count, 1)
    }

    func testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound() {
        XCTAssertEqual(xml!["root"]["header"]["title"][0].element?.text, "Test Title Header")
    }

    func testShouldBeAbleToIterateUsingForIn() {
        var count = 0
        for _ in xml!["root"]["catalog"]["book"].all {
            count += 1
        }

        XCTAssertEqual(count, 3)
    }

    func testShouldBeAbleToEnumerateChildren() {
        let result = xml!["root"]["catalog"]["book"][0].children.map({ $0.element!.name }).joined(separator: ", ")
        XCTAssertEqual(result, "author, title, genre, price, publish_date, description")
    }

    func testShouldBeAbleToHandleMixedContent() {
        XCTAssertEqual(xml!["root"]["header"].element?.text, "header mixed contentmore mixed content")
    }

    func testShouldHandleInterleavingXMLElements() {
        let interleavedXml = "<html><body><p>one</p><div>two</div><p>three</p><div>four</div></body></html>"
        let parsed = SWXMLHash.parse(interleavedXml)

        let result = parsed["html"]["body"].children.map({ $0.element!.text }).joined(separator: ", ")
        XCTAssertEqual(result, "one, two, three, four")
    }

    func testShouldBeAbleToProvideADescriptionForTheDocument() {
        let descriptionXml = "<root><foo><what id=\"myId\">puppies</what></foo></root>"
        let parsed = SWXMLHash.parse(descriptionXml)

        XCTAssertEqual(parsed.description, "<root><foo><what id=\"myId\">puppies</what></foo></root>")
    }

    // error handling

    func testShouldReturnNilWhenKeysDontMatch() {
        XCTAssertNil(xml!["root"]["what"]["header"]["foo"].element?.name)
    }
}

extension LazyXMLParsingTests {
    static var allTests: [(String, (LazyXMLParsingTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToParseIndividualElements", testShouldBeAbleToParseIndividualElements),
            ("testShouldBeAbleToParseElementGroups", testShouldBeAbleToParseElementGroups),
            ("testShouldBeAbleToParseAttributes", testShouldBeAbleToParseAttributes),
            ("testShouldBeAbleToLookUpElementsByNameAndAttribute", testShouldBeAbleToLookUpElementsByNameAndAttribute),
            ("testShouldBeAbleToIterateElementGroups", testShouldBeAbleToIterateElementGroups),
            ("testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound", testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound),
            ("testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound", testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound),
            ("testShouldBeAbleToIterateUsingForIn", testShouldBeAbleToIterateUsingForIn),
            ("testShouldBeAbleToEnumerateChildren", testShouldBeAbleToEnumerateChildren),
            ("testShouldBeAbleToHandleMixedContent", testShouldBeAbleToHandleMixedContent),
            ("testShouldHandleInterleavingXMLElements", testShouldHandleInterleavingXMLElements),
            ("testShouldBeAbleToProvideADescriptionForTheDocument", testShouldBeAbleToProvideADescriptionForTheDocument),
            ("testShouldReturnNilWhenKeysDontMatch", testShouldReturnNilWhenKeysDontMatch)
        ]
    }
}


// ----------------------------
//
// LinuxShims.swift
//
// ----------------------------

//
//  LinuxShims.swift
//  SWXMLHash
//
//  Created by 野村 憲男 on 8/29/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

#if os(Linux)

    extension NSString {
        class func path(withComponents components: [String]) -> String {
            return pathWithComponents(components)
        }
    }

#endif


// ----------------------------
//
// MixedTextWithXMLElementsTests.swift
//
// ----------------------------

//
//  MixedTextWithXMLElementsTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable line_length

class MixedTextWithXMLElementsTests: XCTestCase {
    var xml: XMLIndexer?

    override func setUp() {
        let xmlContent = "<everything><news><content>Here is a cool thing <a href=\"google.com\">A</a> and second cool thing <a href=\"fb.com\">B</a></content></news></everything>"
        xml = SWXMLHash.parse(xmlContent)
    }

    func testShouldBeAbleToGetAllContentsInsideOfAnElement() {
        XCTAssertEqual(xml!["everything"]["news"]["content"].description, "<content>Here is a cool thing <a href=\"google.com\">A</a> and second cool thing <a href=\"fb.com\">B</a></content>")
    }
}

extension MixedTextWithXMLElementsTests {
    static var allTests: [(String, (MixedTextWithXMLElementsTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToGetAllContentsInsideOfAnElement", testShouldBeAbleToGetAllContentsInsideOfAnElement)
        ]
    }
}


// ----------------------------
//
// SWXMLHashConfigTests.swift
//
// ----------------------------

//
//  SWXMLHashConfigTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

class SWXMLHashConfigTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithNamespace = "<root xmlns:h=\"http://www.w3.org/TR/html4/\"" +
        "  xmlns:f=\"http://www.w3schools.com/furniture\">" +
        "  <h:table>" +
        "    <h:tr>" +
        "      <h:td>Apples</h:td>" +
        "      <h:td>Bananas</h:td>" +
        "    </h:tr>" +
        "  </h:table>" +
    "</root>"

    override func setUp() {
        parser = SWXMLHash.config { conf in
            conf.shouldProcessNamespaces = true
            }.parse(xmlWithNamespace)
    }

    func testShouldAllowProcessingNamespacesOrNot() {
        XCTAssertEqual(parser!["root"]["table"]["tr"]["td"][0].element?.text, "Apples")
    }
}

extension SWXMLHashConfigTests {
    static var allTests: [(String, (SWXMLHashConfigTests) -> () throws -> Void)] {
        return [
            ("testShouldAllowProcessingNamespacesOrNot", testShouldAllowProcessingNamespacesOrNot)
        ]
    }
}


// ----------------------------
//
// TypeConversionArrayOfNonPrimitiveTypesTests.swift
//
// ----------------------------

//
//  TypeConversionArrayOfNonPrimitiveTypesTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable line_length
// swiftlint:disable type_name

class TypeConversionArrayOfNonPrimitiveTypesTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithArraysOfTypes = "<root>" +
        "<arrayOfGoodBasicItems>" +
        "   <basicItem>" +
        "      <name>item 1</name>" +
        "      <price>1</price>" +
        "   </basicItem>" +
        "   <basicItem>" +
        "      <name>item 2</name>" +
        "      <price>2</price>" +
        "   </basicItem>" +
        "   <basicItem>" +
        "      <name>item 3</name>" +
        "      <price>3</price>" +
        "   </basicItem>" +
        "</arrayOfGoodBasicItems>" +
        "<arrayOfBadBasicItems>" +
        "   <basicItem>" +
        "      <name>item 1</name>" +
        "      <price>1</price>" +
        "   </basicItem>" +
        "   <basicItem>" +  // it's missing the name node
        "      <price>2</price>" +
        "   </basicItem>" +
        "   <basicItem>" +
        "      <name>item 3</name>" +
        "      <price>3</price>" +
        "   </basicItem>" +
        "</arrayOfBadBasicItems>" +
        "<arrayOfMissingBasicItems />" +
        "<arrayOfGoodAttributeItems>" +
        "   <attributeItem name=\"attr 1\" price=\"1.1\"/>" +
        "   <attributeItem name=\"attr 2\" price=\"2.2\"/>" +
        "   <attributeItem name=\"attr 3\" price=\"3.3\"/>" +
        "</arrayOfGoodAttributeItems>" +
        "<arrayOfBadAttributeItems>" +
        "   <attributeItem name=\"attr 1\" price=\"1.1\"/>" +
        "   <attributeItem price=\"2.2\"/>" + // it's missing the name attribute
        "   <attributeItem name=\"attr 3\" price=\"3.3\"/>" +
        "</arrayOfBadAttributeItems>" +
    "</root>"

    let correctBasicItems = [
        BasicItem(name: "item 1", price: 1),
        BasicItem(name: "item 2", price: 2),
        BasicItem(name: "item 3", price: 3)
    ]

    let correctAttributeItems = [
        AttributeItem(name: "attr 1", price: 1.1),
        AttributeItem(name: "attr 2", price: 2.2),
        AttributeItem(name: "attr 3", price: 3.3)
    ]

    override func setUp() {
        parser = SWXMLHash.parse(xmlWithArraysOfTypes)
    }

    func testShouldConvertArrayOfGoodBasicitemsItemsToNonOptional() {
        do {
            let value: [BasicItem] = try parser!["root"]["arrayOfGoodBasicItems"]["basicItem"].value()
            XCTAssertEqual(value, correctBasicItems)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodBasicitemsItemsToOptional() {
        do {
            let value: [BasicItem]? = try parser!["root"]["arrayOfGoodBasicItems"]["basicItem"].value()
            XCTAssertNotNil(value)
            if let value = value {
                XCTAssertEqual(value, correctBasicItems)
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodBasicitemsItemsToArrayOfOptionals() {
        do {
            let value: [BasicItem?] = try parser!["root"]["arrayOfGoodBasicItems"]["basicItem"].value()
            XCTAssertEqual(value.flatMap({ $0 }), correctBasicItems)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadBasicitemsToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadBasicItems"]["basicItem"].value() as [BasicItem])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadBasicitemsToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadBasicItems"]["basicItem"].value() as [BasicItem]?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadBasicitemsToArrayOfOptionals() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadBasicItems"]["basicItem"].value() as [BasicItem?])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertArrayOfEmptyMissingToOptional() {
        do {
            let value: [BasicItem]? = try parser!["root"]["arrayOfMissingBasicItems"]["basicItem"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodAttributeItemsToNonOptional() {
        do {
            let value: [AttributeItem] = try parser!["root"]["arrayOfGoodAttributeItems"]["attributeItem"].value()
            XCTAssertEqual(value, correctAttributeItems)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodAttributeItemsToOptional() {
        do {
            let value: [AttributeItem]? = try parser!["root"]["arrayOfGoodAttributeItems"]["attributeItem"].value()
            XCTAssertNotNil(value)
            if let value = value {
                XCTAssertEqual(value, correctAttributeItems)
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodAttributeItemsToArrayOfOptionals() {
        do {
            let value: [AttributeItem?] = try parser!["root"]["arrayOfGoodAttributeItems"]["attributeItem"].value()
            XCTAssertEqual(value.flatMap({ $0 }), correctAttributeItems)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadAttributeItemsToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadAttributeItems"]["attributeItem"].value() as [AttributeItem])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadAttributeItemsToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadAttributeItems"]["attributeItem"].value() as [AttributeItem]?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadAttributeItemsToArrayOfOptionals() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadAttributeItems"]["attributeItem"].value() as [AttributeItem?])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }
}

extension TypeConversionArrayOfNonPrimitiveTypesTests {
    static var allTests: [(String, (TypeConversionArrayOfNonPrimitiveTypesTests) -> () throws -> Void)] {
        return [
            ("testShouldConvertArrayOfGoodBasicitemsItemsToNonOptional", testShouldConvertArrayOfGoodBasicitemsItemsToNonOptional),
            ("testShouldConvertArrayOfGoodBasicitemsItemsToOptional", testShouldConvertArrayOfGoodBasicitemsItemsToOptional),
            ("testShouldConvertArrayOfGoodBasicitemsItemsToArrayOfOptionals", testShouldConvertArrayOfGoodBasicitemsItemsToArrayOfOptionals),
            ("testShouldThrowWhenConvertingArrayOfBadBasicitemsToNonOptional", testShouldThrowWhenConvertingArrayOfBadBasicitemsToNonOptional),
            ("testShouldThrowWhenConvertingArrayOfBadBasicitemsToOptional", testShouldThrowWhenConvertingArrayOfBadBasicitemsToOptional),
            ("testShouldThrowWhenConvertingArrayOfBadBasicitemsToArrayOfOptionals", testShouldThrowWhenConvertingArrayOfBadBasicitemsToArrayOfOptionals),
            ("testShouldConvertArrayOfGoodAttributeItemsToNonOptional", testShouldConvertArrayOfGoodAttributeItemsToNonOptional),
            ("testShouldConvertArrayOfGoodAttributeItemsToOptional", testShouldConvertArrayOfGoodAttributeItemsToOptional),
            ("testShouldConvertArrayOfGoodAttributeItemsToArrayOfOptionals", testShouldConvertArrayOfGoodAttributeItemsToArrayOfOptionals),
            ("testShouldThrowWhenConvertingArrayOfBadAttributeItemsToNonOptional", testShouldThrowWhenConvertingArrayOfBadAttributeItemsToNonOptional),
            ("testShouldThrowWhenConvertingArrayOfBadAttributeItemsToOptional", testShouldThrowWhenConvertingArrayOfBadAttributeItemsToOptional),
            ("testShouldThrowWhenConvertingArrayOfBadAttributeItemsToArrayOfOptionals", testShouldThrowWhenConvertingArrayOfBadAttributeItemsToArrayOfOptionals)
        ]
    }
}


// ----------------------------
//
// TypeConversionBasicTypesTests.swift
//
// ----------------------------

//
//  TypesConversionBasicTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable variable_name
// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

class TypeConversionBasicTypesTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithBasicTypes = "<root>" +
        "  <string>the string value</string>" +
        "  <int>100</int>" +
        "  <double>100.45</double>" +
        "  <float>44.12</float>" +
        "  <bool1>0</bool1>" +
        "  <bool2>true</bool2>" +
        "  <empty></empty>" +
        "  <basicItem>" +
        "    <name>the name of basic item</name>" +
        "    <price>99.14</price>" +
        "  </basicItem>" +
        "  <attr string=\"stringValue\" int=\"200\" double=\"200.15\" float=\"205.42\" bool1=\"0\" bool2=\"true\"/>" +
        "  <attributeItem name=\"the name of attribute item\" price=\"19.99\"/>" +
    "</root>"

    override func setUp() {
        parser = SWXMLHash.parse(xmlWithBasicTypes)
    }

    func testShouldConvertValueToNonOptional() {
        do {
            let value: String = try parser!["root"]["string"].value()
            XCTAssertEqual(value, "the string value")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyToNonOptional() {
        do {
            let value: String = try parser!["root"]["empty"].value()
            XCTAssertEqual(value, "")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as String)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertValueToOptional() {
        do {
            let value: String? = try parser!["root"]["string"].value()
            XCTAssertEqual(value, "the string value")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyToOptional() {
        do {
            let value: String? = try parser!["root"]["empty"].value()
            XCTAssertEqual(value, "")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertMissingToOptional() {
        do {
            let value: String? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertAttributeToNonOptional() {
        do {
            let value: String = try parser!["root"]["attr"].value(ofAttribute: "string")
            XCTAssertEqual(value, "stringValue")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertAttributeToOptional() {
        let value: String? = parser!["root"]["attr"].value(ofAttribute: "string")
        XCTAssertEqual(value, "stringValue")
    }

    func testShouldThrowWhenConvertingMissingAttributeToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["attr"].value(ofAttribute: "missing") as String)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertMissingAttributeToOptional() {
        let value: String? = parser!["root"]["attr"].value(ofAttribute: "missing")
        XCTAssertNil(value)
    }

    func testIntShouldConvertValueToNonOptional() {
        do {
            let value: Int = try parser!["root"]["int"].value()
            XCTAssertEqual(value, 100)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testIntShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Int)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testIntShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as Int)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testIntShouldConvertValueToOptional() {
        do {
            let value: Int? = try parser!["root"]["int"].value()
            XCTAssertEqual(value, 100)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testIntShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Int?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testIntShouldConvertMissingToOptional() {
        do {
            let value: Int? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testIntShouldConvertAttributeToNonOptional() {
        do {
            let value: Int = try parser!["root"]["attr"].value(ofAttribute: "int")
            XCTAssertEqual(value, 200)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testIntShouldConvertAttributeToOptional() {
        let value: Int? = parser!["root"]["attr"].value(ofAttribute: "int")
        XCTAssertEqual(value, 200)
    }

    func testDoubleShouldConvertValueToNonOptional() {
        do {
            let value: Double = try parser!["root"]["double"].value()
            XCTAssertEqual(value, 100.45)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testDoubleShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Double)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testDoubleShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as Double)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testDoubleShouldConvertValueToOptional() {
        do {
            let value: Double? = try parser!["root"]["double"].value()
            XCTAssertEqual(value, 100.45)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testDoubleShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Double?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testDoubleShouldConvertMissingToOptional() {
        do {
            let value: Double? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testDoubleShouldConvertAttributeToNonOptional() {
        do {
            let value: Double = try parser!["root"]["attr"].value(ofAttribute: "double")
            XCTAssertEqual(value, 200.15)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testDoubleShouldConvertAttributeToOptional() {
        let value: Double? = parser!["root"]["attr"].value(ofAttribute: "double")
        XCTAssertEqual(value, 200.15)
    }

    func testFloatShouldConvertValueToNonOptional() {
        do {
            let value: Float = try parser!["root"]["float"].value()
            XCTAssertEqual(value, 44.12)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testFloatShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Float)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testFloatShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as Float)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testFloatShouldConvertValueToOptional() {
        do {
            let value: Float? = try parser!["root"]["float"].value()
            XCTAssertEqual(value, 44.12)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testFloatShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Float?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testFloatShouldConvertMissingToOptional() {
        do {
            let value: Float? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testFloatShouldConvertAttributeToNonOptional() {
        do {
            let value: Float = try parser!["root"]["attr"].value(ofAttribute: "float")
            XCTAssertEqual(value, 205.42)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testFloatShouldConvertAttributeToOptional() {
        let value: Float? = parser!["root"]["attr"].value(ofAttribute: "float")
        XCTAssertEqual(value, 205.42)
    }

    func testBoolShouldConvertValueToNonOptional() {
        do {
            let value1: Bool = try parser!["root"]["bool1"].value()
            let value2: Bool = try parser!["root"]["bool2"].value()
            XCTAssertFalse(value1)
            XCTAssertTrue(value2)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBoolShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Bool)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBoolShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as Bool)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBoolShouldConvertValueToOptional() {
        do {
            let value1: Bool? = try parser!["root"]["bool1"].value()
            XCTAssertEqual(value1, false)
            let value2: Bool? = try parser!["root"]["bool2"].value()
            XCTAssertEqual(value2, true)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBoolShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as Bool?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBoolShouldConvertMissingToOptional() {
        do {
            let value: Bool? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBoolShouldConvertAttributeToNonOptional() {
        do {
            let value: Bool = try parser!["root"]["attr"].value(ofAttribute: "bool1")
            XCTAssertEqual(value, false)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBoolShouldConvertAttributeToOptional() {
        let value: Bool? = parser!["root"]["attr"].value(ofAttribute: "bool2")
        XCTAssertEqual(value, true)
    }

    let correctBasicItem = BasicItem(name: "the name of basic item", price: 99.14)

    func testBasicItemShouldConvertBasicitemToNonOptional() {
        do {
            let value: BasicItem = try parser!["root"]["basicItem"].value()
            XCTAssertEqual(value, correctBasicItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBasicItemShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as BasicItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBasicItemShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as BasicItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBasicItemShouldConvertBasicitemToOptional() {
        do {
            let value: BasicItem? = try parser!["root"]["basicItem"].value()
            XCTAssertEqual(value, correctBasicItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBasicItemShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as BasicItem?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testBasicItemShouldConvertMissingToOptional() {
        do {
            let value: BasicItem? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    let correctAttributeItem = AttributeItem(name: "the name of attribute item", price: 19.99)

    func testAttributeItemShouldConvertAttributeItemToNonOptional() {
        do {
            let value: AttributeItem = try parser!["root"]["attributeItem"].value()
            XCTAssertEqual(value, correctAttributeItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testAttributeItemShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as AttributeItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testAttributeItemShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as AttributeItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testAttributeItemShouldConvertAttributeItemToOptional() {
        do {
            let value: AttributeItem? = try parser!["root"]["attributeItem"].value()
            XCTAssertEqual(value, correctAttributeItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testAttributeItemShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as AttributeItem?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testAttributeItemShouldConvertMissingToOptional() {
        do {
            let value: AttributeItem? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }
}

struct BasicItem: XMLIndexerDeserializable {
    let name: String
    let price: Double

    static func deserialize(_ node: XMLIndexer) throws -> BasicItem {
        return try BasicItem(
            name: node["name"].value(),
            price: node["price"].value()
        )
    }
}

extension BasicItem: Equatable {}

func == (a: BasicItem, b: BasicItem) -> Bool {
    return a.name == b.name && a.price == b.price
}

struct AttributeItem: XMLElementDeserializable {
    let name: String
    let price: Double

    static func deserialize(_ element: SWXMLHash.XMLElement) throws -> AttributeItem {
        return try AttributeItem(
            name: element.value(ofAttribute: "name"),
            price: element.value(ofAttribute: "price")
        )
    }
}

extension AttributeItem: Equatable {}

func == (a: AttributeItem, b: AttributeItem) -> Bool {
    return a.name == b.name && a.price == b.price
}

extension TypeConversionBasicTypesTests {
    static var allTests: [(String, (TypeConversionBasicTypesTests) -> () throws -> Void)] {
        return [
            ("testShouldConvertValueToNonOptional", testShouldConvertValueToNonOptional),
            ("testShouldConvertEmptyToNonOptional", testShouldConvertEmptyToNonOptional),
            ("testShouldThrowWhenConvertingMissingToNonOptional", testShouldThrowWhenConvertingMissingToNonOptional),
            ("testShouldConvertValueToOptional", testShouldConvertValueToOptional),
            ("testShouldConvertEmptyToOptional", testShouldConvertEmptyToOptional),
            ("testShouldConvertMissingToOptional", testShouldConvertMissingToOptional),
            ("testShouldConvertAttributeToNonOptional", testShouldConvertAttributeToNonOptional),
            ("testShouldConvertAttributeToOptional", testShouldConvertAttributeToOptional),
            ("testShouldThrowWhenConvertingMissingAttributeToNonOptional", testShouldThrowWhenConvertingMissingAttributeToNonOptional),
            ("testShouldConvertMissingAttributeToOptional", testShouldConvertMissingAttributeToOptional),
            ("testIntShouldConvertValueToNonOptional", testIntShouldConvertValueToNonOptional),
            ("testIntShouldThrowWhenConvertingEmptyToNonOptional", testIntShouldThrowWhenConvertingEmptyToNonOptional),
            ("testIntShouldThrowWhenConvertingMissingToNonOptional", testIntShouldThrowWhenConvertingMissingToNonOptional),
            ("testIntShouldConvertValueToOptional", testIntShouldConvertValueToOptional),
            ("testIntShouldConvertEmptyToOptional", testIntShouldConvertEmptyToOptional),
            ("testIntShouldConvertMissingToOptional", testIntShouldConvertMissingToOptional),
            ("testIntShouldConvertAttributeToNonOptional", testIntShouldConvertAttributeToNonOptional),
            ("testIntShouldConvertAttributeToOptional", testIntShouldConvertAttributeToOptional),
            ("testDoubleShouldConvertValueToNonOptional", testDoubleShouldConvertValueToNonOptional),
            ("testDoubleShouldThrowWhenConvertingEmptyToNonOptional", testDoubleShouldThrowWhenConvertingEmptyToNonOptional),
            ("testDoubleShouldThrowWhenConvertingMissingToNonOptional", testDoubleShouldThrowWhenConvertingMissingToNonOptional),
            ("testDoubleShouldConvertValueToOptional", testDoubleShouldConvertValueToOptional),
            ("testDoubleShouldConvertEmptyToOptional", testDoubleShouldConvertEmptyToOptional),
            ("testDoubleShouldConvertMissingToOptional", testDoubleShouldConvertMissingToOptional),
            ("testDoubleShouldConvertAttributeToNonOptional", testDoubleShouldConvertAttributeToNonOptional),
            ("testDoubleShouldConvertAttributeToOptional", testDoubleShouldConvertAttributeToOptional),
            ("testFloatShouldConvertValueToNonOptional", testFloatShouldConvertValueToNonOptional),
            ("testFloatShouldThrowWhenConvertingEmptyToNonOptional", testFloatShouldThrowWhenConvertingEmptyToNonOptional),
            ("testFloatShouldThrowWhenConvertingMissingToNonOptional", testFloatShouldThrowWhenConvertingMissingToNonOptional),
            ("testFloatShouldConvertValueToOptional", testFloatShouldConvertValueToOptional),
            ("testFloatShouldConvertEmptyToOptional", testFloatShouldConvertEmptyToOptional),
            ("testFloatShouldConvertMissingToOptional", testFloatShouldConvertMissingToOptional),
            ("testFloatShouldConvertAttributeToNonOptional", testFloatShouldConvertAttributeToNonOptional),
            ("testFloatShouldConvertAttributeToOptional", testFloatShouldConvertAttributeToOptional),
            ("testBoolShouldConvertValueToNonOptional", testBoolShouldConvertValueToNonOptional),
            ("testBoolShouldThrowWhenConvertingEmptyToNonOptional", testBoolShouldThrowWhenConvertingEmptyToNonOptional),
            ("testBoolShouldThrowWhenConvertingMissingToNonOptional", testBoolShouldThrowWhenConvertingMissingToNonOptional),
            ("testBoolShouldConvertValueToOptional", testBoolShouldConvertValueToOptional),
            ("testBoolShouldConvertEmptyToOptional", testBoolShouldConvertEmptyToOptional),
            ("testBoolShouldConvertMissingToOptional", testBoolShouldConvertMissingToOptional),
            ("testBoolShouldConvertAttributeToNonOptional", testBoolShouldConvertAttributeToNonOptional),
            ("testBoolShouldConvertAttributeToOptional", testBoolShouldConvertAttributeToOptional),
            ("testBasicItemShouldConvertBasicitemToNonOptional", testBasicItemShouldConvertBasicitemToNonOptional),
            ("testBasicItemShouldThrowWhenConvertingEmptyToNonOptional", testBasicItemShouldThrowWhenConvertingEmptyToNonOptional),
            ("testBasicItemShouldThrowWhenConvertingMissingToNonOptional", testBasicItemShouldThrowWhenConvertingMissingToNonOptional),
            ("testBasicItemShouldConvertBasicitemToOptional", testBasicItemShouldConvertBasicitemToOptional),
            ("testBasicItemShouldConvertEmptyToOptional", testBasicItemShouldConvertEmptyToOptional),
            ("testBasicItemShouldConvertMissingToOptional", testBasicItemShouldConvertMissingToOptional),
            ("testAttributeItemShouldConvertAttributeItemToNonOptional", testAttributeItemShouldConvertAttributeItemToNonOptional),
            ("testAttributeItemShouldThrowWhenConvertingEmptyToNonOptional", testAttributeItemShouldThrowWhenConvertingEmptyToNonOptional),
            ("testAttributeItemShouldThrowWhenConvertingMissingToNonOptional", testAttributeItemShouldThrowWhenConvertingMissingToNonOptional),
            ("testAttributeItemShouldConvertAttributeItemToOptional", testAttributeItemShouldConvertAttributeItemToOptional),
            ("testAttributeItemShouldConvertEmptyToOptional", testAttributeItemShouldConvertEmptyToOptional),
            ("testAttributeItemShouldConvertMissingToOptional", testAttributeItemShouldConvertMissingToOptional)
        ]
    }
}


// ----------------------------
//
// TypeConversionComplexTypesTests.swift
//
// ----------------------------

//
//  TypeConversionComplexTypesTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable variable_name
// swiftlint:disable line_length

class TypeConversionComplexTypesTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithComplexType = "<root>" +
        "  <complexItem>" +
        "    <name>the name of complex item</name>" +
        "    <price>1024</price>" +
        "    <basicItems>" +
        "       <basicItem>" +
        "          <name>item 1</name>" +
        "          <price>1</price>" +
        "       </basicItem>" +
        "       <basicItem>" +
        "          <name>item 2</name>" +
        "          <price>2</price>" +
        "       </basicItem>" +
        "       <basicItem>" +
        "          <name>item 3</name>" +
        "          <price>3</price>" +
        "       </basicItem>" +
        "    </basicItems>" +
        "    <attributeItems>" +
        "       <attributeItem name=\"attr1\" price=\"1.1\"/>" +
        "       <attributeItem name=\"attr2\" price=\"2.2\"/>" +
        "       <attributeItem name=\"attr3\" price=\"3.3\"/>" +
        "    </attributeItems>" +
        "  </complexItem>" +
        "  <empty></empty>" +
    "</root>"

    let correctComplexItem = ComplexItem(
        name: "the name of complex item",
        priceOptional: 1024,
        basics: [
            BasicItem(name: "item 1", price: 1),
            BasicItem(name: "item 2", price: 2),
            BasicItem(name: "item 3", price: 3)
        ],
        attrs: [
            AttributeItem(name: "attr1", price: 1.1),
            AttributeItem(name: "attr2", price: 2.2),
            AttributeItem(name: "attr3", price: 3.3)
        ]
    )

    override func setUp() {
        parser = SWXMLHash.parse(xmlWithComplexType)
    }

    func testShouldConvertComplexitemToNonOptional() {
        do {
            let value: ComplexItem = try parser!["root"]["complexItem"].value()
            XCTAssertEqual(value, correctComplexItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldThrowWhenConvertingEmptyToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as ComplexItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingMissingToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["missing"].value() as ComplexItem)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertComplexitemToOptional() {
        do {
            let value: ComplexItem? = try parser!["root"]["complexItem"].value()
            XCTAssertEqual(value, correctComplexItem)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["empty"].value() as ComplexItem?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertMissingToOptional() {
        do {
            let value: ComplexItem? = try parser!["root"]["missing"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }
}

struct ComplexItem: XMLIndexerDeserializable {
    let name: String
    let priceOptional: Double?
    let basics: [BasicItem]
    let attrs: [AttributeItem]

    static func deserialize(_ node: XMLIndexer) throws -> ComplexItem {
        return try ComplexItem(
            name: node["name"].value(),
            priceOptional: node["price"].value(),
            basics: node["basicItems"]["basicItem"].value(),
            attrs: node["attributeItems"]["attributeItem"].value()
        )
    }
}

extension ComplexItem: Equatable {}

func == (a: ComplexItem, b: ComplexItem) -> Bool {
    return a.name == b.name && a.priceOptional == b.priceOptional && a.basics == b.basics && a.attrs == b.attrs
}

extension TypeConversionComplexTypesTests {
    static var allTests: [(String, (TypeConversionComplexTypesTests) -> () throws -> Void)] {
        return [
            ("testShouldConvertComplexitemToNonOptional", testShouldConvertComplexitemToNonOptional),
            ("testShouldThrowWhenConvertingEmptyToNonOptional", testShouldThrowWhenConvertingEmptyToNonOptional),
            ("testShouldThrowWhenConvertingMissingToNonOptional", testShouldThrowWhenConvertingMissingToNonOptional),
            ("testShouldConvertComplexitemToOptional", testShouldConvertComplexitemToOptional),
            ("testShouldConvertEmptyToOptional", testShouldConvertEmptyToOptional),
            ("testShouldConvertMissingToOptional", testShouldConvertMissingToOptional)
        ]
    }
}


// ----------------------------
//
// TypeConversionPrimitypeTypesTests.swift
//
// ----------------------------

//
//  TypeConversionPrimitypeTypesTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable line_length

class TypeConversionPrimitypeTypesTests: XCTestCase {
    var parser: XMLIndexer?
    let xmlWithArraysOfTypes = "<root>" +
        "<arrayOfGoodInts>" +
        "   <int>0</int> <int>1</int> <int>2</int> <int>3</int>" +
        "</arrayOfGoodInts>" +
        "<arrayOfBadInts>" +
        "   <int></int> <int>boom</int>" +
        "</arrayOfBadInts>" +
        "<arrayOfMixedInts>" +
        "   <int>0</int> <int>boom</int> <int>2</int> <int>3</int>" +
        "</arrayOfMixedInts>" +
        "<arrayOfAttributeInts>" +
        "   <int value=\"0\"/> <int value=\"1\"/> <int value=\"2\"/> <int value=\"3\"/>" +
        "</arrayOfAttributeInts>" +
        "<empty></empty>" +
    "</root>"

    override func setUp() {
        parser = SWXMLHash.parse(xmlWithArraysOfTypes)
    }

    func testShouldConvertArrayOfGoodIntsToNonOptional() {
        do {
            let value: [Int] = try parser!["root"]["arrayOfGoodInts"]["int"].value()
            XCTAssertEqual(value, [0, 1, 2, 3])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodIntsToOptional() {
        do {
            let value: [Int]? = try parser!["root"]["arrayOfGoodInts"]["int"].value()
            XCTAssertNotNil(value)
            if let value = value {
                XCTAssertEqual(value, [0, 1, 2, 3])
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfGoodIntsToArrayOfOptionals() {
        do {
            let value: [Int?] = try parser!["root"]["arrayOfGoodInts"]["int"].value()
            XCTAssertEqual(value.flatMap({ $0 }), [0, 1, 2, 3])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadIntsToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadInts"]["int"].value() as [Int])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadIntsToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadInts"]["int"].value() as [Int]?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfBadIntsToArrayOfOptionals() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfBadInts"]["int"].value() as [Int?])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfMixedIntsToNonOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfMixedInts"]["int"].value() as [Int])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfMixedIntsToOptional() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfMixedInts"]["int"].value() as [Int]?)) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldThrowWhenConvertingArrayOfMixedIntsToArrayOfOptionals() {
        XCTAssertThrowsError(try (parser!["root"]["arrayOfMixedInts"]["int"].value() as [Int?])) { error in
            guard error is XMLDeserializationError else {
                XCTFail("Wrong type of error")
                return
            }
        }
    }

    func testShouldConvertArrayOfAttributeIntsToNonOptional() {
        do {
            let value: [Int] = try parser!["root"]["arrayOfAttributeInts"]["int"].value(ofAttribute: "value")
            XCTAssertEqual(value, [0, 1, 2, 3])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfAttributeIntsToOptional() {
        do {
            let value: [Int]? = try parser!["root"]["arrayOfAttributeInts"]["int"].value(ofAttribute: "value")
            XCTAssertNotNil(value)
            if let value = value {
                XCTAssertEqual(value, [0, 1, 2, 3])
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertArrayOfAttributeIntsToArrayOfOptionals() {
        do {
            let value: [Int?] = try parser!["root"]["arrayOfAttributeInts"]["int"].value(ofAttribute: "value")
            XCTAssertEqual(value.flatMap({ $0 }), [0, 1, 2, 3])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyArrayOfIntsToNonOptional() {
        do {
            let value: [Int] = try parser!["root"]["empty"]["int"].value()
            XCTAssertEqual(value, [])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyArrayOfIntsToOptional() {
        do {
            let value: [Int]? = try parser!["root"]["empty"]["int"].value()
            XCTAssertNil(value)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldConvertEmptyArrayOfIntsToArrayOfOptionals() {
        do {
            let value: [Int?] = try parser!["root"]["empty"]["int"].value()
            XCTAssertEqual(value.count, 0)
        } catch {
            XCTFail("\(error)")
        }
    }
}

extension TypeConversionPrimitypeTypesTests {
    static var allTests: [(String, (TypeConversionPrimitypeTypesTests) -> () throws -> Void)] {
        return [
            ("testShouldConvertArrayOfGoodIntsToNonOptional", testShouldConvertArrayOfGoodIntsToNonOptional),
            ("testShouldConvertArrayOfGoodIntsToOptional", testShouldConvertArrayOfGoodIntsToOptional),
            ("testShouldConvertArrayOfGoodIntsToArrayOfOptionals", testShouldConvertArrayOfGoodIntsToArrayOfOptionals),
            ("testShouldThrowWhenConvertingArrayOfBadIntsToNonOptional", testShouldThrowWhenConvertingArrayOfBadIntsToNonOptional),
            ("testShouldThrowWhenConvertingArrayOfBadIntsToOptional", testShouldThrowWhenConvertingArrayOfBadIntsToOptional),
            ("testShouldThrowWhenConvertingArrayOfBadIntsToArrayOfOptionals", testShouldThrowWhenConvertingArrayOfBadIntsToArrayOfOptionals),
            ("testShouldThrowWhenConvertingArrayOfMixedIntsToNonOptional", testShouldThrowWhenConvertingArrayOfMixedIntsToNonOptional),
            ("testShouldThrowWhenConvertingArrayOfMixedIntsToOptional", testShouldThrowWhenConvertingArrayOfMixedIntsToOptional),
            ("testShouldThrowWhenConvertingArrayOfMixedIntsToArrayOfOptionals", testShouldThrowWhenConvertingArrayOfMixedIntsToArrayOfOptionals),
            ("testShouldConvertArrayOfAttributeIntsToNonOptional", testShouldConvertArrayOfAttributeIntsToNonOptional),
            ("testShouldConvertArrayOfAttributeIntsToOptional", testShouldConvertArrayOfAttributeIntsToOptional),
            ("testShouldConvertArrayOfAttributeIntsToArrayOfOptionals", testShouldConvertArrayOfAttributeIntsToArrayOfOptionals),
            ("testShouldConvertEmptyArrayOfIntsToNonOptional", testShouldConvertEmptyArrayOfIntsToNonOptional),
            ("testShouldConvertEmptyArrayOfIntsToOptional", testShouldConvertEmptyArrayOfIntsToOptional),
            ("testShouldConvertEmptyArrayOfIntsToArrayOfOptionals", testShouldConvertEmptyArrayOfIntsToArrayOfOptionals)
        ]
    }
}


// ----------------------------
//
// WhiteSpaceParsingTests.swift
//
// ----------------------------

//
//  WhiteSpaceParsingTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import SWXMLHash
import XCTest

// swiftlint:disable line_length
// swiftlint:disable force_try

class WhiteSpaceParsingTests: XCTestCase {
    var xml: XMLIndexer?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
#if SWIFT_PACKAGE
        let path = NSString.path(withComponents: NSString(string: #file).pathComponents.dropLast() + ["test.xml"])
#else
        let bundle = Bundle(for: WhiteSpaceParsingTests.self)
        let path = bundle.path(forResource: "test", ofType: "xml")!
#endif
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        xml = SWXMLHash.parse(data)
    }

    // issue #6
    func testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace() {
        XCTAssertEqual(xml!["niotemplate"]["section"][0]["constraint"][1].element?.text, "H:|-15-[title]-15-|")
    }

    func testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace() {
#if os(Linux)
        print("Skip \(#function) on Linux")
#else
        XCTAssertEqual(xml!["niotemplate"]["other"].element?.text, "
        
  this
  has
  white
  space
        
    ")
#endif
    }
}

extension WhiteSpaceParsingTests {
    static var allTests: [(String, (WhiteSpaceParsingTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace", testShouldBeAbleToPullTextBetweenElementsWithoutWhitespace),
            ("testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace", testShouldBeAbleToCorrectlyParseCDATASectionsWithWhitespace)
        ]
    }
}


// ----------------------------
//
// XMLParsingTests.swift
//
// ----------------------------

//
//  XMLParsingTests.swift
//
//  Copyright (c) 2016 David Mohundro
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SWXMLHash
import XCTest

// swiftlint:disable force_try
// swiftlint:disable line_length

class XMLParsingTests: XCTestCase {
    let xmlToParse = "<root><header>header mixed content<title>Test Title Header</title>more mixed content</header><catalog><book id=\"bk101\"><author>Gambardella, Matthew</author><title>XML Developer's Guide</title><genre>Computer</genre><price>44.95</price><publish_date>2000-10-01</publish_date><description>An in-depth look at creating applications with XML.</description></book><book id=\"bk102\"><author>Ralls, Kim</author><title>Midnight Rain</title><genre>Fantasy</genre><price>5.95</price><publish_date>2000-12-16</publish_date><description>A former architect battles corporate zombies, an evil sorceress, and her own childhood to become queen of the world.</description></book><book id=\"bk103\"><author>Corets, Eva</author><title>Maeve Ascendant</title><genre>Fantasy</genre><price>5.95</price><publish_date>2000-11-17</publish_date><description>After the collapse of a nanotechnology society in England, the young survivors lay the foundation for a new society.</description></book></catalog></root>"

    var xml: XMLIndexer?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        xml = SWXMLHash.parse(xmlToParse)
    }

    func testShouldBeAbleToParseIndividualElements() {
        XCTAssertEqual(xml!["root"]["header"]["title"].element?.text, "Test Title Header")
    }

    func testShouldBeAbleToParseElementGroups() {
        XCTAssertEqual(xml!["root"]["catalog"]["book"][1]["author"].element?.text, "Ralls, Kim")
    }

    func testShouldBeAbleToParseAttributes() {
        XCTAssertEqual(xml!["root"]["catalog"]["book"][1].element?.attribute(by: "id")?.text, "bk102")
    }

    func testShouldBeAbleToLookUpElementsByNameAndAttribute() {
        do {
            let value = try xml!["root"]["catalog"]["book"].withAttribute("id", "bk102")["author"].element?.text
            XCTAssertEqual(value, "Ralls, Kim")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldBeAbleToLookUpElementsByNameAndAttributeCaseInsensitive() {
        do {
            let xmlInsensitive = SWXMLHash.config({ (config) in
                config.caseInsensitive = true
            }).parse(xmlToParse)
            let value = try xmlInsensitive["rOOt"]["catalOg"]["bOOk"].withAttribute("iD", "Bk102")["authOr"].element?.text
            XCTAssertEqual(value, "Ralls, Kim")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testShouldBeAbleToIterateElementGroups() {
        let result = xml!["root"]["catalog"]["book"].all.map({ $0["genre"].element!.text }).joined(separator: ", ")
        XCTAssertEqual(result, "Computer, Fantasy, Fantasy")
    }

    func testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound() {
        XCTAssertEqual(xml!["root"]["header"]["title"].all.count, 1)
    }

    func testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound() {
        XCTAssertEqual(xml!["root"]["header"]["title"][0].element?.text, "Test Title Header")
    }

    func testShouldBeAbleToIterateUsingForIn() {
        var count = 0
        for _ in xml!["root"]["catalog"]["book"].all {
            count += 1
        }

        XCTAssertEqual(count, 3)
    }

    func testShouldBeAbleToEnumerateChildren() {
        let result = xml!["root"]["catalog"]["book"][0].children.map({ $0.element!.name }).joined(separator: ", ")
        XCTAssertEqual(result, "author, title, genre, price, publish_date, description")
    }

    func testShouldBeAbleToHandleMixedContent() {
        XCTAssertEqual(xml!["root"]["header"].element?.text, "header mixed contentmore mixed content")
    }

    func testShouldBeAbleToIterateOverMixedContent() {
        let mixedContentXml = "<html><body><p>mixed content <i>iteration</i> support</body></html>"
        let parsed = SWXMLHash.parse(mixedContentXml)
        let element = parsed["html"]["body"]["p"].element
        XCTAssertNotNil(element)
        if let element = element {
            let result = element.children.reduce("") { acc, child in
                switch child {
                case let elm as SWXMLHash.XMLElement:
                    let text = elm.text
                    return acc + text
                case let elm as TextElement:
                    return acc + elm.text
                default:
                    XCTAssert(false, "Unknown element type")
                    return acc
                }
            }

            XCTAssertEqual(result, "mixed content iteration support")
        }
    }

    func testShouldBeAbleToRecursiveOutputTextContent() {
        let mixedContentXmlInputs = [
            // From SourceKit cursor info key.annotated_decl
            "<Declaration>typealias SomeHandle = <Type usr=\"s:Su\">UInt</Type></Declaration>",
            "<Declaration>var points: [<Type usr=\"c:objc(cs)Location\">Location</Type>] { get set }</Declaration>",
            // From SourceKit cursor info key.fully_annotated_decl
            "<decl.typealias><syntaxtype.keyword>typealias</syntaxtype.keyword> <decl.name>SomeHandle</decl.name> = <ref.struct usr=\"s:Su\">UInt</ref.struct></decl.typealias>",
            "<decl.var.instance><syntaxtype.keyword>var</syntaxtype.keyword> <decl.name>points</decl.name>: <decl.var.type>[<ref.class usr=\"c:objc(cs)Location\">Location</ref.class>]</decl.var.type> { <syntaxtype.keyword>get</syntaxtype.keyword> <syntaxtype.keyword>set</syntaxtype.keyword> }</decl.var.instance>",
            "<decl.function.method.instance><syntaxtype.keyword>fileprivate</syntaxtype.keyword> <syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>documentedMemberFunc</decl.name>()</decl.function.method.instance>"
        ]

        let recursiveTextOutputs = [
            "typealias SomeHandle = UInt",
            "var points: [Location] { get set }",

            "typealias SomeHandle = UInt",
            "var points: [Location] { get set }",
            "fileprivate func documentedMemberFunc()"
        ]

        for (index, mixedContentXml) in mixedContentXmlInputs.enumerated() {
            XCTAssertEqual(SWXMLHash.parse(mixedContentXml).element!.recursiveText, recursiveTextOutputs[index])
        }
    }

    func testShouldHandleInterleavingXMLElements() {
        let interleavedXml = "<html><body><p>one</p><div>two</div><p>three</p><div>four</div></body></html>"
        let parsed = SWXMLHash.parse(interleavedXml)

        let result = parsed["html"]["body"].children.map({ $0.element!.text }).joined(separator: ", ")
        XCTAssertEqual(result, "one, two, three, four")
    }

    func testShouldBeAbleToProvideADescriptionForTheDocument() {
        let descriptionXml = "<root><foo><what id=\"myId\">puppies</what></foo></root>"
        let parsed = SWXMLHash.parse(descriptionXml)

        XCTAssertEqual(parsed.description, "<root><foo><what id=\"myId\">puppies</what></foo></root>")
    }

    // error handling

    func testShouldReturnNilWhenKeysDontMatch() {
        XCTAssertNil(xml!["root"]["what"]["header"]["foo"].element?.name)
    }

    func testShouldProvideAnErrorObjectWhenKeysDontMatch() {
        var err: IndexingError?
        defer {
            XCTAssertNotNil(err)
        }
        do {
            _ = try xml!.byKey("root").byKey("what").byKey("header").byKey("foo")
        } catch let error as IndexingError {
            err = error
        } catch { err = nil }
    }

    func testShouldProvideAnErrorElementWhenIndexersDontMatch() {
        var err: IndexingError?
        defer {
            XCTAssertNotNil(err)
        }
        do {
            _ = try xml!.byKey("what").byKey("subelement").byIndex(5).byKey("nomatch")
        } catch let error as IndexingError {
            err = error
        } catch { err = nil }
    }

    func testShouldStillReturnErrorsWhenAccessingViaSubscripting() {
        var err: IndexingError? = nil
        switch xml!["what"]["subelement"][5]["nomatch"] {
        case .xmlError(let error):
            err = error
        default:
            err = nil
        }
        XCTAssertNotNil(err)
    }
}

extension XMLParsingTests {
    static var allTests: [(String, (XMLParsingTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToParseIndividualElements", testShouldBeAbleToParseIndividualElements),
            ("testShouldBeAbleToParseElementGroups", testShouldBeAbleToParseElementGroups),
            ("testShouldBeAbleToParseAttributes", testShouldBeAbleToParseAttributes),
            ("testShouldBeAbleToLookUpElementsByNameAndAttribute", testShouldBeAbleToLookUpElementsByNameAndAttribute),
            ("testShouldBeAbleToIterateElementGroups", testShouldBeAbleToIterateElementGroups),
            ("testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound", testShouldBeAbleToIterateElementGroupsEvenIfOnlyOneElementIsFound),
            ("testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound", testShouldBeAbleToIndexElementGroupsEvenIfOnlyOneElementIsFound),
            ("testShouldBeAbleToIterateUsingForIn", testShouldBeAbleToIterateUsingForIn),
            ("testShouldBeAbleToEnumerateChildren", testShouldBeAbleToEnumerateChildren),
            ("testShouldBeAbleToHandleMixedContent", testShouldBeAbleToHandleMixedContent),
            ("testShouldBeAbleToIterateOverMixedContent", testShouldBeAbleToIterateOverMixedContent),
            ("testShouldBeAbleToRecursiveOutputTextContent", testShouldBeAbleToRecursiveOutputTextContent),
            ("testShouldHandleInterleavingXMLElements", testShouldHandleInterleavingXMLElements),
            ("testShouldBeAbleToProvideADescriptionForTheDocument", testShouldBeAbleToProvideADescriptionForTheDocument),
            ("testShouldReturnNilWhenKeysDontMatch", testShouldReturnNilWhenKeysDontMatch),
            ("testShouldProvideAnErrorObjectWhenKeysDontMatch", testShouldProvideAnErrorObjectWhenKeysDontMatch),
            ("testShouldProvideAnErrorElementWhenIndexersDontMatch", testShouldProvideAnErrorElementWhenIndexersDontMatch),
            ("testShouldStillReturnErrorsWhenAccessingViaSubscripting", testShouldStillReturnErrorsWhenAccessingViaSubscripting)
        ]
    }
}


// ----------------------------
//
// CheckCoreData.swift
//
// ----------------------------




// ----------------------------
//
// Helpers.swift
//
// ----------------------------

import Foundation

func findFile(rootPath: String, suffix: String) -> [String]? {
    var result = [String]()
    let fm = FileManager.default
    if let paths = fm.subpaths(atPath: rootPath) {
        let storyboardPaths = paths.filter({ return $0.hasSuffix(suffix)})
        for p in storyboardPaths {
            result.append((rootPath as NSString).appendingPathComponent(p))
        }
    }
    return result.count > 0 ? result : nil
}


// ----------------------------
//
// main.swift
//
// ----------------------------

//
//  main.swift
//  JSONToCoreData
//
//  Created by anass talii on 07/06/2017.
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

        // Here check mom xml is correct ie. 1/ there is entity, element
        // 2/ same count of entity and element
        // 3/ there is attribute in entity
        // 4/ other idea
    } catch {
        print("Failed to read \(url): \(error)")
        exit(1)
    }
}

exit(0)


