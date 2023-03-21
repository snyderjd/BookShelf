defmodule Bookshelf.BooksAuthors do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books_authors" do

    field :book_id, :id
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(books_authors, attrs) do
    books_authors
    |> cast(attrs, [])
    |> validate_required([])
  end
end
