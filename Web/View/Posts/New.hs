module Web.View.Posts.New where
import Web.View.Prelude
import Application.Script.Prelude (render)

data NewView = NewView { post :: Post, parentId :: Maybe Text }


instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Post</h1>
        {renderForm post}

    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Posts" PostsAction
                , breadcrumbText "New Post"
                ]


renderForm :: Post -> Html
renderForm post = 
        formFor post [hsx|
        {(textField #title)}
        {(hiddenField #author)}
        {(textField #body)}
        {(hiddenField #likes)}
        {(hiddenField #parentId)}
        {submitButton}

    |]