defmodule Fuzzychat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FuzzychatWeb.Telemetry,
      # Start the Ecto repository
      Fuzzychat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fuzzychat.PubSub},
      # Start Finch
      {Finch, name: Fuzzychat.Finch},
      # Start the Endpoint (http/https)
      FuzzychatWeb.Endpoint
      # Start a worker by calling: Fuzzychat.Worker.start_link(arg)
      # {Fuzzychat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fuzzychat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FuzzychatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
