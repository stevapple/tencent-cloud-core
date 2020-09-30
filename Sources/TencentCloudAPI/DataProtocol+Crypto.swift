import Crypto
import struct Foundation.Data
import protocol Foundation.DataProtocol

private let charA = UInt8(UnicodeScalar("a").value)
private let char0 = UInt8(UnicodeScalar("0").value)

private func itoh(_ value: UInt8) -> UInt8 {
    (value > 9) ? (charA + value - 10) : (char0 + value)
}

extension DataProtocol {
    var hexString: String {
        let hexLen = self.count * 2
        let ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: hexLen)
        var offset = 0

        self.regions.forEach { _ in
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
            var array = [UInt8]()
            for i in 0 ..< Self.byteCount {
                array.append(bytes.load(fromByteOffset: i, as: UInt8.self))
            }
            return array.hexString
        }
    }
}

extension HashedAuthenticationCode {
    var hexString: String {
        withUnsafeBytes { bytes in
            var array = [UInt8]()
            for i in 0 ..< byteCount {
                array.append(bytes.load(fromByteOffset: i, as: UInt8.self))
            }
            return array.hexString
        }
    }

    var data: Data {
        withUnsafeBytes { bytes in
            var array = [UInt8]()
            for i in 0 ..< byteCount {
                array.append(bytes.load(fromByteOffset: i, as: UInt8.self))
            }
            return Data(array)
        }
    }
}
