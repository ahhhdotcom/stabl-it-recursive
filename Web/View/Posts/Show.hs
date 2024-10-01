module Web.View.Posts.Show where
import Web.View.Prelude
import Web.View.Posts.New
import Text.Blaze.Html5.Attributes (placeholder)

data ShowView = ShowView { post :: Post, comments :: [Post] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{post.title}</h1>
        <p>{post.author}</p> <br>
        <p>{post.body}</p>
        <p>{post.likes}</p>
        <a href={NewPostAction (Just (post.id |> show)) }>Comment</a> <br>

            <form method="POST" action={LikePost post.id}>
                <button type="submit" >
                    Upvote
                </button>
            </form>

            <form method="POST" action={DislikePost post.id }>
                <button type="submit" >
                    Downvote
                </button>
            </form>


    


    




    

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


