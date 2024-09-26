import AppRemoteConfig
import ArgumentParser
import Dependencies
import Foundation
import SodiumClient

extension Care {
    struct CreateKeyPair: ParsableCommand {
        static var configuration =
            CommandConfiguration(abstract: "Prepare a new key pair for signing a config.")
        
        mutating func run() throws {
            @Dependency(\.sodiumClient) var sodiumClient
            guard let keyPair = sodiumClient.keyPair() else {
                return
            }
            
            let publicKey = keyPair.publicKey
            print("The \("public", effect: .bold) key is \"\(publicKey, effect: .blue)\".")
            
            let secretKey = keyPair.secretKey
            print("The \("secret", effect: .bold) key is \"\(secretKey, effect: .yellow)\".")
        }
    }
}
