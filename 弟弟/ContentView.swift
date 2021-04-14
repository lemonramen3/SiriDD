//
//  ContentView.swift
//  弟弟
//
//  Created by xinghao wang on 2021/3/11.
//

import SwiftUI
import Intents

struct QAQuery: Codable {
//    let token: String
//    let app: String
//    let content: String
    let que: String
}

struct Response: Codable {
//    let result: Result
//    let status: Bool
    let answer: String
}
struct Result: Codable {
    let bullet_id: String
    let content: String
    let type: Int
}
var TOKEN = "b84fc35e83491ca74dc1afe651bc2530"
var QA_APP = "qa"
var CONTENT = "睡不着觉怎么办？"


struct ContentView: View {
//    @State var response = [Response]()
    @State private var inputText: String = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
//    @State private var resultText: String = ""
//    let query = QAQuery(token: TOKEN, app: QA_APP, content: CONTENT)
    

    func askModel(query: QAQuery){
        print(inputText)
        makeDonation(question: inputText)
        guard let url = URL(string: "http://103.242.175.116:8000/qa/") else {
            print("Invalid URL")
            return
        }
        guard let encoded = try? JSONEncoder().encode(query) else {
            print("Failed to encode query")
            return
        }
        print(String(data: encoded, encoding: .utf8))
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encoded
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            print(String(data: data, encoding: .utf8))
            if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                print(decoded)
                self.confirmationMessage = decoded.answer
//                self.confirmationMessage = decoded.result.content
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }

    var body: some View {
        Text("Hey")
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Answer"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        TextEditor(text: $inputText)
        Button("问问"){
            print("Hey")
            let query = QAQuery(que: inputText)
//            let query = QAQuery(token: TOKEN, app: QA_APP, content: inputText)
            askModel(query: query)
        }
    }
    func makeDonation(question: String) {
        let intent = AskQuestionIntent()
        intent.question = question
        intent.suggestedInvocationPhrase = "问问弟弟"
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
                    if error != nil {
                        if let error = error as NSError? {
                            print(
                             "Donation failed: %@" + error.localizedDescription)
                        }
                    } else {
                        print("Successfully donated interaction")
                    }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
