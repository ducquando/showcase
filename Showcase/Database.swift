//
//  Database.swift
//  Showcase
//
//  Created by quannz on 26/05/2022.
//

import Foundation
import SQLite

/// Class representing the database
class SQLiteDB {
    /// The main database
    let db: Connection?
    
    /// Open the database
    init() {
        /// Database link
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        // Connect to the database
        do {
            db = try Connection("\(path)/showcase.sqlite")
        } catch {
            print("Cannot connect to the database")
            db = nil
        }
    }
    
    /// Get document's directory url
    /// Created by Paul Hudson on 28/05/2019 on
    /// https://www.hackingwithswift.com/example-code/system/how-to-find-the-users-documents-directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

/// Class for querying the database
class QueryDB : SQLiteDB {
    /// Fetch the user's id from the database, given their email and password
    func queryUserID(email inputEmail: String,
                     pass inputPassword: String) -> String {
        /// Table `USER`
        let users = Table("USER")
        /// Column `ID` (DType: Int64)
        let id = Expression<Int>("ID")
        /// Column `Email` (DType: String)
        let email = Expression<String>("Email")
        /// Column `Password` (DType: String)
        let password = Expression<String>("Password")
        
        /// SELECT ID FROM USERS
        /// WHERE EMAIL IS \(email) AND PASSWORD IS \(Password)
        let query = users.select(id)
            .filter(email == inputEmail)
            .filter(password == inputPassword)
        do {
            for user in try db!.prepare(query){
                print("Fected sucessfully")
                // Return the first one since the id is unique
                // IMPORTANT: CANNOT HANDLE SQL INJECTION
                return String(user[id])
            }
        } catch {
            print("Unable to query the user")
        }
        
        // Return an empty string if there is no matching user
        return ""
    }
    
    /// Add new key-value to the existing map, given the row and title to fetch from the database
    private func addToArticleInfoMap(_ row: Row, _ columnHeader: String,
                                     _ previousMap: [String:String]) -> [String: String] {
        /// Column from the database
        let column = Expression<String>(columnHeader)
        /// Info map
        var newMap = previousMap
        
        // Add new key-value to the map
        newMap[columnHeader] = row[column]
        return newMap
    }
    
    /// Return the number of existing users in the database
    func countUsers() -> Int {
        /// Table  `User`
        let user = Table("User")
        /// Number of users in the database
        var count = 0  // default value
        
        // Query table
        do {
            /// SELECT COUNT(*) FROM USER
            count = try db!.scalar(user.count)
        } catch {
            print("Cannot query table \(user)")
        }
        
        return count
    }
    
    /// Fetch the article's information in the ArticleView, given an article's id
    func queryArticle(articleID id: String) -> [String: String]{
        /// Information
        var infoMap: [String: String] = [:]
        /// The article's id in integer
        let articleID = Int(id) ?? 0
        
        /// Table `ArticleView`
        let article = Table("ArticleView")
        /// Column `ID`
        let id = Expression<Int>("ID")
        /// List of columns' name
        let listHeaders = ["Title", "Author", "FieldName", "ImageURL",
                           "Abstract", "Introduction", "Methodology", "Findings",
                           "Discussion", "Conclusion"]
        
        /// SELECT * FROM ArticleView
        /// WHERE ID = `articleID`
        let statement = article.filter(id == articleID)
        
        // Query table
        do {
            // Only have 1 row since id is unique
            for info in try db!.prepare(statement) {
                for header in listHeaders {
                    infoMap = addToArticleInfoMap(info, header, infoMap)
                }
            }
        } catch {
            print("Cannot query article \(articleID)")
        }
        return infoMap
    }
    
    /// Find all articles containing the specific text on the title
    func queryArticlesByTitle(_ text: String) -> [String] {
        /// List of articles
        var articleList : [String] = []
        
        /// Table `ArticleView`
        let article = Table("ArticleView")
        /// Column `Title`
        let title = Expression<String>("Title")
        /// Column `ID`
        let id = Expression<Int>("ID")
        
        /// SELECT * FROM ArticleView
        /// WHERE Title LIKE "%`text`%"
        let fullTitle = "%" + text + "%"
        let statement = article.filter(title.like(fullTitle))
        
        // Query table
        do {
            for artRow in try db!.prepare(statement) {
                articleList.append(String(artRow[id]))
            }
        } catch {
            print("Cannot query text \(text)")
        }
        
        return articleList
    }
    
    /// Find an article's field name
    func queryFieldNameByArticle(_ articleID: String) -> String {
        ///  The article's id in Integer. Return an empty string if cannot convert.
        guard let queryArticle = Int(articleID) else {
            print("Cannot convert \(articleID) to Integer")
            return ""
        }
        
        /// Table `ArticleView`
        let article = Table("ArticleView")
        /// Column `ID`
        let id = Expression<Int>("ID")
        /// Column `FieldName`
        let field = Expression<String>("FieldName")
        
        /// SELECT FieldName FROM ArticleView
        /// WHERE ID == `articleID`
        let subQuery = article.select(field).filter(id == queryArticle)
        
        // Query table
        do {
            for result in try db!.prepare(subQuery) {
                return result[field]
            }
        } catch {
            print("Cannot query")
        }
        
        return ""
    }
    
    /// Returns the field point given the article's id
    func queryFieldPointByArticle(_ article: String) -> Double {
        /// The article's id in Int
        guard let articleID = Int(article) else {
            print("Cannot convert \(article) to Int")
            return 1.0   // default value for field point
        }
        
        return queryFieldPointByArticle(articleID)
    }
    
    /// Returns the field point given the article's id
    func queryFieldPointByArticle(_ articleID: Int) -> Double {
        /// Table `FIELD_POINT`
        let fieldPoint = Table("FIELD_POINT")
        /// Table `ARTICLE`
        let article = Table("ARTICLE")
        /// Column `Point`
        let point = Expression<Double>("Point")
        /// Column `FieldID`
        let fieldID = Expression<Int>("FieldID")
        /// Column `ID`
        let id = Expression<Int>("ID")
        
        /// SELECT FieldID FROM ARTICLE
        /// WHERE ID == `articleID`
        let subQuery = article.select(fieldID).filter(id == articleID)
        
        // Query table
        do {
            // Only has 1 element, so return the first one
            for row in try db!.prepare(subQuery) {
                /// SELECT Point FROM FIELD_POINT
                /// WHERE FieldID IN
                ///     ( SELECT FieldID FROM ARTICLE
                ///      WHERE ID == `articleID`)
                let query = fieldPoint.select(point).filter(fieldID == row[fieldID])
                for fieldValue in try db!.prepare(query) {
                    return fieldValue[point]
                }
            }
        } catch {
            print("Cannot query table FIELD_POINT")
        }
        
        // If reach here, there is no match -> return default value (1)
        return 1;
    }
    
    
    /// Return all articles' id from the SAVED_ARTICLES table given an user's id
    func querySavedArticles(_ userID: String) -> [String] {
        /// List of articles
        var articleList : [String] = []
        /// User's id in Integer
        guard let userIDInt = Int(userID) else {
            print("Cannot convert \(userID) to Int")
            // Return an empty list if cannot convert user's id
            return []
        }
        
        /// Table `SAVE_ARTICLES`
        let savedArticles = Table("SAVE_ARTICLES")
        /// Column `Title`
        let article = Expression<Int>("ArticleID")
        /// Column `ID`
        let user = Expression<Int>("UserID")
        
        /// SELECT ArticleID FROM ArticleView
        /// WHERE UserID == `userID`
        let query = savedArticles.select(article).filter(user == userIDInt)
        
        // Query table
        do {
            for artRow in try db!.prepare(query) {
                articleList.append(String(artRow[article]))
            }
        } catch {
            print("Cannot query")
        }
        
        return articleList
    }
    
    /// Returns the set of an user's graded articles (articles found in ARTICLE_POINT table)
    func queryReadArticles(_ userID: String) -> Set<String> {
        /// User's id in Integer
        guard let user = Int(userID) else {
            print("Cannot convert \(userID) to Int")
            return []
        }
        return queryReadArticles(user)
    }
    
    /// Returns the set of an user's graded articles (articles found in ARTICLE_POINT table)
    func queryReadArticles(_ userID: Int) -> Set<String> {
        var returnSet : Set<String> = []
        
        /// Table `ARTICLE_POINT`
        let articlePoint = Table("ARTICLE_POINT")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Column `ArticleID`
        let article = Expression<Int>("ArticleID")
        
        /// SELECT ArticleID FROM ARTICLE_POINT
        /// WHERE UserID = `userID`
        let query = articlePoint.select(article).filter(user == userID)
        
        // Query table
        do {
            for row in try db!.prepare(query) {
                returnSet.insert(String(row[article]))
            }
        } catch {
            print("Cannot query table ARTICLE_POINT with userID \(userID)")
        }
        return returnSet
    }
    
    /// Returns the dictionary of an user's all article's point
    func queryArticlePointDict(_ userID: String) -> [String: Int] {
        /// User's id in Integer
        guard let user = Int(userID) else {
            print("Cannot convert \(userID) to Int")
            return [:]
        }
        return queryArticlePointDict(user)
    }
    
    /// Returns the dictionary of an user's all article's point
    func queryArticlePointDict(_ userID: Int) -> [String: Int] {
        /// The returned article's point dict
        var returnDict : [String: Int] = [:]
        
        /// Table `ARTICLE_POINT`
        let articlePoint = Table("ARTICLE_POINT")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Coulumn `ArticleID`
        let article = Expression<Int>("ArticleID")
        /// Column `Point`
        let point = Expression<Int>("Point")
        
        /// SELECT ArticleID, Point FROM ARTICLE_POINT
        /// WHERE UserID = `userID`
        let query = articlePoint.select(article, point).filter(user == userID)
        
        // Query table
        do {
            for row in try db!.prepare(query) {
                let key = String(row[article])
                let value = row[point]
                returnDict[key] = value
            }
        } catch {
            print("Cannot query table ARTICLE_POINT with userID \(userID)")
        }
        return returnDict
    }
    
    /// Returns the nested dictionary of all users' article point dictionary
    /// IMPORTANT: This will cause the program functions slowly if the number of users is high (e.g. > 30)
    func queryAllUsersAPDict() -> [String: [String: Int]] {
        /// The returned article's point dict
        var returnDict : [String: [String: Int]] = [:]
        
        /// Table `USER`
        let user = Table("USER")
        /// Column `ID`
        let id = Expression<Int>("ID")
        
        /// SELECT ID FROM USER
        let query = user.select(id)
        
        do {
            for user in try db!.prepare(query) {
                
                let userID = String(user[id])
                // Add all users' article point dict to the total dict with the
                // key being their id
                returnDict[userID] = queryArticlePointDict(userID)
            }
        } catch {
            print("Cannot query table USER")
        }
        return returnDict
    }
}

/// Class for updating the database
class UpdateDB: SQLiteDB {
    /// Get field's id from field name. Return -1 if not found.
    private func getFieldID(_ Fname: String) -> Int {
        /// Table `FIELD`
        let field = Table("FIELD")
        /// Column `ID`
        let id = Expression<Int>("ID")
        /// Column `Name`
        let name = Expression<String>("Name")
        
        /// SELECT * FROM FIELD
        /// WHERE ID = `articleID`
        let statement = field.filter(name == Fname)
        
        // Query table
        do {
            // Only have 1 row since id is unique
            for row in try db!.prepare(statement) {
                return row[id]
            }
        } catch {
            print("Cannot query field with name \(Fname)")
        }
        
        // Unable to query
        return -1
    }
    
    /// Increase or decrease an user's field point by 0.1 according to the doIncrease boolean
    func updateFieldPoint(_ user: String, _ fieldName: String,
                          _ doIncrease: Bool){
        /// User's id
        let userID = Int(user) ?? -1
        /// Field's id
        let fieldID = getFieldID(fieldName)
        
        // Insert if not exists a matching user and field
        if userID == -1 || fieldID == -1 {
            let newDB = InsertToDB()
            newDB.insertFieldPoint(userID, fieldID)
        }
        updateFieldPointHelper(userID, fieldID, doIncrease)
    }
    
    
    /// Update an user's associated field point by summing up with the given amount
    private func updateFieldPointHelper(_ userID: Int, _ fieldID: Int,
                                        _ doIncrease: Bool){
        /// Table `FIELD_POINT`
        let fieldPoint = Table("FIELD_POINT")
        /// Column `FieldID`
        let field = Expression<Int>("FieldID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Column `Point`
        let point = Expression<Double>("Point")
        
        /// Amount of point being added or subtracted
        let amount : Double = 0.1
        
        /// SELECT * FROM FIELD_POINT
        /// WHERE UserID = `userID` AND FieldID = `fieldID`
        let pointByUser = fieldPoint.filter(user == userID && field == fieldID)
        
        // Query table
        do {
            // BEGIN DEFERRED TRANSACTION
            try db!.transaction {
                // UPDATE FIELD_POINT
                // SET Point = Point +/- `amount`
                // WHERE UserID = `userID` AND FieldID = `fieldID`
                if doIncrease {
                    try db!.run(pointByUser.update(point += amount))
                } else {
                    try db!.run(pointByUser.update(point -= amount))
                }
            }
            // COMMIT TRANSACTION
        } catch {
            print("Cannot update field point")
        }
    }
    
    /// Increase an user's article point by 1 and field point by 0.1
    func increaseArticleAndFieldPoint(_ user: String, _ article: String,
                                      _ fieldName: String){
        /// User's id
        let userID = Int(user) ?? -1
        /// Field's id
        let articleID = Int(article) ?? -1
        
        /// Amount of point being added
        let amount = 1.0
        
        // Update if exists valid user and field
        if userID != -1 && articleID != -1 {
            updateArticlePointHelper(userID, articleID, amount)
            // Also call for field point's updation
            updateFieldPoint(user, fieldName, true)
        }
    }
    
    /// Update an user's article point. The update amount must be smaller than 0.
    func updateArticlePoint(_ user: String, _ article: String, _ newPoint: Double){
        /// User's id
        let userID = Int(user) ?? -1
        /// Field's id
        let articleID = Int(article) ?? -1
        
        // The newPoint must < 0
        if newPoint < 0 {
            return
        }
        
        // Update if exists a valid user and field
        if userID != -1 && articleID != -1 {
            updateArticlePointHelper(userID, articleID, newPoint)
        }
    }
    
    /// Update an user's associated field point by summing up with the given amount
    private func updateArticlePointHelper(_ userID: Int, _ articleID: Int,
                                          _ amount: Double){
        /// Table `ARTICLE_POINT`
        let articlePoint = Table("ARTICLE_POINT")
        /// Column `FieldID`
        let article = Expression<Int>("ArticleID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Column `Point`
        let point = Expression<Double>("Point")
        
        /// SELECT * FROM ARTICLE_POINT
        /// WHERE UserID = `userID` AND ArticleD = `ArticleID`
        let pointByUser = articlePoint.filter(user == userID && article == articleID)
        
        // Query table
        do {
            // BEGIN DEFERRED TRANSACTION
            try db!.transaction {
                // UPDATE ARTICLE_POINT
                // SET Point = Point + `amount` OR Point = `amount`
                // WHERE UserID = `userID` AND FieldID = `fieldID`
                if (amount > 0) {
                    try db!.run(pointByUser.update(point += amount))
                } else {
                    try db!.run(pointByUser.update(point <- amount))
                }
            }
            // COMMIT TRANSACTION
        } catch {
            print("Cannot update field point")
        }
    }
    
    
}

/// Class for inserting to the database.
class InsertToDB: SQLiteDB {
    /// Insert a new user's field point
    /// The point is initially set to 1
    func insertFieldPoint(_ userID: Int, _ fieldID: Int){
        /// Table `FIELD_POINT`
        let fieldPoint = Table("FIELD_POINT")
        /// Column `FieldID`
        let field = Expression<Int>("FieldID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Column `Point`
        let point = Expression<Double>("Point")
        /// Point inserted
        let newPoint: Double = 1.0
        
        // Query table
        do {
            // BEGIN DEFERRED TRANSACTION
            try db!.transaction {
                // INSERT INTO FIELD_POINT (UserID, ArticleID, Point)
                // VALUES (`userID`, `articleID`, `newPoint`)
                try db!.run(fieldPoint.insert(field <- fieldID,
                                              user <- userID,
                                              point <- newPoint))
            }
            // COMMIT TRANSACTION
        } catch {
            print("Cannot insert to FIELD_POINT VALUES (\(fieldID), \(userID), \(newPoint)")
        }
    }
    
    /// Insert a new user's article point.
    /// The point is initially set to 0.
    func insertArticlePoint(_ userID: Int, _ articleID: Int){
        /// Table `ARTICLE_POINT`
        let articlePoint = Table("ARTICLE_POINT")
        /// Column `FieldID`
        let article = Expression<Int>("ArticleID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        /// Column `Point`
        let point = Expression<Int>("Point")
        /// Point inserted
        let newPoint: Int = 0
        
        // Query table
        do {
            // BEGIN DEFERRED TRANSACTION
            try db!.transaction {
                // INSERT INTO ARTICLE_POINT (UserID, ArticleID, Point)
                // VALUES (`userID`, `articleID`, `point`)
                try db!.run(articlePoint.insert(article <- articleID,
                                                user <- userID,
                                                
                                                point <- newPoint))
            }
            // COMMIT TRANSACTION
        } catch {
            print("Cannot insert to ARTICLE_POINT")
        }
    }
    
    /// Insert a new article to the save list
    func insertSaveArticle(_ userID: Int, _ articleID: Int) {
        /// Table `SAVE_ARTICLES`
        let saveArticles = Table("SAVE_ARTICLES")
        /// Column `ArticleID`
        let article = Expression<Int>("ArticleID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        
        /// INSERT INTO SAVE_ARTICLES (UserID, ArticleID) VALUES (`userID`, `articleID`)
        let insert = saveArticles.insert(user <- userID, article <- articleID)
        
        // START TRANSACTION
        do {
            try db!.run(insert)
        } catch {
            print("Cannot insert \(userID) and \(articleID) into SAVE_ARTICLES")
        }
        // END TRANSACTION
    }
    
    /// Insert a new article to the save list
    func insertSaveArticle(_ userID: String, _ articleID: String) {
        /// Article's id in Integer
        guard let article = Int(articleID) else {
            print("Cannot convert string \(articleID) to Integer")
            return
        }
        /// User's id in Integer
        guard let user = Int(userID) else {
            print("Cannot convert string \(userID) to Integer")
            return
        }
        
        // Pass values to the helper method
        insertSaveArticle(user, article)
    }
    
}

/// Class for deleting from the database.
class DeleteFromDB: SQLiteDB {
    /// Delete an existing article in the save list
    func deleteSaveArticle(_ userID: String, _ articleID: String) {
        /// Article's id in Integer
        guard let article = Int(articleID) else {
            print("Cannot convert string \(articleID) to Integer")
            return
        }
        /// User's id in Integer
        guard let user = Int(userID) else {
            print("Cannot convert string \(userID) to Integer")
            return
        }
        
        // Pass values to the helper method
        deleteSaveArticle(user, article)
    }
    
    /// Insert a new article to the save list
    func deleteSaveArticle(_ userID: Int, _ articleID: Int) {
        /// Table `SAVE_ARTICLES`
        let saveArticles = Table("SAVE_ARTICLES")
        /// Column `ArticleID`
        let article = Expression<Int>("ArticleID")
        /// Column `UserID`
        let user = Expression<Int>("UserID")
        
        /// SELECT * FROM SAVE_ARTICLE
        /// WHERE UserID == `userID` AND ArticleID ==`articleID`
        let row = saveArticles.filter(article == articleID && user == userID)
        
        /// Delete FROM TABLE SAVE_ARTICLES
        /// WHERE UserID == `userID` AND ArticleID ==`articleID`
        let delete = row.delete()
        
        // START TRANSACTION
        do {
            guard try db!.run(delete) > 0 else {
                print("Not found row in SAVE_ARTICLES with user \(userID) and article \(articleID)")
                return
            }
        } catch {
            print("Delete from SAVE_ARTICLES failed")
        }
        // END TRANSACTION
    }
}
