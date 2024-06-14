defmodule VideosLiveview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VideosLiveview.Repo,
      # Start the Telemetry supervisor
      VideosLiveviewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VideosLiveview.PubSub},
      # Start the Endpoint (http/https)
      VideosLiveviewWeb.Endpoint
      # Start a worker by calling: VideosLiveview.Worker.start_link(arg)
      # {VideosLiveview.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VideosLiveview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VideosLiveviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
