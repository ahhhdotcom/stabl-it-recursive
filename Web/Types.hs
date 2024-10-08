module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)


data PostsController
    = PostsAction
    | NewPostAction {parentId :: Maybe Text }
    | ShowPostAction { postId :: !(Id Post) }
    | CreatePostAction 
    | LikePost {postId :: !(Id Post)}
    | DislikePost {postId :: !(Id Post)}
    | EditPostAction { postId :: !(Id Post) }
    | UpdatePostAction { postId :: !(Id Post) }
    | DeletePostAction { postId :: !(Id Post) }
    | QueryLikeCount { postId :: !(Id Post) } 
    deriving (Eq, Show, Data)


data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)



instance HasNewSessionUrl User where
    newSessionUrl _ = ""

type instance CurrentUserRecord = User

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)



data UserReactionsController
    = UserReactionsAction
    | NewUserReactionAction
    | ShowUserReactionAction { userReactionId :: !(Id UserReaction) }
    | CreateUserReactionAction { userId :: !(Id User), postId :: !(Id Post) }
    | EditUserReactionAction { userReactionId :: !(Id UserReaction) }
    | UpdateUserReactionAction { userReactionId :: !(Id UserReaction) }
    | DeleteUserReactionAction { userReactionId :: !(Id UserReaction) }
    deriving (Eq, Show, Data)
