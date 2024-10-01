module Web.View.UserReactions.Edit where
import Web.View.Prelude

data EditView = EditView { userReaction :: UserReaction }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit UserReaction</h1>
        {renderForm userReaction}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "UserReactions" UserReactionsAction
                , breadcrumbText "Edit UserReaction"
                ]

renderForm :: UserReaction -> Html
renderForm userReaction = formFor userReaction [hsx|
    {(textField #postId)}
    {(textField #userId)}
    {submitButton}

|]