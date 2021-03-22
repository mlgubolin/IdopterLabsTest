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

Repo.insert!(%Thread{
  title: "Lorem Ipsum",
  name: "John",
  body:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  replies: [
    %Comment{
      name: "Mary",
      reply: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor..."
    },
    %Comment{
      name: "Ana",
      reply:
        "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi..."
    },
    %Comment{
      name: "Vera",
      reply:
        "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
    }
  ]
})

Repo.insert!(%Thread{
  title: "Another Thread",
  name: "John",
  body:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut ...",
  replies: [
    %Comment{
      name: "Mary",
      reply: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor..."
    },
    %Comment{
      name: "Ana",
      reply:
        "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi..."
    },
    %Comment{
      name: "Vera",
      reply:
        "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
    }
  ]
})
