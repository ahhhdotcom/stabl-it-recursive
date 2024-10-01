module Web.View.UserReactions.Show where
import Web.View.Prelude

data ShowView = ShowView { userReaction :: UserReaction }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show UserReaction</h1>
        <p>{userReaction}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "UserReactions" UserReactionsAction
                            , breadcrumbText "Show UserReaction"
                            ]