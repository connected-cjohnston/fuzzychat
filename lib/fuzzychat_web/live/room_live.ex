defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """
  require Logger

  use FuzzychatWeb, :live_view

  alias Fuzzychat.Rooms
  # alias Fuzzychat.Rooms.Room

  def mount(_params, _session, socket) do
    rooms = Rooms.list_rooms() |> Enum.sort(&(&1.name <= &2.name))
    selected_room = Enum.find(rooms, fn room -> room.name == "General" end)
    messages = []

    {:ok,
     assign(socket,
       rooms: rooms,
       messages: messages,
       selected_room: selected_room,
       new_room: false
     )}
  end

  def handle_event("send-message", %{"message" => message}, socket) do
    {:noreply, assign(socket, :messages, socket.assigns.messages ++ [message])}
  end

  def handle_event("new-room", _, socket) do
    {:noreply, assign(socket, :new_room, true)}
  end

  def handle_event("create-room", %{"room_name" => room_name}, socket) do
    Rooms.create_room(%{"name" => room_name})

    rooms = Rooms.list_rooms() |> Enum.sort(&(&1.name <= &2.name))

    {:noreply, assign(socket, rooms: rooms, new_room: false, selected_room: room_name)}
  end
end
