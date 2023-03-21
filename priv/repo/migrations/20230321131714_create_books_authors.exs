defmodule Bookshelf.Repo.Migrations.CreateBooksAuthors do
  use Ecto.Migration

  def change do
    create table(:books_authors) do
      add :book_id, references(:books, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:books_authors, [:book_id])
    create index(:books_authors, [:author_id])
    create unique_index(:books_authors, [:book_id, :author_id])
  end
end
