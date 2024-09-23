module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)


data PostsController
    = PostsAction
    | NewPostAction {parentId :: Maybe Text}
    | ShowPostAction { postId :: !(Id Post) }
    | CreatePostAction 
    | LikePost {postId :: !(Id Post)}
    | DislikePost {postId :: !(Id Post)}
    | EditPostAction { postId :: !(Id Post) }
    | UpdatePostAction { postId :: !(Id Post) }
    | DeletePostAction { postId :: !(Id Post) }
    deriving (Eq, Show, Data)
