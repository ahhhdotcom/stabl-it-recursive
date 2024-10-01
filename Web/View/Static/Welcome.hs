module Web.View.Static.Welcome where
import Web.View.Prelude
import GHC.TypeLits (Log2)



data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
        <a href="/NewSession">Login</a>
                        <a class="js-delete js-delete-no-confirm" href={DeleteSessionAction}>Logout</a>

    |]