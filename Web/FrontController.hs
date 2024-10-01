module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.UserReactions
import Web.Controller.UserReactions
import Web.Controller.UserReactions
import Web.Controller.UserReactions
import Web.Controller.Users
import Web.Controller.Posts
import Web.Controller.Posts
import Web.Controller.Static

import IHP.LoginSupport.Middleware
import Web.Controller.Sessions


instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @UserReactionsController
        , parseRoute @UserReactionsController
        , parseRoute @UserReactionsController
        , parseRoute @UserReactionsController
        , parseRoute @UsersController
        , parseRoute @PostsController
        , parseRoute @SessionsController

        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User
