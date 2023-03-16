defmodule Bookshelf.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
