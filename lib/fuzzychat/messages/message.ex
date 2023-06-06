defmodule Fuzzychat.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Fuzzychat.Rooms.Room

  schema "messages" do
    field :message, :string
    field :user_id, :integer
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :room_id, :user_id])
    |> validate_required([:message, :room_id])
  end
end
