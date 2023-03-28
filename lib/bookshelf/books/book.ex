defmodule Bookshelf.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :description, :string
    field :title, :string

    many_to_many :authors, Bookshelf.Authors.Author,
      join_through: Bookshelf.BooksAuthors,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
    |> put_assoc(:authors, attrs["authors"])
  end
end
