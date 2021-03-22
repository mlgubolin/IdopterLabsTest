defmodule ForumWeb.CommentController do
  use ForumWeb, :controller

  alias Forum.Post
  alias Forum.Post.Comment

  def index(conn, %{"thread_id" => thread_id}) do
    comments = Post.list_comments()
    render(conn, "index.html", comments: comments, thread_id: thread_id)
  end

  def new(conn, %{"thread_id" => thread_id}) do
    changeset = Post.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset, thread_id: thread_id)
  end

  def create(conn, %{"comment" => comment_params, "thread_id" => thread_id}) do
    case Post.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.thread_path(conn, :show, thread_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, thread_id: thread_id)
    end
  end

  def show(conn, %{"id" => id,"thread_id" => thread_id }) do
    comment = Post.get_comment!(id)
    render(conn, "show.html", comment: comment, thread_id: thread_id)
  end

  def edit(conn, %{"id" => id,"thread_id" => thread_id }) do
    comment = Post.get_comment!(id)
    changeset = Post.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset, thread_id: thread_id)
  end

  def update(conn, %{"id" => id, "comment" => comment_params,"thread_id" => thread_id }) do
    comment = Post.get_comment!(id)

    case Post.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, thread_id, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset, thread_id: thread_id)
    end
  end

  def delete(conn, %{"id" => id,"thread_id" => thread_id}) do
    comment = Post.get_comment!(id)
    {:ok, _comment} = Post.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index, thread_id))
  end
end
