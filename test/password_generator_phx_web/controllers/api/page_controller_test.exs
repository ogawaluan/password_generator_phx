defmodule PasswordGeneratorPhxWeb.Api.PageControllerTest do
  use PasswordGeneratorPhxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "generates a password" do
    test "generate password with only the length passed", %{conn: conn} do
      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), %{
          "length" => "5"
        })

      assert %{"password" => _pass} = json_response(conn, 200)
    end

    test "generate password with one option", %{conn: conn} do
      options = %{
        "length" => "5",
        "numbers" => "true"
      }

      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), options)

      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

  describe "returns errors" do
    test "error when no options", %{conn: conn} do
      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), %{})

      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when length is not integer", %{conn: conn} do
      options = %{
        "length" => "false"
      }

      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), options)

      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when options is not booleans", %{conn: conn} do
      options = %{
        "length" => "5",
        "numbers" => "5"
      }

      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), options)

      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when not valid options", %{conn: conn} do
      options = %{
        "length" => "5",
        "invalid" => "invalid"
      }

      conn =
        post(conn, PasswordGeneratorPhxWeb.Router.Helpers.page_path(conn, :api_generate), options)

      assert %{"error" => _error} = json_response(conn, 200)
    end
  end
end
