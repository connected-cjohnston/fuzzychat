defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """

  use FuzzychatWeb, :live_view

  def mount(_params, _session, socket) do
    rooms = ["General", "Games", "Cats"]
    messages = ["this is a message", "this is another message"]

    {:ok, assign(socket, rooms: rooms, messages: messages)}
  end

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-7 divide-x divide-slate-400">
      <div class="col-span-1 bg-slate-400 p-4">
        <h2>Rooms</h2>
        <ul :for={room <- @rooms}>
          <li class={if room == "General", do: "selected"}><%= room %></li>
        </ul>
      </div>
      <div class="col-span-6 p-4 bg-gray-100">
        <div class="align-text-top">
          <h2>Chat</h2>
          <div :for={message <- @messages}>
            <p><%= message %></p>
          </div>
          <div class="mt-4 border rounded">
            <form phx-submit="send-message">
              <label for="message" class="block">Message</label>
              <textarea
                name="message"
                placeholder="Enter message here"
                class="rounded block w-full rounded-lg border-gray-300 focus:border-slate-400 focus:ring-slate-400 focus:ring-opacity-50"
              />
              <button class="rounded-lg bg-slate-500 py-1 px-5 mt-2 text-white hover:bg-slate-800 float-right">
                Submit
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("send-message", %{"message" => message}, socket) do
    {:noreply, assign(socket, :messages, [message | socket.assigns.messages])}
  end
end
