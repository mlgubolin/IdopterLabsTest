defmodule Forum.Post.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :body, :string
    field :name, :string
    field :title, :string
    field :comments, :id

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:name, :title, :body])
    |> validate_required([:name, :title, :body])
  end
end
