defmodule Fuzzychat.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Fuzzychat.Repo

  alias Fuzzychat.Messages.Message

  def subscribe do
    Phoenix.PubSub.subscribe(Fuzzychat.PubSub, "messages")
  end

  def broadcast(message) do
    Phoenix.PubSub.broadcast(Fuzzychat.PubSub, "messages", message)
  end

  @doc """
  Returns the list of messages sorted by inserted_at date.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(from m in Message, order_by: [asc: m.inserted_at])
  end

  @doc """
  Returns the list of messages for a specific room sorted by inserted_at date

  ### Examples

      iex> list_messages_for_room(1)
      [%Message{}, ...]

  """
  def list_messages_for_room(room_id) do
    Repo.all(from m in Message, where: m.room_id == ^room_id, order_by: [asc: m.inserted_at])
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    {:ok, message} =
      %Message{}
      |> Message.changeset(attrs)
      |> Repo.insert()

    broadcast({:message_created, message})

    {:ok, message}
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
