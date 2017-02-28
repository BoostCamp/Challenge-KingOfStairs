//
//  DataController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 21..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

class DataController: NSObject {
    
    var goalKcl:Double?
    var todayKcl:Double?
    
    var userData = [
        User(name: "링고스타", userImage: UIImage(named: "Ling")!, kclPoint: 2800, userComment: "코더스 하이 만세", place: "메리츠타워"),
        User(name: "최은주", userImage: UIImage(named: "Pak")!, kclPoint: 4795, userComment: "오늘 하루 힘드네요.", place: "메리츠타워"),
        User(name: "김효수", userImage: UIImage(named: "Kim")!, kclPoint: 54, userComment: "마지막까지 화이팅!", place: "메리츠타워"),
        User(name: "김태선", userImage: UIImage(named: "Park")!, kclPoint: 1304, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "메리츠타워"),
        User(name: "이효종", userImage: UIImage(named: "Lee")!, kclPoint: 479, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교"),
        User(name: "김호선", userImage: UIImage(named: "Choi")!, kclPoint: 3612, userComment: "오늘도 화이팅팅", place: "판교"),
        User(name: "이현승", userImage: UIImage(named: "Park")!, kclPoint: 4795, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "우림라이온스"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교넥스트"),
        User(name: "오닥우", userImage: UIImage(named: "Choi")!, kclPoint: 3612, userComment: "오늘도 화이팅팅", place: "판교넥스트"),
        User(name: "김호선", userImage: UIImage(named: "Choi")!, kclPoint: 123, userComment: "오늘도 화이팅팅", place: "우림라이온스"),
        User(name: "이현승", userImage: UIImage(named: "Park")!, kclPoint: 532, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "test"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "test"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "삼성"),
        User(name: "User1", userImage: UIImage(named: "Choi")!, kclPoint: 1234, userComment: "1", place: "아이디어팩토리"),
        User(name: "User2", userImage: UIImage(named: "Choi")!, kclPoint: 12, userComment: "2", place: "아이디어팩토리"),
        User(name: "User3", userImage: UIImage(named: "Choi")!, kclPoint: 32, userComment: "3", place: "아이디어팩토리"),
        User(name: "User4", userImage: UIImage(named: "Choi")!, kclPoint: 12, userComment: "4", place: "아이디어팩토리"),
        User(name: "링고스타", userImage: UIImage(named: "Ling")!, kclPoint: 2800, userComment: "코더스 하이 만세", place: "판교넥스트"),
        User(name: "최은주", userImage: UIImage(named: "Pak")!, kclPoint: 4795, userComment: "오늘 하루 힘드네요.", place: "판교넥스트"),
        User(name: "김효수", userImage: UIImage(named: "Kim")!, kclPoint: 54, userComment: "마지막까지 화이팅!", place: "판교넥스트"),
        User(name: "김태선", userImage: UIImage(named: "Park")!, kclPoint: 1304, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "판교넥스트"),
        User(name: "이효종", userImage: UIImage(named: "Lee")!, kclPoint: 479, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교넥스트"),
        User(name: "김호선", userImage: UIImage(named: "Choi")!, kclPoint: 3612, userComment: "오늘도 화이팅팅", place: "판교넥스트"),
        User(name: "이현승", userImage: UIImage(named: "Park")!, kclPoint: 4795, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "판교넥스트"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교넥스트"),
        User(name: "오닥우", userImage: UIImage(named: "Choi")!, kclPoint: 3612, userComment: "오늘도 화이팅팅", place: "판교넥스트"),
        User(name: "김호선", userImage: UIImage(named: "Choi")!, kclPoint: 123, userComment: "오늘도 화이팅팅", place: "판교넥스트"),
        User(name: "이현승", userImage: UIImage(named: "Park")!, kclPoint: 532, userComment: "오늘 하루는 어떠셨나요? 다들 퇴근까지 화이팅이에요", place: "판교넥스트"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교넥스트"),
        User(name: "오나미", userImage: UIImage(named: "Lee")!, kclPoint: 4321, userComment: "조금만 더하면 초롱님 따라 잡을 수 있을 듯! 후래아아입", place: "판교넥스트"),
        User(name: "User1", userImage: UIImage(named: "Choi")!, kclPoint: 1234, userComment: "1", place: "판교넥스트"),
        User(name: "User2", userImage: UIImage(named: "Choi")!, kclPoint: 12, userComment: "2", place: "판교넥스트"),
        User(name: "User3", userImage: UIImage(named: "Choi")!, kclPoint: 32, userComment: "3", place: "판교넥스트"),
        User(name: "User4", userImage: UIImage(named: "Choi")!, kclPoint: 12, userComment: "4", place: "판교넥스트"),
    ]
    
    var selectedPlace = ""
    var currentData = 0
    
    func makeCurrentUser() -> User {
        let currentUser = User(name: "User", userImage: UIImage(named: "MyInfo")!, kclPoint: 0, userComment: "안녕하세요", place: selectedPlace)
        return currentUser
    }
    
    func filterByBuilding(data: [User], selectedPlace location: String) -> [User] {
        
        let filteredData = data.filter{ $0.place == location }
        
        func ascendantData() -> [User] {
            
            let sortedData = filteredData.sorted(by: { $0.kclPoint! > $1.kclPoint! })
            
            return sortedData
        }
        return ascendantData()
    }
    var currentUserImage = UIImage(named: "LIng")
    
    func getBuildingName() -> String {
        var userBuilding = ""
        if let registeredBuilding = userData[0].place {
            userBuilding = registeredBuilding
        }
        return userBuilding
    }
    
    var excerciseData:[String:[Kcl]] = [
        "2월 1일" : [
            Kcl(floors: 8, time: "7:30"),
            Kcl(floors: 2, time: "12:30"),
            Kcl(floors: 3, time: "13:32"),
            Kcl(floors: 4, time: "14:12"),
            Kcl(floors: 5, time: "15:55"),
            Kcl(floors: 6, time: "17:12")
        ],
        "2월 2일" : [
            Kcl(floors: 10, time: "19:12"),
            Kcl(floors: 21, time: "20:18"),
            Kcl(floors: 3, time: "21:20"),
            Kcl(floors: 12, time: "22:12"),
            Kcl(floors: 483, time: "22:11")
        ],
        "2월 3일" : [
            Kcl(floors: 12, time: "19:12"),
            Kcl(floors: 22, time: "20:18"),
            Kcl(floors: 3, time: "21:20"),
            Kcl(floors: 12, time: "22:12")
        ],
        "2월 4일" : [
            Kcl(floors: 11, time: "19:12"),
            Kcl(floors: 21, time: "20:18"),
            Kcl(floors: 24, time: "21:20"),
            Kcl(floors: 12, time: "22:12")
        ],
    ]
    
    func getTodayDate() -> String{
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        var currentYear = ""
        var currentMonth = ""
        var currentDay = ""
        
        if let year = components.year {
            currentYear = String(year)
        }
        if let month = components.month {
            currentMonth = String(month)
        }
        if let day = components.day {
            currentDay = String(day)
        }
        
        return "\(currentMonth)월 \(currentDay)일"
    }
    
    func monthlySum() -> String {
        var monthlyKcl = 0
        for i in 0..<excerciseData.count {
            let categories = Array(excerciseData.values)[i]
            for item in 0..<categories.count {
                monthlyKcl += categories[item].floors
            }
        }
        return String(monthlyKcl)
    }
    
    func todaySum() -> Double {
        var todayKcl = 0
        if let todayData = excerciseData[DataController.sharedInstance().getTodayDate()] {
            for i in 0..<todayData.count {
                todayKcl += todayData[i].floors
            }
        }
        return Double(todayKcl)
    }
    
    func kclCalculator() -> Double {
        var data = 0.00
        if let currentkcl = goalKcl {
            data = currentkcl - (todaySum() * 7) - Double(currentData * 7)
        }
        
        return data
    }
    
    var locations = [
        "메리츠타워":["longitude": 127.028526 ,"latitude": 37.497000, "radius": 50.00, "identifier": "메리츠타워"],
        "삼성":["longitude": 127.026927 ,"latitude": 37.496762, "radius": 50.00, "identifier": "삼성"],
        "test":["longitude": 127.029107 ,"latitude": 37.497760, "radius": 20.00, "identifier": "test"],
        "우림라이온스":["longitude": 126.882788 ,"latitude": 37.496762, "radius": 50.00, "identifier": "우림라이온스"],
        "판교":["longitude": 127.099662 ,"latitude": 37.395428, "radius": 50.00, "identifier": "판교"],
        "판교넥스트":["longitude": 127.108589 ,"latitude": 37.401958, "radius": 50.00, "identifier": "판교넥스트"],
        "아이디어팩토리":["longitude": 127.029412 ,"latitude": 37.497111, "radius": 50.00, "identifier": "아이디어팩토리"]
    ]
    
    lazy var badgeStore: [Badge] = {
        return [
            Badge(name: "Badge_Star10", caption: "10개의 층계를 오른 사람에게 주어지는 영광스러운 뱃지 입니다.", hint: "Hint: 계단왕을 처음 시작하는 당신 10층부터 올라볼까요?", activation: true),
            Badge(name: "Badge_Star20", caption: "20개의 층계를 오른 사람에게 주어지는 영광스러운 뱃지 입니다.", hint: "Hint: 계단왕을 처음 시작하는 당신 20층부터 올라볼까요?", activation: true),
            Badge(name: "Badge_Star30", caption: "30개의 층계를 오른 사람에게 주어지는 영광스러운 뱃지 입니다.", hint: "Hint: 계단왕을 처음 시작하는 당신 30층부터 올라볼까요?", activation: false),
            Badge(name: "Badge_Star50", caption: "50개의 층계를 오른 사람에게 주어지는 영광스러운 뱃지 입니다.", hint: "Hint: 계단왕을 처음 시작하는 당신 50층부터 올라볼까요?", activation: false),
            Badge(name: "Puma", caption: "10개의 층계를 3분안에 오른 사람에게 주는 뱃지입니다.", hint: "Hint: 퓨마는 가장 빠른 육상동물이죠!", activation: false),
            Badge(name: "Potato", caption: "옆구리에 새로운 친구들이 늘어난 것 같은데요?", hint: "Hint: 당신은 Couch Potato!", activation: false)
        ]
    }()
    
    struct StaticsInstace {
        static var instance: DataController?
    }
    
    class func sharedInstance() -> DataController {
        if !(StaticsInstace.instance != nil) {
            StaticsInstace.instance = DataController()
        }
        return StaticsInstace.instance!
    }
}
