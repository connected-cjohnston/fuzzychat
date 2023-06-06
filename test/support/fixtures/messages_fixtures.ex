defmodule Fuzzychat.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fuzzychat.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        message: "some message",
        room_id: 42,
        user_id: 42
      })
      |> Fuzzychat.Messages.create_message()

    message
  end
end
