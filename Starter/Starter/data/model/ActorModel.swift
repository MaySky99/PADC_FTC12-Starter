//
//  ActorModel.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation

protocol ActorModel {
    func getActorDetailById(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void)
    func getActorCredit(id: Int, completion: @escaping (MDBResult<ActorCreditResponse>) -> Void)
}

class ActorModelImplementation : BasicModel, ActorModel {
    
    static let shared = ActorModelImplementation()
    
    private override init() { }
    
    func getActorDetailById(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void) {
        networkAgent.getActorDetailById(id: id, completion: completion)
    }
    
    func getActorCredit(id: Int, completion: @escaping (MDBResult<ActorCreditResponse>) -> Void) {
        networkAgent.getActorCredit(id: id, completion: completion)
    }
    
    
}
