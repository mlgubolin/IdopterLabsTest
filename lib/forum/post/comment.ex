defmodule Forum.Post.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :name, :string
    field :reply, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :reply])
    |> validate_required([:name, :reply])
  end
end
