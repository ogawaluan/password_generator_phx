defmodule PasswordGeneratorPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PasswordGeneratorPhxWeb.Telemetry,
      # Start the Ecto repository
      PasswordGeneratorPhx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PasswordGeneratorPhx.PubSub},
      # Start Finch
      {Finch, name: PasswordGeneratorPhx.Finch},
      # Start the Endpoint (http/https)
      PasswordGeneratorPhxWeb.Endpoint
      # Start a worker by calling: PasswordGeneratorPhx.Worker.start_link(arg)
      # {PasswordGeneratorPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PasswordGeneratorPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PasswordGeneratorPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
