defmodule VideosLiveviewWeb.PageController do
  use VideosLiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
