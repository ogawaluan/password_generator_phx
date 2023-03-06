defmodule PasswordGeneratorPhxWeb.PageController do
  use PasswordGeneratorPhxWeb, :controller

  def home(conn, _params, password_lengths) do
    # The home page is often custom made,
    # so skip the default app layout.

    conn
    |> assign(:password_lengths, password_lengths)
    |> assign(:password, "")
    |> render(:home)
  end

  def generate(
        conn,
        %{
          "password_length" => password_length,
          "uppercase" => uppercase,
          "symbols" => symbols
        },
        password_lengths
      ) do
    password_params = %{
      "length" => password_length,
      "uppercase" => uppercase,
      "symbols" => symbols
    }

    {:ok, password} = PassGenerator.generate(password_params)

    render(conn, :home, password_lengths: password_lengths, password: password, layout: false)
  end

  def action(conn, _params) do
    password_lengths = [
      Weak: Enum.map(6..15, & &1),
      Strong: Enum.map(16..88, & &1),
      Unbelievible: [100, 150]
    ]

    args = [conn, conn.params, password_lengths]
    apply(__MODULE__, action_name(conn), args)
  end
end
