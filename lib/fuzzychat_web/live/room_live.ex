defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """
  require Logger

  use FuzzychatWeb, :live_view

  def mount(_params, _session, socket) do
    rooms = ["General"]
    messages = []
    selected_room = "General"

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
    Logger.info(room_name: room_name)
    rooms = Enum.sort([room_name | socket.assigns.rooms])

    {:noreply, assign(socket, rooms: rooms, new_room: false)}
  end
end
