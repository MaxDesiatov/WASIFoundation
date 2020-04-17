//
//  JSON.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/28/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

/// [JavaScript Object Notation](json.org)
public struct JSON {
    
    public typealias Array = [JSON.Value]
    
    public typealias Object = [String: JSON.Value]
    
    /// JSON value type.
    ///
    /// - Note: Guarenteed to be valid JSON if root value is array or object.
    public enum Value: RawRepresentable, Equatable, CustomStringConvertible {
        
        /// JSON value is a null placeholder.
        case null
        
        /// JSON value is an array of other JSON values.
        case array(SwiftFoundation.JSON.Array)
        
        /// JSON value a JSON object.
        case object(SwiftFoundation.JSON.Object)
        
        /// JSON value is a `String`.
        case string(Swift.String)
        
        /// JSON value is a `Bool`.
        case boolean(Bool)
        
        /// JSON value is a `Int`.
        case integer(Int)
        
        /// JSON value is a `Double`.
        case double(Swift.Double)
    }
}

// MARK: Extract Values

public extension JSON.Value {
    
    var arrayValue: JSON.Array? {
        
        guard case let .array(value) = self else { return nil }
        
        return value
    }
    
    var objectValue: JSON.Object? {
        
        guard case let .object(value) = self else { return nil }
        
        return value
    }
    
    var stringValue: String? {
        
        guard case let .string(value) = self else { return nil }
        
        return value
    }
    
    var booleanValue: Bool? {
        
        guard case let .boolean(value) = self else { return nil }
        
        return value
    }
    
    var integerValue: Int? {
        
        guard case let .integer(value) = self else { return nil }
        
        return value
    }
    
    var doubleValue: Double? {
        
        guard case let .double(value) = self else { return nil }
        
        return value
    }
}

// MARK: RawRepresentable

public extension JSON.Value {
    
    var rawValue: Any {
        
        switch self {
            
        case .null: return SwiftFoundation.Null()
            
        case .string(let value): return value
            
        case .integer(let value): return value
            
        case .boolean(let value): return value
            
        case .double(let value): return value
            
        case .array(let array): return array.rawValues
            
        case .object(let dictionary):
            
            var dictionaryValue = [String: Any](minimumCapacity: dictionary.count)
            
            for (key, value) in dictionary {
                
                dictionaryValue[key] = value.rawValue
            }
            
            return dictionary
        }
    }
    
    init?(rawValue: Any) {
        
        guard rawValue is SwiftFoundation.Null == false else {
            
            self = .null
            return
        }
        
        if let string = rawValue as? Swift.String {
            
            self = .string(string)
            return
        }
        
        if let integer = rawValue as? Int {
            
            self = .integer(integer)
            return
        }
        
        if let boolean = rawValue as? Bool {
            
            self = .boolean(boolean)
            return
        }
        
        if let double = rawValue as? Double {
            
            self = .double(double)
            return
        }
        
        if let rawArray = rawValue as? [Any],
            let jsonArray: [JSON.Value] = JSON.Value.from(rawValues: rawArray) {
            
            self = .array(jsonArray)
            return
        }
        
        if let rawDictionary = rawValue as? [Swift.String: Any] {
            
            var jsonObject: [Swift.String: JSON.Value] = Dictionary(minimumCapacity: rawDictionary.count)
            
            for (key, rawValue) in rawDictionary {
                
                guard let jsonValue = JSON.Value(rawValue: rawValue)
                    else { return nil }
                
                jsonObject[key] = jsonValue
            }
            
            self = .object(jsonObject)
            return
        }
        
        return nil
    }
}


// MARK: CustomStringConvertible

public extension JSON.Value {
    
    var description: String {
        
        return "\(rawValue)"
    }
}
