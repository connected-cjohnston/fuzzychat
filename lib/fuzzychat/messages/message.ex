defmodule Fuzzychat.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :message, :string
    field :room_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :room_id, :user_id])
    |> validate_required([:message, :room_id, :user_id])
  end
end
