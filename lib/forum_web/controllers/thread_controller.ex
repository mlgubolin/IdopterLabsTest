defmodule ForumWeb.ThreadController do
  use ForumWeb, :controller

  alias Forum.Post
  alias Forum.Post.Thread

  def index(conn, _params) do
    threads = Post.list_threads()
    render(conn, "index.html", threads: threads)
  end

  def new(conn, _params) do
    changeset = Post.change_thread(%Thread{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"thread" => thread_params}) do
    case Post.create_thread(thread_params) do
      {:ok, thread} ->
        conn
        |> put_flash(:info, "Thread created successfully.")
        |> redirect(to: Routes.thread_path(conn, :show, thread))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    thread =
      id
      |> Post.get_thread!()
      |> Forum.Repo.preload(:replies)

    changeset = %Ecto.Changeset{}
    render(conn, "show.html", thread: thread, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    thread = Post.get_thread!(id)
    changeset = Post.change_thread(thread)
    render(conn, "edit.html", thread: thread, changeset: changeset)
  end

  def update(conn, %{"id" => id, "thread" => thread_params}) do
    thread = Post.get_thread!(id)

    case Post.update_thread(thread, thread_params) do
      {:ok, thread} ->
        conn
        |> put_flash(:info, "Thread updated successfully.")
        |> redirect(to: Routes.thread_path(conn, :show, thread))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", thread: thread, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    thread = Post.get_thread!(id)
    {:ok, _thread} = Post.delete_thread(thread)

    conn
    |> put_flash(:info, "Thread deleted successfully.")
    |> redirect(to: Routes.thread_path(conn, :index))
  end
end
