defmodule ForumWeb.CommentControllerTest do
  use ForumWeb.ConnCase

  alias Forum.Post

  @create_attrs %{name: "some name", reply: "some reply"}
  @update_attrs %{name: "some updated name", reply: "some updated reply"}
  @invalid_attrs %{name: nil, reply: nil}

  def fixture(:thread) do
    {:ok, thread} = Post.create_thread(%{name: "John Doe", title: "How do I get this to work?", body: "Please help"})
    thread
  end

  def fixture(:comment) do
    thread = fixture(:thread)
    params = Map.put(@create_attrs, :thread_id, thread.id)
    {:ok, comment} = Post.create_comment(params)
    comment
  end

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, Routes.comment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Comments"
    end
  end

  describe "new comment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.comment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "create comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      thread = fixture(:thread)
      params = Map.put(@create_attrs, :thread_id, thread.id)
      conn = post(conn, Routes.comment_path(conn, :create), comment: params)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.comment_path(conn, :show, id)

      conn = get(conn, Routes.comment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Comment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.comment_path(conn, :create), comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "edit comment" do
    setup [:create_comment]

    test "renders form for editing chosen comment", %{conn: conn, comment: comment} do
      conn = get(conn, Routes.comment_path(conn, :edit, comment))
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "redirects when data is valid", %{conn: conn, comment: comment} do
      thread = fixture(:thread)
      params = Map.put(@update_attrs, :thread_id, thread.id)
      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: params)
      assert redirected_to(conn) == Routes.comment_path(conn, :show, comment)

      conn = get(conn, Routes.comment_path(conn, :show, comment))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, Routes.comment_path(conn, :delete, comment))
      assert redirected_to(conn) == Routes.comment_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.comment_path(conn, :show, comment))
      end
    end
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    %{comment: comment}
  end
end
