//
//  ServerListViewModel.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import Foundation
import NetworkExtension

class ServerListViewModel {
    
    var view: ServerListViewController?
    
    var listOfLocations = [ServerListData]()
    
    var username: String = "prd_test_j4d3vk6"
    
    
    func fetchServersJSON(completion: @escaping (Result<Servers, Error>) -> ()) {
        
        let urlString = "https://assets.windscribe.com/serverlist/ikev2/1/89yr4y78r43gyue4gyut43guy"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            // successful
            do {
                let serverList = try JSONDecoder().decode(Servers.self, from: data!)
                
                DispatchQueue.main.async {
                    self.view?.setupViews()
                       }
                
                completion(.success(serverList))
    
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
        }.resume()
    }
    
    func listServers() {
        fetchServersJSON { (result) in
            switch result {
            case .success(let servers):
                self.listOfLocations = servers.data
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func setupVpnConfigurations(vpnHost: String) {
        
        NEVPNManager.shared().loadFromPreferences { error in
            
            let password = "xpcnwg6abh"
            let vpnProtocol = NEVPNProtocolIKEv2()
                vpnProtocol.username = self.username
                vpnProtocol.localIdentifier = self.username
                vpnProtocol.serverAddress = vpnHost
                vpnProtocol.remoteIdentifier = vpnHost
                vpnProtocol.authenticationMethod = .none
                vpnProtocol.useExtendedAuthentication = true
                vpnProtocol.serverCertificateIssuerCommonName = vpnHost
                vpnProtocol.disconnectOnSleep = false
            
            
            vpnProtocol.ikeSecurityAssociationParameters.encryptionAlgorithm =  NEVPNIKEv2EncryptionAlgorithm.algorithmAES256GCM
            vpnProtocol.ikeSecurityAssociationParameters.diffieHellmanGroup = NEVPNIKEv2DiffieHellmanGroup.group21
            vpnProtocol.ikeSecurityAssociationParameters.integrityAlgorithm = NEVPNIKEv2IntegrityAlgorithm.SHA256
            vpnProtocol.ikeSecurityAssociationParameters.lifetimeMinutes = 1440
            vpnProtocol.childSecurityAssociationParameters.encryptionAlgorithm =  NEVPNIKEv2EncryptionAlgorithm.algorithmAES256GCM
            vpnProtocol.childSecurityAssociationParameters.diffieHellmanGroup = NEVPNIKEv2DiffieHellmanGroup.group21
            vpnProtocol.childSecurityAssociationParameters.integrityAlgorithm = NEVPNIKEv2IntegrityAlgorithm.SHA256
            vpnProtocol.childSecurityAssociationParameters.lifetimeMinutes = 1440


            var rules = [NEOnDemandRule]()
            let rule = NEOnDemandRuleConnect()
            rule.interfaceTypeMatch = .any
            rules.append(rule)

            NEVPNManager.shared().localizedDescription = "My VPN"
            NEVPNManager.shared().protocolConfiguration = vpnProtocol
            NEVPNManager.shared().onDemandRules = rules
            NEVPNManager.shared().isOnDemandEnabled = true
            NEVPNManager.shared().isEnabled = true
            NEVPNManager.shared().saveToPreferences { error in
                guard error == nil else {
                    print("NEVPNManager.saveToPreferencesWithCompletionHandler failed: \(error!.localizedDescription)")
                    return
                }
            
                
                do {
                    try NEVPNConnection.startVPNTunnel(<#T##self: NEVPNConnection##NEVPNConnection#>)
                    
                } catch let error {
                    
                }
                
                }
            
        }
    }
}
