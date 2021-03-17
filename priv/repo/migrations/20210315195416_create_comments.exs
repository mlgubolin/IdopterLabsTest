defmodule Forum.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :name, :string
      add :reply, :string

      timestamps()
    end
  end
end
