defmodule VideosLiveview.Repo do
  use Ecto.Repo,
    otp_app: :videos_liveview,
    adapter: Ecto.Adapters.MyXQL
end
