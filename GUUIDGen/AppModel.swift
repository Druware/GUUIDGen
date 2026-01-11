//
//  AppModel.swift
//  GUUIDGen
//
//  Created by Andrew Satori on 11/9/21.
//

import Foundation

extension UUID {
    public func asUInt8Array() -> [UInt8]{
        let (u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16) = self.uuid
        return [u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16]
    }
    public func asData() -> Data{
        return Data(self.asUInt8Array())
    }
}

enum GUIDFormat {
    case oleCreate
    case define
    case staticConst
    case string
}

class GUUIDGenAppModel : ObservableObject {
    @Published public var uuid : UUID = UUID()
    @Published public var uuidString : String = "";
    
    private var _guidFormat : GUIDFormat = GUIDFormat.string
    public var guidFormat : GUIDFormat {
        get {
            return _guidFormat
        }
        set {
            _guidFormat = newValue
            uuidString = getUuidString()
        }
    }

    private func getUuidString() -> String {
        let bytes : [UInt8] = uuid.asUInt8Array()
        
        // based upon the format, format the output string accordingly
        switch guidFormat {
        case GUIDFormat.oleCreate:
            uuidString = String(format: "// {%@}\nIMPLEMENT_OLECREATE(<<class>>, <<external_name>>,\n0x%x%x%x%x, 0x%x%x, 0x%x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x);",
                                uuid.uuidString,
                                bytes[0],
                                bytes[1],
                                bytes[2],
                                bytes[3],
                                bytes[4],
                                bytes[5],
                                bytes[6],
                                bytes[7],
                                bytes[8],
                                bytes[9],
                                bytes[10],
                                bytes[11],
                                bytes[12],
                                bytes[13],
                                bytes[14])
            break
        case GUIDFormat.define:
            uuidString = String(format:"// {%@}\nDEFINE_GUID(<<name>>,\n0x%x%x%x%x, 0x%x%x, 0x%x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x);",
                                uuid.uuidString,
                                bytes[0],
                                bytes[1],
                                bytes[2],
                                bytes[3],
                                bytes[4],
                                bytes[5],
                                bytes[6],
                                bytes[7],
                                bytes[8],
                                bytes[9],
                                bytes[10],
                                bytes[11],
                                bytes[12],
                                bytes[13],
                                bytes[14])
            break
        case GUIDFormat.staticConst:
            uuidString = String(format: "// {%@}\nstatic const GUID <<name>> = \n{ 0x%x%x%x%x, 0x%x%x, 0x%x%x, { 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x } };",
                               uuid.uuidString,
                               bytes[0],
                               bytes[1],
                               bytes[2],
                               bytes[3],
                               bytes[4],
                               bytes[5],
                               bytes[6],
                               bytes[7],
                               bytes[8],
                               bytes[9],
                               bytes[10],
                               bytes[11],
                               bytes[12],
                               bytes[13],
                               bytes[14])
            break
        default:
            uuidString = uuid.uuidString
        }
        
        return uuidString
    }
    
    public func newGuid() {
        uuid = UUID()
        uuidString = getUuidString()
    }
    
    init() {
        uuidString=getUuidString()
    }
}
