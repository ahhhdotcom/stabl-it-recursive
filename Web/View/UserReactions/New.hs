module Web.View.UserReactions.New where
import Web.View.Prelude

data NewView = NewView { userReaction :: UserReaction }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New UserReaction</h1>
        {renderForm userReaction}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "UserReactions" UserReactionsAction
                , breadcrumbText "New UserReaction"
                ]

renderForm :: UserReaction -> Html
renderForm userReaction = formFor userReaction [hsx|
    {(textField #postId)}
    {(textField #userId)}
    {submitButton}

|]