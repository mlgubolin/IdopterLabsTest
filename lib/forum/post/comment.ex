defmodule Forum.Post.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forum.Post.Thread

  schema "comments" do
    field :name, :string
    field :reply, :string
    belongs_to :thread, Thread

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :reply, :thread_id])
    |> validate_required([:name, :reply, :thread_id])
  end
end
