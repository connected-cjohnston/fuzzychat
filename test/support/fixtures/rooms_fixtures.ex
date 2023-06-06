defmodule Fuzzychat.RoomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fuzzychat.Rooms` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Fuzzychat.Rooms.create_room()

    room
  end
end
