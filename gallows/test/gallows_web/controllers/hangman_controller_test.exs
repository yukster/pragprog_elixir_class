defmodule GallowsWeb.PageControllerTest do
  use GallowsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Hangman!"
  end

  test "POST /", %{conn: conn} do
    conn = post(conn, "/")
    assert html_response(conn, 200) =~ "svg id=\"drawing\""
  end
end
