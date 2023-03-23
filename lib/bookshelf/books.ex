defmodule Bookshelf.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Bookshelf.{Authors, Repo}

  alias Bookshelf.Books.Book

  @doc """
  Returns the list of books.
  ## Examples
      iex> list_books()
      [%Book{}, ...]
  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.
  Raises `Ecto.NoResultsError` if the Book does not exist.
  ## Examples
      iex> get_book!(123)
      %Book{}
      iex> get_book!(456)
      ** (Ecto.NoResultsError)
  """
  def get_book!(id) do
    Book
    |> preload(:authors)
    |> Repo.get!(id)
  end

  @doc """
  Creates a book.
  ## Examples
      iex> create_book(%{field: value})
      {:ok, %Book{}}
      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.
  ## Examples
      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}
      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_book(%Book{} = book, attrs) do
    selected_author_ids =
      attrs["authors"]
      |> Enum.map(fn string -> String.to_integer(string) end)

    selected_authors =
      Authors.list_authors()
      |> Enum.filter(fn author -> author.id in selected_author_ids end)

    updated_attrs = Map.put(attrs, "authors", selected_authors)

    book
    |> Repo.preload(:authors)
    |> Book.changeset(updated_attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.
  ## Examples
      iex> delete_book(book)
      {:ok, %Book{}}
      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}
  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.
  ## Examples
      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}
  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
