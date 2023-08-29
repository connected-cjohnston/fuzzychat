defmodule Fuzzychat.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hex.API.User
  alias Fuzzychat.Rooms.Room
  alias Fuzzychat.Accounts.User

  schema "messages" do
    field :message, :string
    belongs_to :room, Room
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :room_id, :user_id])
    |> assoc_constraint(:room)
    |> validate_required([:message, :room_id, :user_id])
  end
end
