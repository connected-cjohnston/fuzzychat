defmodule FuzzychatWeb.RoomLive do
  @moduledoc """
  Functions for creating and managing chat rooms
  """
  use FuzzychatWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>FuzzyChat Rooms</h1>
    <p>Chat rooms will go here, eventually...</p>
    """
  end
end
