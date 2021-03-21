//
//  Data.swift
//  弟弟
//
//  Created by xinghao wang on 2021/3/11.
//

import SwiftUI

//struct QAQuery: Codable {
//    let token: String
//    let app: String
//    let content: String
//}
//
//struct Response: Codable {
//    let result: Result
//    let status: Bool
//}
//struct Result: Codable {
//    let bullet_id: String
//    let content: String
//    let type: Int
//}
//var TOKEN = "b84fc35e83491ca74dc1afe651bc2530"
//var QA_APP = "qa"
////var CONTENT = "如何看待天津初中男生做引体向上平均值不到两个?何原因导致该结果出现?素质教育是否应加强体育方面的管控?天津公布 2020 年全市中小学生体质健康监测情况，初、高中男生在单杠上做引 体向上，平均竟然只能做 1.7 个和 3.7 个，不及格率分别达到了 87% 和 82%。"
//
////let query = QAQuery(token: TOKEN, app: QA_APP, content: CONTENT)
//
//
//
//class Api {
//     private var inputText: String = ""
//     private var confirmationMessage = ""
//     private var showingConfirmation = false
//    init(text: String, message: String, show: Bool) {
//        self.inputText = text
//        self.confirmationMessage = message
//        self.showingConfirmation = show
//    }
//    func askModel() {
//        let query = QAQuery(token: TOKEN, app: QA_APP, content: self.inputText)
//        print(self.inputText)
//        guard let url = URL(string: "https://lab.aminer.cn/isoa-2021/gpt") else {
//            print("Invalid URL")
//            return
//        }
//        guard let encoded = try? JSONEncoder().encode(query) else {
//            print("Failed to encode query")
//            return
//        }
//        print(encoded)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = encoded
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
//                return
//            }
//            if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
//                print(decoded)
//                self.confirmationMessage = decoded.result.content
//                self.showingConfirmation = true
//                return
//            } else {
//                print("Invalid response from server")
//            }
//        }.resume()
//    }
//    func input(input: String) {
//        self.inputText = input
//    }
//    func getConfirmationMessage() -> String {
//        return self.confirmationMessage
//    }
//    func getShowingConfirmation() -> Bool {
//        return self.showingConfirmation
//    }
//}
