defmodule PasswordGeneratorPhx.Repo do
  use Ecto.Repo,
    otp_app: :password_generator_phx,
    adapter: Ecto.Adapters.Postgres
end
