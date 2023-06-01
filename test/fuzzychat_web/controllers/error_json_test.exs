defmodule FuzzychatWeb.ErrorJSONTest do
  use FuzzychatWeb.ConnCase, async: true

  test "renders 404" do
    assert FuzzychatWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert FuzzychatWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
