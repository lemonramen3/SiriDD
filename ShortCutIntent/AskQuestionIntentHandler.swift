//
//  AskQuestionIntentHandler.swift
//  弟弟
//
//  Created by xinghao wang on 2021/3/21.
//
import SwiftUI
import Intents

class AskQuestionIntentHandler: NSObject, AskQuestionIntentHandling {
    private var confirmationMessage = "弟弟忙着呢你等会儿"

    func handle(intent: AskQuestionIntent, completion: @escaping (AskQuestionIntentResponse) -> Void) {
        guard let question = intent.question else {
            completion(AskQuestionIntentResponse(code: .failure, userActivity: nil))
            return
        }
//        askQuestion(question: question)
//        print(confirmationMessage)
//        if answer {
//            completion(AskQuestionIntentResponse.success(answer: confirmationMessage))
//        } else {
//            completion(AskQuestionIntentResponse.success(answer: "Ans"))
//
//        }
        askQuestion(question: question)
        let time = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now()+time) {
            completion(AskQuestionIntentResponse.success(answer: self.confirmationMessage))
        }
    }
    func askQuestion(question: String) {
        print("Question: \(question)")
        guard let url = URL(string: "http://103.242.175.116:8000/qa/") else {
            print("Invalid URL")
            return
        }
        let query = QAQuery(que: question)
//        let query = QAQuery(token: TOKEN, app: QA_APP, content: question)
        guard let encoded = try? JSONEncoder().encode(query) else {
            print("Failed to encode query")
            return
        }
        print(encoded)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encoded
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                print(decoded)
                DispatchQueue.main.async {
                    self.confirmationMessage = decoded.answer
//                    self.confirmationMessage = decoded.result.content
                }
            } else {
                print("Invalid response from server")
            }
        }.resume()
        
    }
    
    func resolveQuestion(for intent: AskQuestionIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let question = intent.question {
            completion(INStringResolutionResult.success(with: question))
        }
        else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    
}
