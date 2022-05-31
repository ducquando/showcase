//
//  RecommendationAlgorithm.swift
//  Showcase
//
//  Created by quannz on 30/05/2022.
//

import Foundation

/// Structure that recommends new articles for user
/// This algorithm is based on the matching article points across all users
/// IMPORTANT: It will be slow since it iterates through all the user's to find the highest one, then
/// recommend that user's read articles
struct RecommendationAlgorithm {
    var ratingDict : [String : Int]                  // [articleID: point]
    var readSet : Set<String>                        // <articleID>
    var allRatingsDict : [String : [String : Int]]   // [userID: [articleID: point]]
    var numUsers : Int

    init(_ userID: String) {
        let db = QueryDB()
        ratingDict = db.queryArticlePointDict(userID)
        readSet = db.queryReadArticles(userID)
        allRatingsDict = db.queryAllUsersAPDict()
        numUsers = db.countUsers()
    }

    /// Return a list of 5 recommended article's IDs based on common rating
    func recommendArticle() -> [String] {
        var recArticle : [String] = []
        var allHighestUsersID : [String] = []


        repeat {
            let highestUser = findHighestUserID(allHighestUsersID)
            allHighestUsersID.append(highestUser)
            let highestUserList = allRatingsDict[highestUser] ?? [:]


            let sortedArticleList = highestUserList.sorted(by: {$0.1 > $1.1})
            for (article, rating) in sortedArticleList {
                if !readSet.contains(article) &&
                    !recArticle.contains(article) && recArticle.count < 5
                    && rating > 0 && !(ratingDict[article] ?? 1 < 0)
                {
                    recArticle.append(article)
                }
            }
        } while recArticle.count < 5 || allHighestUsersID.count == numUsers

        return recArticle
    }

    private func findHighestUserID (_ allHighestUsers : [String]) -> String {
        var highestUser : String = ""
        var highestScore : Double = Double(Int64.min)  // Will be updated

        for (userID, listScore) in allRatingsDict {
            var matchingScore : Double = 0
            for (article1, score1) in listScore {
                for (aricle2, score2) in ratingDict {
                    if article1 == aricle2 {
                        let db = QueryDB()
                        let field1Score = db.queryFieldPointByArticle(article1)
                        matchingScore += Double(score1 * score2) * field1Score
                    }
                }
            }
            if matchingScore > highestScore &&
                !allHighestUsers.contains(userID)
            {
                highestScore = matchingScore
                highestUser = userID
            }
        }

        return highestUser
    }
}

