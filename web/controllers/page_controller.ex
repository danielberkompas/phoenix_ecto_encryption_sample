defmodule Encryption.PageController do
  use Encryption.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
