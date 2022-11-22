import Foundation
import RealmSwift

class DoItem: Object{
    @objc dynamic var doID: String = ""
    @objc dynamic var dayCycle: String = ""
    @objc dynamic var doTitle: String = ""
    @objc dynamic var doSubTitle: String = ""
    @objc dynamic var isDo: Bool = false
    @objc dynamic var createdTime: Date = Date.now
    @objc dynamic var refreshTime: Date = Date.now
    @objc dynamic var doCount: Int = 0
    
    convenience init(doTitle: String, doSubTitle: String, dayCycle: String)
    {
        self.init()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        self.doTitle = doTitle
        self.doSubTitle = doSubTitle
        self.dayCycle = dayCycle
        self.doID = "id.\(dateFormatter.string(from: createdTime))"
    }
}

struct ViewDoItem{
    var doItem: DoItem
    
    private var _dayCycle: String?
    private var _doTitle: String?
    private var _doSubTitle: String?
    private var _isDo: Bool?
    
    var doID: String? {
        return doItem.doID
    }
    var dayCycle: String? {
        get{
            return _dayCycle
        }
        set{
            _dayCycle = newValue
        }
    }
    var doTitle: String? {
        get{
            return _doTitle
        }
        set{
            _doTitle = newValue
        }
    }
    var doSubTitle: String? {
        get{
            return _doSubTitle
        }
        set{
            _doSubTitle = newValue
        }
    }
    var isDo: Bool? {
        get{
            return _isDo
        }
        set{
            _isDo = newValue
        }
    }
    var createdTime: Date?{
        return doItem.createdTime
    }
    var refreshTime: Date?{
        return doItem.refreshTime
    }
    var doCount: Int?{
        return doItem.doCount
    }
    init(doItem: DoItem){
        self.doItem = doItem
        self.dayCycle = doItem.dayCycle
        self.doTitle = doItem.doTitle
        self.doSubTitle = doItem.doSubTitle
        self.isDo = doItem.isDo
    }
    init(){
        self.doItem = DoItem(doTitle: "", doSubTitle: "", dayCycle: "")
    }
}
