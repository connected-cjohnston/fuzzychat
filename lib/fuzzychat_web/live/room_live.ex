defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """
  require Logger

  use FuzzychatWeb, :live_view

  def mount(_params, _session, socket) do
    rooms = ["General", "Games", "Cats"]
    messages = ["this is a message", "this is another message"]

    {:ok, assign(socket, rooms: rooms, messages: messages)}
  end

  def handle_event("send-message", %{"message" => message}, socket) do
    {:noreply, assign(socket, :messages, socket.assigns.messages ++ [message])}
  end
end
