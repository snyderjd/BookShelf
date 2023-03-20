defmodule BookshelfWeb.AuthorLive.FormComponent do
  use BookshelfWeb, :live_component

  alias Bookshelf.Authors

  @impl true
  def update(%{author: author} = assigns, socket) do
    changeset = Authors.change_author(author)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"author" => author_params}, socket) do
    changeset =
      socket.assigns.author
      |> Authors.change_author(author_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"author" => author_params}, socket) do
    save_author(socket, socket.assigns.action, author_params)
  end

  defp save_author(socket, :edit, author_params) do
    case Authors.update_author(socket.assigns.author, author_params) do
      {:ok, _author} ->
        {:noreply,
         socket
         |> put_flash(:info, "Author updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_author(socket, :new, author_params) do
    case Authors.create_author(author_params) do
      {:ok, _author} ->
        {:noreply,
         socket
         |> put_flash(:info, "Author created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
