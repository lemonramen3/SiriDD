//
//  IntentHandler.swift
//  ShortCutIntent
//
//  Created by xinghao wang on 2021/3/20.
//

import Intents


class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is AskQuestionIntent else {
            fatalError("Unknown intent type: \(intent)")
        }
        return AskQuestionIntentHandler()
    }
    
}
