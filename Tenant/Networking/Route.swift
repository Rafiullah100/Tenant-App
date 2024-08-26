//
//  Route.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/04/2021.
//

import Foundation

enum Route {
    static let baseUrl = "https://rabt-admin.nextgcircle.com/"
    
    case signup
    case login
    case forgot
    case otp
    case addComplaint
    case getComplaints
    case getComplaintDetail
    case contactList
    case skillCategories
    case addBranch
    case getCompanyComplaints
    case getCompanyProfile
    case addWorker
    case getWorker
    case tenantConfirmation
    case reject
    case assign
    case ownerComplaints
    case ownerProfile
    case ownerApproval
    case properties
    case addProperty

    case logout
    case googleSignup
    case categories
    case languages
    case latestNews
    case authorsList
    case opinionList
    case trendingOpinion
    case trendingNews
    case getProfile
    case updateProfile
    case doArchive
    case archiveNews
    case updatePassword
    case doFollow
    case userCategories
    case countries
    case sources
    case slider
    case opinions
    case newsFollowing
    case doFollowSource
    case followedAuthors
    case doFollowAuthor
    case suggestedAuthors
    case search
    case deepLinkingNews
    case deepLinkingOpinion
    case nature
    case hot
    case feedback
    case appleSignup
    case deleteAccount
    case viewCounter
    case resendOtp
    case newsDetail
    case opinionDetail
    
    var description: String {
        switch self {
        case .signup:
            return "api/mobile/auth/register"
        case .login:
            return "api/mobile/auth/login"
        case .forgot:
            return "api/mobile/auth/forget-password"
        case .otp:
            return "api/mobile/auth/verify_login"
        case .addComplaint:
            return "api/mobile/complaints/add_new"
        case .logout:
            return "api/mobile/auth/logout"
        case .googleSignup:
            return "api/mobile/auth/google-login"
        case .categories:
            return "api/mobile/categories"
        case .languages:
            return "api/mobile/menu/language/list"
        case .latestNews:
            return "api/mobile/news"
        case .authorsList:
            return "api/mobile/authors?"
        case .opinionList:
            return "api/mobile/opinions?"
        case .trendingNews:
            return "api/mobile/news/trending"
        case .trendingOpinion:
            return "api/mobile/opinions/trending"
        case .getProfile:
            return "api/mobile/users/profile"
        case .updateProfile:
            return "api/mobile/users/update-profile"
        case .doArchive:
            return "api/mobile/archive/add-remove"
        case .archiveNews:
            return "api/mobile/archive"
        case .updatePassword:
            return "api/mobile/users/update-password"
        case .doFollow:
            return "api/mobile/users/follow-categories"
        case .userCategories:
            return "api/mobile/users/user-categories"
        case .countries:
            return "api/mobile/country"
        case .sources:
            return "api/mobile/menu/source/list"
        case .slider:
             return "api/mobile/home/slider"
        case .opinions:
            return "api/mobile/users/get-authors-with-flag"
        case .newsFollowing:
            return "api/mobile/customizations/get-sources"
        case .doFollowSource:
            return "api/mobile/customizations/add-source"
        case .followedAuthors:
            return "api/mobile/users/get-user-authors"
        case .doFollowAuthor:
            return "api/mobile/users/follow-authors"
        case .suggestedAuthors:
            return "api/mobile/users/get-authors-with-flag"
        case .search:
            return "api/mobile/search"
        case .deepLinkingNews:
            return "api/mobile/news/detail"
        case .nature:
            return "api/mobile/home/nature"
        case .hot:
            return "api/mobile/home/do-hot"
        case .feedback:
            return "api/mobile/home/add-feedback"
        case .appleSignup:
            return "api/mobile/auth/apple-login"
        case .deleteAccount:
            return "api/mobile/users/delete-profile"
        case .viewCounter:
            return "api/mobile/home/view-counter"
        case .resendOtp:
            return "api/mobile/auth/resend-otp"
        case .deepLinkingOpinion:
            return "api/mobile/opinions/detail"
        case .newsDetail:
            return "api/mobile/news/detail"
        case .opinionDetail:
            return "api/mobile/opinions/detail"
        case .getComplaints:
            return "api/mobile/complaints/get_tenant_complaints"
        case .getComplaintDetail:
            return "api/mobile/complaints/get_complaint_detail"
        case .contactList:
            return "api/mobile/complaints/get_complaint_contacts"
        case .skillCategories:
            return "api/mobile/skills/get_all"
        case .addBranch:
            return "api/mobile/company/add_branch"
        case .getCompanyComplaints:
            return "api/mobile/complaints/get_company_complaints"
        case .getCompanyProfile:
            return "api/mobile/company/get_profile"
        case .addWorker:
            return "api/mobile/company/add_worker"
        case .getWorker:
            return "api/mobile/company/get_workers"
        case .tenantConfirmation:
            return "api/mobile/tenant/complaint_completion_confirmation"
        case .reject:
            return "api/mobile/company/reject_complaint"
        case .assign:
            return "api/mobile/company/assign_worker"
            
        case .ownerComplaints:
            return "api/mobile/complaints/get_owner_complaints"
        case .ownerProfile:
                return "api/mobile/owner/get_profile"
        case .ownerApproval:
            return "api/mobile/owner/confirmation"
        case .properties:
            return "api/mobile/owner/get_properties"
        case .addProperty:
            return "api/mobile/owner/add_property"
        }
    }
}
