defmodule ForumWeb.PageView do
  use ForumWeb, :view

  def number_of_replies(thread) do
    thread =
      thread
      |> Forum.Repo.preload(:replies)

    if length(thread.replies) > 1 do
      "#{length(thread.replies)} replies"
    else
      "#{length(thread.replies)} reply"
    end
  end
end
