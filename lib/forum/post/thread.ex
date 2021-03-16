defmodule Forum.Post.Thread do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forum.Post.Comment

  schema "threads" do
    field :body, :string
    field :name, :string
    field :title, :string
    has_many :replies, Comment

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:name, :title, :body])
    |> validate_required([:name, :title, :body])
  end
end
