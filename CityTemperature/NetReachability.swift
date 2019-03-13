

import Foundation
import SystemConfiguration

public enum NetReachabilityType {
    case WWAN,
    WiFi,
    NotConnected
}

public class NetReachability {
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
//        var zeroAddress = sockaddr_in(sin_len: sizeof(zeroAddress), sin_family: AF_INET, sin_port: nil, sin_addr: nil
//        
//       // var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
//        }
//        
//        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: UInt32(0))
//        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
//            return false
//        }
//        
//        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        
//        return (isReachable && !needsConnection) ? true : false
//    }
    
    
    
    //        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer())
//        }
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)
//    }
    
//    let reachability: Reachability = .reachabilityForInternetConnection()
//            let networkStatus = reachability.currentReachabilityStatus().rawValue;
//            var isAvailable  = false;
//
//            switch networkStatus
//            {
//            case (NotReachable.rawValue):
//                isAvailable = false;
//                break;
//            case (ReachableViaWiFi.rawValue):
//                isAvailable = true;
//                break;
//            case (ReachableViaWWAN.rawValue):
//                isAvailable = true;
//                break;
//            default:
//                isAvailable = false;
//                break;
//            }
//            return isAvailable;
//        }
//
}
    
    
    /****************InViewController******************
    
    if IJReachability.isConnectedToNetwork() {
    availabilityLabel.text = "Network Connection: Available"
    availabilityLabel.textColor = UIColor.greenColor()
    } else {
    availabilityLabel.text = "Network Connection: Unavailable"
    availabilityLabel.textColor = UIColor.redColor()
    }
    
    let statusType = IJReachability.isConnectedToNetworkOfType()
    switch statusType {
    case .WWAN:
    connectionTypeLabel.text = "Connection Type: Mobile"
    connectionTypeLabel.textColor = UIColor.yellowColor()
    case .WiFi:
    connectionTypeLabel.text = "Connection Type: WiFi"
    connectionTypeLabel.textColor = UIColor.greenColor()
    case .NotConnected:
    connectionTypeLabel.text = "Connection Type: Not connected to the Internet"
    connectionTypeLabel.textColor = UIColor.redColor()
    }
    }
    *************************************/
