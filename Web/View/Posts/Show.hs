module Web.View.Posts.Show where
import Web.View.Prelude
import Web.View.Posts.New

data ShowView = ShowView { post :: Post, comments :: [Post] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{post.title}</h1>
        <p>{post.body}</p>
        <p>{post.likes}</p>
        <a href={NewPostAction (Just (post.id |> show))}>Comment</a> <br>

        <a href={LikePost post.id }>Upvote</a> <br>
        <a href={DislikePost post.id }>Downvote</a>


        <div>{forEach comments renderPost}</div>

    |]
        where
            breadcrumb = (case post.parentId of
                            Just x -> renderBreadcrumb
                                        (
                                            [ 
                                            breadcrumbLink "Posts" PostsAction
                                            , breadcrumbLink "Previous Post" (ShowPostAction (Id x) ) 
                                            , breadcrumbText "Comment"
                                            ]
                                        )

                            Nothing -> (renderBreadcrumb
                                        [ breadcrumbLink "Posts" PostsAction
                                        , breadcrumbText "Post"
                                        ])
                        )



renderPost :: Post -> Html
renderPost showPost = [hsx|
    <div style="border: solid black 1px; padding: 1%; margin: 1%; width: 50%;"> 
    <a href={ShowPostAction showPost.id}>{showPost.title}</a>
    <div>{showPost.body} </div>
    <div>{showPost.likes}</div>
    </div>


|]