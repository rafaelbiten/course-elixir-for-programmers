defmodule ClientHtmlWeb.PageController do
  use ClientHtmlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
