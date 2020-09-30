import struct Foundation.Data
import protocol Foundation.DataProtocol
import Crypto

let charA = UInt8(UnicodeScalar("a").value)
let char0 = UInt8(UnicodeScalar("0").value)

private func itoh(_ value: UInt8) -> UInt8 {
    return (value > 9) ? (charA + value - 10) : (char0 + value)
}

extension DataProtocol {
    var hexString: String {
        let hexLen = self.count * 2
        let ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: hexLen)
        var offset = 0

        self.regions.forEach { (_) in
            for i in self {
                ptr[Int(offset * 2)] = itoh((i >> 4) & 0xF)
                ptr[Int(offset * 2 + 1)] = itoh(i & 0xF)
                offset += 1
            }
        }

        return String(bytesNoCopy: ptr, length: hexLen, encoding: .utf8, freeWhenDone: true)!
    }
    
    
}

extension SHA256Digest {
    var hexString: String {
        withUnsafeBytes { bytes in
            let array = bytes.load(as: [UInt8].self)
            return array.hexString
        }
    }
}

extension HashedAuthenticationCode {
    var hexString: String {
        withUnsafeBytes { bytes in
            let array = bytes.load(as: [UInt8].self)
            return array.hexString
        }
    }
    var data: Data {
        withUnsafeBytes { bytes in
            let array = bytes.load(as: [UInt8].self)
            return Data(array)
        }
    }
}
