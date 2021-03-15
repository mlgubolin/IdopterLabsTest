defmodule Forum.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :name, :string
      add :title, :string
      add :body, :string
      add :comments, references(:comment, on_delete: :nothing)

      timestamps()
    end

    create index(:threads, [:comments])
  end
end