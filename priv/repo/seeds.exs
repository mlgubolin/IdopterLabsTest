# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Forum.Repo.insert!(%Forum.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Forum.Repo
alias Forum.Post.Thread
alias Forum.Post.Comment

  Repo.insert! %Thread{
    title: "Phoenix Framework",
    name: "aaaa",
    body: "hgufsahfiadshfisdahfdush",
    replies: [%Comment{name: "bbbb", reply: "hfdisahfuidghfu"}]
  }
