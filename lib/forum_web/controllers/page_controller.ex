defmodule ForumWeb.PageController do
  use ForumWeb, :controller
  alias Forum.Post

  def index(conn, _params) do
    threads = Post.list_threads()
    render(conn, "index.html", name: "Teste", threads: threads)
  end
end
