import TxUIComponent

extension TxAccessibility {
    public enum GithubProfiles {}
}

extension TxAccessibility.GithubProfiles {
    public enum FlowItem {
        public static let icon = "GithubProfile.FlowItem.Icon"
        public static let followLabel = "GithubProfile.FlowItem.FollowLabel"
        public static let followValue = "GithubProfile.FlowItem.FollowValue"
    }
    
    public enum UserItem {
        public static let avatar = "GithubProfile.UserItem.Avatar"
        public static let name = "GithubProfile.UserItem.Name"
        public static let landingPageUrl = "GithubProfile.UserItem.LandingPageUrl"
        public static let location = "GithubProfile.UserItem.Location"
    }
    
    public enum UserList {
        public static let title = "GithubProfile.UserList.Navigation.Title"
        public static let backButton = "GithubProfile.UserList.Navigation.BackButton"
        public static let shimmer = "GithubProfile.UserList.Content.Shimmer"
        public static let loadMore = "GithubProfile.UserList.Content.LoadMore"
        public static let list = "GithubProfile.UserList.Content.List"
        public static let empty = "GithubProfile.UserList.Content.Empty"
        public static let userCell = "GithubProfile.UserList.Content.UserCell"
    }

    public enum UserDetail {
        public static let title = "GithubProfile.UserDetail.Navigation.Title"
        public static let backButton = "GithubProfile.UserDetail.Navigation.BackButton"
        public static let userCell = "GithubProfile.UserDetail.Content.UserCell"
        public static let followCell = "GithubProfile.UserDetail.Content.FollowCell"
        public static let blogCell = "GithubProfile.UserDetail.Content.BlogCell"
        public static let follower = "GithubProfile.UserDetail.Content.follower"
        public static let following = "GithubProfile.UserDetail.Content.following"
        public static let blogTitle = "GithubProfile.UserDetail.Content.BlogTitle"
        public static let BlogLink = "GithubProfile.UserDetail.Content.BlogLink"
    }
}
