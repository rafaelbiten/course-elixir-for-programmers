defmodule ClientHtml.Impl.PageController do
  use ClientHtml.Impl, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
