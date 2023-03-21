defmodule Bookshelf.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :name, :string

    many_to_many :books, Bookshelf.Books.Book, join_through: Bookshelf.BooksAuthors

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
