import TxUIComponent

/// Extension providing accessibility identifiers for the GitHub Profiles module.
///
/// This extension adds accessibility support to the module by defining
/// unique identifiers for UI elements, making the app more accessible
/// to users with disabilities.
extension TxAccessibility {
    /// Namespace for GitHub Profiles accessibility identifiers.
    public enum GithubProfiles {}
}

extension TxAccessibility.GithubProfiles {
    /// Accessibility identifiers for follower/following count items.
    public enum FlowItem {
        /// Identifier for the icon in follower/following items.
        public static let icon = "GithubProfile.FlowItem.Icon"
        /// Identifier for the label text in follower/following items.
        public static let followLabel = "GithubProfile.FlowItem.FollowLabel"
        /// Identifier for the count value in follower/following items.
        public static let followValue = "GithubProfile.FlowItem.FollowValue"
    }

    /// Accessibility identifiers for user item elements.
    public enum UserItem {
        /// Identifier for the user's avatar image.
        public static let avatar = "GithubProfile.UserItem.Avatar"
        /// Identifier for the user's name.
        public static let name = "GithubProfile.UserItem.Name"
        /// Identifier for the user's landing page URL.
        public static let landingPageUrl = "GithubProfile.UserItem.LandingPageUrl"
        /// Identifier for the user's location.
        public static let location = "GithubProfile.UserItem.Location"
    }

    /// Accessibility identifiers for the user list screen.
    public enum UserList {
        /// Identifier for the navigation title.
        public static let title = "GithubProfile.UserList.Navigation.Title"
        /// Identifier for the back button.
        public static let backButton = "GithubProfile.UserList.Navigation.BackButton"
        /// Identifier for the shimmer loading effect.
        public static let shimmer = "GithubProfile.UserList.Content.Shimmer"
        /// Identifier for the load more indicator.
        public static let loadMore = "GithubProfile.UserList.Content.LoadMore"
        /// Identifier for the user list container.
        public static let list = "GithubProfile.UserList.Content.List"
        /// Identifier for the empty state view.
        public static let empty = "GithubProfile.UserList.Content.Empty"
        /// Identifier for individual user cells.
        public static let userCell = "GithubProfile.UserList.Content.UserCell"
    }

    /// Accessibility identifiers for the user detail screen.
    public enum UserDetail {
        /// Identifier for the navigation title.
        public static let title = "GithubProfile.UserDetail.Navigation.Title"
        /// Identifier for the back button.
        public static let backButton = "GithubProfile.UserDetail.Navigation.BackButton"
        /// Identifier for the user information cell.
        public static let userCell = "GithubProfile.UserDetail.Content.UserCell"
        /// Identifier for the follower/following count cell.
        public static let followCell = "GithubProfile.UserDetail.Content.FollowCell"
        /// Identifier for the blog information cell.
        public static let blogCell = "GithubProfile.UserDetail.Content.BlogCell"
        /// Identifier for the followers count.
        public static let follower = "GithubProfile.UserDetail.Content.follower"
        /// Identifier for the following count.
        public static let following = "GithubProfile.UserDetail.Content.following"
        /// Identifier for the blog title.
        public static let blogTitle = "GithubProfile.UserDetail.Content.BlogTitle"
        /// Identifier for the blog link.
        public static let BlogLink = "GithubProfile.UserDetail.Content.BlogLink"
    }
}
