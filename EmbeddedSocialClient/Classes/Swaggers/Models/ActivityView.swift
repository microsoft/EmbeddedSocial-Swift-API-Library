//
// ActivityView.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Activity view */
open class ActivityView: JSONEncodable {
    public enum ActivityType: String { 
        case like = "Like"
        case comment = "Comment"
        case reply = "Reply"
        case commentPeer = "CommentPeer"
        case replyPeer = "ReplyPeer"
        case following = "Following"
        case followRequest = "FollowRequest"
        case followAccept = "FollowAccept"
    }
    /** Gets or sets activity handle */
    public var activityHandle: String?
    /** Gets or sets created time */
    public var createdTime: Date?
    /** Gets or sets activity type */
    public var activityType: ActivityType?
    /** Gets or sets actor users */
    public var actorUsers: [UserCompactView]?
    /** Gets or sets acted on user */
    public var actedOnUser: UserCompactView?
    /** Gets or sets acted on content */
    public var actedOnContent: ContentCompactView?
    /** Gets or sets total actions */
    public var totalActions: Int32?
    /** Gets or sets a value indicating whether the activity was read */
    public var unread: Bool?
    /** Gets or sets the containing app */
    public var app: AppCompactView?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["activityHandle"] = self.activityHandle
        nillableDictionary["createdTime"] = self.createdTime?.encodeToJSON()
        nillableDictionary["activityType"] = self.activityType?.rawValue
        nillableDictionary["actorUsers"] = self.actorUsers?.encodeToJSON()
        nillableDictionary["actedOnUser"] = self.actedOnUser?.encodeToJSON()
        nillableDictionary["actedOnContent"] = self.actedOnContent?.encodeToJSON()
        nillableDictionary["totalActions"] = self.totalActions?.encodeToJSON()
        nillableDictionary["unread"] = self.unread
        nillableDictionary["app"] = self.app?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}