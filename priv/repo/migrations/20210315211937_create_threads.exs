defmodule Forum.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :name, :string
      add :title, :string
      add :body, :string

      timestamps()
    end

    alter table(:comments) do
      add :thread_id, references(:threads)
    end

    create index(:comments, [:thread_id])
  end
end
