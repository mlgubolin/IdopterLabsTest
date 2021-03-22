defmodule Forum.PostTest do
  use Forum.DataCase

  alias Forum.Post

  describe "comments" do
    alias Forum.Post.Comment

    @valid_attrs %{name: "some name", reply: "some reply"}
    @update_attrs %{name: "some updated name", reply: "some updated reply"}
    @invalid_attrs %{name: nil, reply: nil}

    def thread_fixture_atom(:thread) do
      {:ok, thread} =
        Post.create_thread(%{
          name: "John Doe",
          title: "How do I get this to work?",
          body: "Please help"
        })

      thread
    end

    def comment_fixture(attrs \\ %{}) do
      thread = thread_fixture_atom(:thread)
      params = Map.put(@valid_attrs, :thread_id, thread.id)

      {:ok, comment} =
        attrs
        |> Enum.into(params)
        |> Post.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Post.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Post.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      thread = thread_fixture_atom(:thread)
      params = Map.put(@valid_attrs, :thread_id, thread.id)
      assert {:ok, %Comment{} = comment} = Post.create_comment(params)
      assert comment.name == "some name"
      assert comment.reply == "some reply"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Post.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Post.update_comment(comment, @update_attrs)
      assert comment.name == "some updated name"
      assert comment.reply == "some updated reply"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Post.update_comment(comment, @invalid_attrs)
      assert comment == Post.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Post.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Post.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Post.change_comment(comment)
    end
  end

  describe "threads" do
    alias Forum.Post.Thread

    @valid_attrs %{body: "some body", name: "some name", title: "some title"}
    @update_attrs %{
      body: "some updated body",
      name: "some updated name",
      title: "some updated title"
    }
    @invalid_attrs %{body: nil, name: nil, title: nil}

    def thread_fixture(attrs \\ %{}) do
      {:ok, thread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Post.create_thread()

      thread
    end

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Post.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Post.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      assert {:ok, %Thread{} = thread} = Post.create_thread(@valid_attrs)
      assert thread.body == "some body"
      assert thread.name == "some name"
      assert thread.title == "some title"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Post.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{} = thread} = Post.update_thread(thread, @update_attrs)
      assert thread.body == "some updated body"
      assert thread.name == "some updated name"
      assert thread.title == "some updated title"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Post.update_thread(thread, @invalid_attrs)
      assert thread == Post.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Post.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Post.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Post.change_thread(thread)
    end
  end
end
