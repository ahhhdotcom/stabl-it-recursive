module Web.View.Posts.Index where
import Web.View.Prelude

data IndexView = IndexView { posts :: [Post] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        

        <h1>Index<a href={ NewPostAction Nothing } class="btn btn-primary ms-4">+ New</a></h1>

                <a class="js-delete js-delete-no-confirm" href={DeleteSessionAction}>Logout</a>



        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Post</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach posts renderPost}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Posts" PostsAction
                ]
            
        

renderPost :: Post -> Html
renderPost post = [hsx|
    <tr>
        <td>{post.title}</td>
        <td><a href={ShowPostAction post.id}>Show</a></td>
        <td><a href={EditPostAction post.id} class="text-muted">Edit</a></td>
        <td><a href={DeletePostAction post.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]