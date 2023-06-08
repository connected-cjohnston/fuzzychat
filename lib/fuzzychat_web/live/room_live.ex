defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """
  require Logger

  use FuzzychatWeb, :live_view

  alias Fuzzychat.Rooms
  alias Fuzzychat.Messages
  # alias Fuzzychat.Rooms.Room

  def mount(%{"room_id" => room_id}, _session, socket) do
    if connected?(socket) do
      Messages.subscribe()
    end

    rooms = Rooms.list_rooms() |> Enum.sort(&(&1.name <= &2.name))
    selected_room = Rooms.get_room!(room_id)
    messages = Messages.list_messages_for_room(selected_room.id)

    socket =
      socket
      |> stream(:messages, messages)
      |> assign(:rooms, rooms)
      |> assign(:selected_room, selected_room)
      |> assign(:new_room, false)

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Messages.subscribe()
    end

    rooms = Rooms.list_rooms() |> Enum.sort(&(&1.name <= &2.name))
    selected_room = Enum.find(rooms, fn room -> room.name == "General" end)
    messages = Messages.list_messages_for_room(selected_room.id)

    socket =
      socket
      |> stream(:messages, messages)
      |> assign(:rooms, rooms)
      |> assign(:selected_room, selected_room)
      |> assign(:new_room, false)

    {:ok, socket}
  end

  def handle_event("send-message", %{"message" => message}, socket) do
    {:ok, new_message} =
      Messages.create_message(%{message: message, room_id: socket.assigns.selected_room.id})

    socket = stream_insert(socket, :messages, new_message)
    {:noreply, socket}
  end

  def handle_event("new-room", _, socket) do
    {:noreply, assign(socket, :new_room, true)}
  end

  def handle_event("create-room", %{"room_name" => room_name}, socket) do
    Rooms.create_room(%{"name" => room_name})

    rooms = Rooms.list_rooms() |> Enum.sort(&(&1.name <= &2.name))

    {:noreply, assign(socket, rooms: rooms, new_room: false, selected_room: room_name)}
  end

  def handle_info({:message_created, message}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end
end
