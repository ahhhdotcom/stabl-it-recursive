{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.Index
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show
import Text.XML.Cursor (parent)
import Data.UUID
import Web.Controller.UserReactions


touuid (Id uuid) = uuid


instance Controller PostsController where
    action PostsAction = do
        posts <- query @Post 
            |> filterWhereSql (#parentId, "IS NULL")
            |> fetch 

        render IndexView { .. }

    action NewPostAction { parentId } = do
        let post = 
                case parentId of
                    Just x -> ((case (fromText x) of
                                    Just y -> newRecord
                                                |> set #parentId (Just y)
                                                |> set #author (currentUser.email)
                                    Nothing ->  newRecord
                                                    |> set #author (currentUser.email)
                                ))
                    Nothing -> newRecord
                                    |> set #author (currentUser.email)
                
        render NewView { .. }

    action ShowPostAction { postId } = do
        post <- fetch postId
        comments <- query @Post 
            |> filterWhere (#parentId, Data.UUID.fromText (postId |> show))
            |> fetch 
        render ShowView { .. }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo EditPostAction { .. }

    action CreatePostAction = do
        let post = newRecord @Post
                    
        post
            |> buildPost
            |> ifValid \case
                Left post -> redirectTo PostsAction
                Right post -> do
                    post <- post |> createRecord
                    setSuccessMessage "Post created"
                    case post.parentId of
                        Just x -> redirectTo ShowPostAction { postId = Id x }
                        Nothing -> redirectTo PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction


    action LikePost { postId } = do
        userReaction <- query @UserReaction
            |> filterWhere (#userId, (currentUser.id))
            |> filterWhere (#postId, (postId)) 
            |> filterWhere (#reaction, 1)
            |> fetchOneOrNothing

        userReactionOpposite <- query @UserReaction
            |> filterWhere (#userId, (currentUser.id))
            |> filterWhere (#postId, (postId)) 
            |> filterWhere (#reaction, -1)
            |> fetchOneOrNothing

        


        updatePost <- fetch ( postId )
        case (userReaction) of
            Just x -> updatePost 
                            |> set #likes (updatePost.likes - 1)
                            |> updateRecord
            Nothing -> case (userReactionOpposite) of
                            Just y -> updatePost
                                        |> set #likes (updatePost.likes + 2)
                                        |> updateRecord
                            Nothing -> (updatePost
                                            |> set #likes (updatePost.likes + 1)
                                            |> updateRecord
                                        )



        case userReactionOpposite of 
            Just xx -> deleteRecord xx
            Nothing -> pure ()



        case userReaction of
            Just x -> (deleteRecord x)
            Nothing -> newRecord @UserReaction
                                |> set #postId (postId)
                                |> set #userId (currentUser.id)
                                |> set #reaction (1)
                                |> buildUserReaction
                                |> ifValid \case
                                    Left userReaction -> redirectTo ShowPostAction { postId }
                                    Right userReaction -> do
                                        userReaction <- userReaction |> createRecord
                                        redirectTo ShowPostAction { postId }
        

        redirectTo ShowPostAction { .. }    
 


    action DislikePost { postId } = do

        userReaction <- query @UserReaction
            |> filterWhere (#userId, (currentUser.id))
            |> filterWhere (#postId, (postId)) 
            |> filterWhere (#reaction, -1)
            |> fetchOneOrNothing

        userReactionOpposite <- query @UserReaction
            |> filterWhere (#userId, (currentUser.id))
            |> filterWhere (#postId, (postId)) 
            |> filterWhere (#reaction, 1)
            |> fetchOneOrNothing

        updatePost <- fetch ( postId )
        case (userReaction) of
            Just x -> updatePost 
                            |> set #likes (updatePost.likes + 1)
                            |> updateRecord
            Nothing -> case (userReactionOpposite) of
                            Just y -> updatePost
                                        |> set #likes (updatePost.likes - 2)
                                        |> updateRecord
                            Nothing -> updatePost
                                        |> set #likes (updatePost.likes - 1)
                                        |> updateRecord


        case userReactionOpposite of 
            Just x -> deleteRecord x
            Nothing -> pure ()

        case userReaction of
            Just x -> (deleteRecord x)
            Nothing -> newRecord @UserReaction
                                |> set #postId (postId)
                                |> set #userId (currentUser.id)
                                |> set #reaction (-1)
                                |> buildUserReaction
                                |> ifValid \case
                                    Left xx -> redirectTo ShowPostAction { postId }
                                    Right xx -> do
                                        xx <- xx |> createRecord
                                        redirectTo ShowPostAction {postId}
        



        redirectTo ShowPostAction { ..}        


buildPost post = post
    |> fill @'["title", "author", "likes", "parentId", "body"]
